read_sdc -scenario "timing_analysis" -netlist "optimized" -pin_separator "/" -ignore_errors {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/timing_analysis.sdc}
set_options -analysis_scenario "timing_analysis" 
save
set has_violations {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/DEFAULT_6BA5ED31DBDDB144872513_has_violations}
set fp [open $has_violations w]
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/DEFAULT_6BA5ED31DBDDB144872513_timing_constraints_coverage.xml} ]
puts $fp "_timing_constraints_coverage $coverage"
report \
    -type     combinational_loops \
    -format   xml \
    {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/DEFAULT_6BA5ED31DBDDB144872513_timing_combinational_loops.xml}
report_timing \
    -delay_type     max \
    -max_paths  1000 \
    -file      \
    {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/max_report.json}
report_timing \
    -delay_type     min \
    -max_paths  1000 \
    -file      \
    {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/min_report.json}
set_options -max_opcond slow_lv_lt -min_opcond slow_lv_lt
set max_timing_violations_slow_lv_lt "not_run"
puts $fp "_max_timing_violations_slow_lv_lt $max_timing_violations_slow_lv_lt"
set max_timing_slow_lv_lt "not_run"
puts $fp "_max_timing_slow_lv_lt $max_timing_slow_lv_lt"
set min_timing_violations_slow_lv_lt "not_run"
puts $fp "_min_timing_violations_slow_lv_lt $min_timing_violations_slow_lv_lt"
set min_timing_slow_lv_lt "not_run"
puts $fp "_min_timing_slow_lv_lt $min_timing_slow_lv_lt"
set_options -max_opcond fast_hv_lt -min_opcond fast_hv_lt
set max_timing_violations_fast_hv_lt "not_run"
puts $fp "_max_timing_violations_fast_hv_lt $max_timing_violations_fast_hv_lt"
set max_timing_fast_hv_lt "not_run"
puts $fp "_max_timing_fast_hv_lt $max_timing_fast_hv_lt"
set min_timing_violations_fast_hv_lt "not_run"
puts $fp "_min_timing_violations_fast_hv_lt $min_timing_violations_fast_hv_lt"
set min_timing_fast_hv_lt "not_run"
puts $fp "_min_timing_fast_hv_lt $min_timing_fast_hv_lt"
set_options -max_opcond slow_lv_ht -min_opcond slow_lv_ht
set max_timing_violations_slow_lv_ht "not_run"
puts $fp "_max_timing_violations_slow_lv_ht $max_timing_violations_slow_lv_ht"
set max_timing_slow_lv_ht "not_run"
puts $fp "_max_timing_slow_lv_ht $max_timing_slow_lv_ht"
set min_timing_violations_slow_lv_ht "not_run"
puts $fp "_min_timing_violations_slow_lv_ht $min_timing_violations_slow_lv_ht"
set min_timing_slow_lv_ht "not_run"
puts $fp "_min_timing_slow_lv_ht $min_timing_slow_lv_ht"
set max_timing_violations_multi_corner [report \
    -type     timing_violations \
    -analysis max \
    -format   xml \
    -multi_corner yes \
    -use_slack_threshold  yes \
    -slack_threshold  0.0 \
    -max_paths  20 \
    -max_expanded_paths  0 \
    -max_parallel_paths  1 \
    {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/DEFAULT_6BA5ED31DBDDB144872513_max_timing_violations_multi_corner.xml} ]
puts $fp "_max_timing_violations_multi_corner $max_timing_violations_multi_corner"
set max_timing_multi_corner [report \
    -type     timing \
    -analysis max \
    -format   xml \
    -multi_corner yes \
    -use_slack_threshold no \
    -slack_threshold  0.0 \
    -max_paths  5 \
    -max_expanded_paths  1 \
    -max_parallel_paths  1 \
    {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/DEFAULT_6BA5ED31DBDDB144872513_max_timing_multi_corner.xml} ]
puts $fp "_max_timing_multi_corner $max_timing_multi_corner"
set min_timing_violations_multi_corner [report \
    -type     timing_violations \
    -analysis min \
    -format   xml \
    -multi_corner yes \
    -use_slack_threshold  yes \
    -slack_threshold  0.0 \
    -max_paths  20 \
    -max_expanded_paths  0 \
    -max_parallel_paths  1 \
    {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/DEFAULT_6BA5ED31DBDDB144872513_min_timing_violations_multi_corner.xml} ]
puts $fp "_min_timing_violations_multi_corner $min_timing_violations_multi_corner"
set min_timing_multi_corner [report \
    -type     timing \
    -analysis min \
    -format   xml \
    -multi_corner yes \
    -use_slack_threshold no \
    -slack_threshold  0.0 \
    -max_paths  5 \
    -max_expanded_paths  1 \
    -max_parallel_paths  1 \
    {/home/arthur/Desktop/projects_gnss/beaglevfire-gnss/work/libero/designer/DEFAULT_6BA5ED31DBDDB144872513/DEFAULT_6BA5ED31DBDDB144872513_min_timing_multi_corner.xml} ]
puts $fp "_min_timing_multi_corner $min_timing_multi_corner"
close $fp
