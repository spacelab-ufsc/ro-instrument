#include <sys/stat.h>
#include <sys/mman.h>

#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define SYSFS_PATH_LEN        (128)
#define ID_STR_LEN            (32)
#define UIO_DEVICE_PATH_LEN   (32)
#define NUM_UIO_DEVICES       (32)
#define MAX_LINE_LENGTH       (256)
#define HEX_VALUE_LENGTH      (8)
// APB register definitions
#define MAP_SIZE              (4096)
#define BASE_ADDRESS          (0x4C000000)
#define OFFSET_REG0           (0x10)   // Read only register which contains 0xDEADBEEF
#define OFFSET_CTRL           (0x20)   // Read/write register

char uio_id_str[] = "fpga_lsram";
char sysfs_template[] = "/sys/class/uio/uio%d/%s";

/*****************************************/
/* function get_uio_device will return */
/* the uio device number */
/*************************************** */

int get_uio_device(char *id) {
    FILE *fp;
    int i;
    int len;
    char file_id[ID_STR_LEN];
    char sysfs_path[SYSFS_PATH_LEN];

    for (i = 0; i < NUM_UIO_DEVICES; i++) {
        snprintf(sysfs_path, SYSFS_PATH_LEN, sysfs_template, i, "name");
        fp = fopen(sysfs_path, "r");
        if (fp == NULL)
            break;

        fscanf(fp, "%32s", file_id);
        len = strlen(id);
        if (len > ID_STR_LEN - 1)
            len = ID_STR_LEN - 1;
        if (strncmp(file_id, id, len) == 0) {
            fclose(fp);
            return i;
        }
        fclose(fp);
    }

    return -1;
}

/*****************************************/
/* function get_hex_value_at_index will return hex instruction from program file */
/*************************************** */
int get_hex_value_at_index(const char *filename, size_t i, uint32_t *output_value) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        perror("Error opening file");
        return -1;
    }
    char line[MAX_LINE_LENGTH];
    size_t current_index = 0;
    
    if (fgets(line, sizeof(line), file) == NULL) {
        fclose(file);
        return -1;  // Return -1 if there's an issue reading the first line
    }

    // Read the file line by line
    while (fgets(line, sizeof(line), file)) {
        // Remove newline characters from the end of the line
        line[strcspn(line, "\r\n")] = '\0';

        // Tokenize and process the hex values
        char *token = strtok(line, " ");
        while (token != NULL) {
            // Check if current index matches the requested index
            if (current_index == i) {
                *output_value = strtoul(token, NULL, 16);
		if (*output_value == 0x00000000){
		fclose(file);
		return -1;
		}
                fclose(file);
                return 0;
            }

            current_index++;
            token = strtok(NULL, " ");
        }
    }

    // If we reach here, the index was not found
    fclose(file);
    return -1;
}
/*****************************************/
/* This function will access the APB control status register*/
/*************************************** */
int access_control_status(bool read_REG0, uint32_t control_value){
    
    int mem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (mem_fd == -1) {
        printf("Error: cannot open /dev/mem\n");
        return -1;
    }
    // Calculate the offset within the mapped region
    off_t offset = BASE_ADDRESS;
    size_t length = MAP_SIZE;

    void *mapped_base = mmap(NULL, length, PROT_READ | PROT_WRITE, MAP_SHARED, mem_fd, offset);
    if (mapped_base == MAP_FAILED) {
        perror("Failed to map memory");
        close(mem_fd);
        return -1;
    }
    // Read REG0 and verify if it contains 0xDEADBEEF
    uint32_t value = *((volatile uint32_t *)(mapped_base + OFFSET_REG0));
    if (read_REG0 == 1) {
        if (value == 0xdeadbeef) {
            printf("REG0 contains 0xDEADBEEF\n");
        } else {
            printf("REG0 does not contain 0xDEADBEEF\n");
        }
    }
    // Write control value to control status register
    *((volatile uint32_t *)(mapped_base + OFFSET_CTRL)) = control_value;
    value = *((volatile uint32_t *)(mapped_base + OFFSET_CTRL));
    if (value == control_value) {
        printf("Control-Status Value written successfully\n");
    } else {
        printf("Control-Status Value was not written to register.\n");
    }
}
/*****************************************/
/* function get_memory_size will return */
/* the uio device size */
/*************************************** */

uint32_t get_memory_size(char *sysfs_path, char *uio_device) {
    FILE *fp;
    uint32_t sz;

    /*
     * open the file that describes the memory range size.
     * this is set up by the reg property of the node in the device tree
     */
    fp = fopen(sysfs_path, "r");
    if (fp == NULL) {
        fprintf(stderr, "unable to determine size for %s\n", uio_device);
        exit(0);
    }

    fscanf(fp, "0x%016X", &sz);
    fclose(fp);
    return sz;
}

