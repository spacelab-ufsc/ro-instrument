// CoreDDS Output Golden Test Vectors.
// Test run length = 510

`timescale 1 ns/100 ps

module dds_bhvTestVectOut (sample_num, goldSin, goldCos);
    parameter OUTPUT_BITS = 10;
  input [9:0] sample_num;
  output[OUTPUT_BITS-1:0] goldSin, goldCos;
  reg signed [OUTPUT_BITS-1:0] goldSin, goldCos;
  always @ (sample_num) 
    case (sample_num)
        0: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
        1: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
        2: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
        3: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
        4: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
        5: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
        6: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
        7: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
        8: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
        9: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       10: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       11: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       12: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       13: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       14: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       15: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       16: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       17: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       18: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       19: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       20: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       21: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       22: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       23: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       24: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       25: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       26: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       27: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       28: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       29: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       30: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       31: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       32: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       33: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       34: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       35: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       36: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       37: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       38: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       39: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       40: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       41: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       42: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       43: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       44: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       45: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       46: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       47: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       48: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       49: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       50: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       51: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       52: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       53: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       54: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       55: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       56: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       57: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       58: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       59: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       60: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       61: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       62: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       63: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       64: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       65: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       66: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       67: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       68: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       69: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       70: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       71: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       72: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       73: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       74: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       75: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       76: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       77: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       78: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       79: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       80: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       81: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       82: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       83: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       84: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       85: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       86: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       87: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       88: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       89: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       90: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       91: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       92: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       93: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       94: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       95: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       96: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       97: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       98: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
       99: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      100: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      101: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      102: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      103: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      104: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      105: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      106: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      107: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      108: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      109: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      110: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      111: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      112: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      113: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      114: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      115: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      116: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      117: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      118: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      119: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      120: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      121: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      122: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      123: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      124: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      125: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      126: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      127: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      128: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      129: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      130: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      131: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      132: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      133: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      134: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      135: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      136: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      137: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      138: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      139: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      140: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      141: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      142: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      143: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      144: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      145: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      146: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      147: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      148: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      149: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      150: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      151: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      152: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      153: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      154: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      155: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      156: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      157: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      158: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      159: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      160: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      161: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      162: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      163: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      164: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      165: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      166: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      167: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      168: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      169: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      170: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      171: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      172: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      173: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      174: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      175: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      176: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      177: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      178: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      179: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      180: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      181: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      182: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      183: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      184: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      185: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      186: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      187: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      188: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      189: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      190: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      191: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      192: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      193: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      194: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      195: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      196: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      197: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      198: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      199: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      200: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      201: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      202: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      203: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      204: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      205: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      206: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      207: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      208: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      209: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      210: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      211: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      212: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      213: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      214: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      215: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      216: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      217: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      218: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      219: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      220: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      221: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      222: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      223: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      224: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      225: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      226: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      227: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      228: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      229: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      230: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      231: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      232: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      233: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      234: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      235: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      236: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      237: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      238: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      239: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      240: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      241: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      242: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      243: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      244: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      245: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      246: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      247: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      248: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      249: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      250: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      251: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      252: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      253: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      254: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      255: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      256: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      257: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      258: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      259: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      260: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      261: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      262: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      263: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      264: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      265: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      266: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      267: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      268: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      269: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      270: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      271: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      272: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      273: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      274: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      275: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      276: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      277: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      278: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      279: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      280: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      281: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      282: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      283: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      284: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      285: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      286: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      287: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      288: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      289: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      290: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      291: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      292: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      293: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      294: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      295: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      296: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      297: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      298: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      299: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      300: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      301: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      302: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      303: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      304: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      305: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      306: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      307: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      308: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      309: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      310: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      311: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      312: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      313: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      314: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      315: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      316: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      317: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      318: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      319: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      320: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      321: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      322: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      323: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      324: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      325: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      326: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      327: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      328: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      329: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      330: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      331: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      332: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      333: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      334: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      335: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      336: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      337: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      338: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      339: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      340: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      341: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      342: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      343: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      344: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      345: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      346: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      347: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      348: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      349: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      350: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      351: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      352: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      353: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      354: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      355: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      356: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      357: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      358: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      359: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      360: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      361: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      362: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      363: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      364: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      365: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      366: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      367: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      368: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      369: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      370: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      371: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      372: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      373: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      374: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      375: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      376: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      377: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      378: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      379: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      380: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      381: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      382: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      383: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      384: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      385: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      386: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      387: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      388: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      389: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      390: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      391: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      392: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      393: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      394: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      395: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      396: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      397: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      398: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      399: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      400: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      401: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      402: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      403: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      404: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      405: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      406: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      407: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      408: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      409: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      410: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      411: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      412: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      413: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      414: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      415: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      416: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      417: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      418: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      419: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      420: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      421: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      422: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      423: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      424: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      425: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      426: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      427: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      428: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      429: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      430: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      431: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      432: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      433: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      434: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      435: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      436: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      437: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      438: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      439: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      440: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      441: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      442: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      443: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      444: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      445: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      446: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      447: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      448: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      449: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      450: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      451: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      452: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      453: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      454: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      455: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      456: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      457: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      458: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      459: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      460: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      461: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      462: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      463: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      464: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      465: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      466: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      467: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      468: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      469: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      470: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      471: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      472: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      473: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      474: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      475: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      476: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      477: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      478: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      479: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      480: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      481: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      482: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      483: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      484: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      485: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      486: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      487: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      488: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      489: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      490: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      491: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      492: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      493: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      494: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      495: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      496: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      497: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      498: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      499: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      500: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      501: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      502: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      503: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      504: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      505: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      506: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      507: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      508: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
      509: begin
             goldSin =  4'd0;
             goldCos =  4'd4;
           end
  default: begin
             goldSin = 4'd0;
             goldCos = 4'd0;
           end
    endcase
endmodule