int main(int argc, char* argv[]) {
    const char *filename = "program_dump.hex";
    uint32_t hex_value;
    int retCode = 0;
    int uioFd_0, index = 0;
    char uio_device[UIO_DEVICE_PATH_LEN];
    char sysfs_path[SYSFS_PATH_LEN], d1;
    volatile uint32_t *mem_ptr0;
    uint32_t mmap_size;
    volatile uint32_t i = 0;

    printf("Locating device for %s\n", uio_id_str);
    index = get_uio_device(uio_id_str);
    if (index < 0) {
        fprintf(stderr, "can't locate uio device for %s\n", uio_id_str);
        return -1;
    }

    snprintf(uio_device, UIO_DEVICE_PATH_LEN, "/dev/uio%d", index);
    printf("Located %s\n", uio_device);

    uioFd_0 = open(uio_device, O_RDWR);
    if (uioFd_0 < 0) {
        fprintf(stderr, "cannot open %s: %s\n", uio_device, strerror(errno));
        return -1;
    } else {
        printf("Opened %s (r,w)\n", uio_device);
    }

    snprintf(sysfs_path, SYSFS_PATH_LEN, sysfs_template, index, "maps/map0/size");
    mmap_size = get_memory_size(sysfs_path, uio_device);
    if (mmap_size == 0) {
        fprintf(stderr, "bad memory size for %s\n", uio_device);
        return -1;
    }

    mem_ptr0 = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, uioFd_0, 0 * getpagesize());
    if (mem_ptr0 == MAP_FAILED) {
        fprintf(stderr, "Cannot mmap: %s\n", strerror(errno));
        close(uioFd_0);
        return -1;
    }

    while (1) {
        printf("\n\t# Choose one of the following options:\n");
        printf("\t1. Show current contents of the memory\n");
        printf("\t2. Write hex values from file to the memory\n");
        printf("\t3. Write zeroes to the memory\n");
        printf("\t4. Print size of memory\n");
        printf("\t5. Fill memory with 0xFFFFFFFF and verify\n");
        printf("\t6. Exit\n");
        printf("Enter your choice: ");
        scanf("%c%*c", &d1);

        if (d1 == '6') {
            break;
        } else if (d1 == '1') {
            printf("Current memory contents:\n");
            for (i = 0; i < (mmap_size / 4); i++) {
                if (i % 4 == 0) {
                    printf("\n0x%08X: ", i * 4);
                }
                printf("0x%08X ", *(mem_ptr0 + i));
            }
            printf("\n");
        } else if (d1 == '2') {
            printf("Writing hex values from file to memory...\n");
            access_control_status(0, 0x00000000);
            for (i = 0; i < (mmap_size / 4); i++) {
                int result = get_hex_value_at_index(filename, i, &hex_value);
                if (result == -1) { 
                   access_control_status(0, 0x00000001);
                    break;
                } else {
                   *(mem_ptr0 + i) = hex_value;
                }
            }
            printf("Hex values written.\n");
        } else if (d1 == '3') {
            printf("Writing zeroes to memory...\n");
            for (i = 0; i < (mmap_size / 4); i++) {
                *(mem_ptr0 + i) = 0;
            }
            printf("Zeroes written.\n");
        } else if (d1 == '4') {
            printf("Size of memory: 0x%x bytes (%u bytes)\n", mmap_size, mmap_size);
        } else if (d1 == '5') {
            printf("Filling memory with 0xFFFFFFFF and verifying...\n");
            for (i = 0; i < (mmap_size / 4); i++) {
                *(mem_ptr0 + i) = 0xFFFFFFFF;
            }
            printf("Memory filled. Verifying...\n");
            int verification_failed = 0;
            for (i = 0; i < (mmap_size / 4); i++) {
                if (*(mem_ptr0 + i) != 0xFFFFFFFF) {
                    printf("\n\n\r ***** LSRAM memory verification failed at address 0x%08X ***** \n\r", i * 4);
                    verification_failed = 1;
                    break;
                }
            }
            if (!verification_failed) {
                printf("\n\n\n**** LSRAM memory verification passed successfully *****\n");
            }
        } else {
            printf("Invalid option, please enter a number between 1 and 6\n");
        }
    }

    retCode = munmap((void*)mem_ptr0, mmap_size);
    if (retCode < 0) {
        fprintf(stderr, "Error unmapping memory: %s\n", strerror(errno));
    } else {
        printf("Unmapped %s\n", uio_device);
    }

    retCode = close(uioFd_0);
    if (retCode < 0) {
        fprintf(stderr, "Error closing file: %s\n", strerror(errno));
    } else {
        printf("Closed %s\n", uio_device);
    }

    return retCode;
}
