/*
    TRIANGLE INFO (right triangle)
     |\
     | \ c
    a|_ \ 
     |_|_\
       b
    Angle connecting b and c is angle alpha (adjacent)
    Angle connecting a and c is angle beta (opposite)
    Angle connecting a and b is 90 degrees
*/
module get_triangle_sides #(
    parameter CORDW=32
) (
    input   logic signed [CORDW-1:0] angle,        // adjacent angle in degrees (alpha)
    input   logic signed [CORDW-1:0] hypotenuse,   // length of hypotenuse
    output  logic signed [CORDW-1:0] a,            // length of adjacent side A
    output  logic signed [CORDW-1:0] b,            // length of opposide side B
    output  logic signed [CORDW-1:0] c             // length of hypotenuse c
);
    generate
        assign c = hypotenuse;
        always_comb begin
            case (((angle < 0) ? -angle : angle) % 360)
                0: begin
                    a = hypotenuse * 0.000000;
                    b = hypotenuse * 1.000000;
                end
                1: begin
                    a = hypotenuse * 0.017452;
                    b = hypotenuse * 0.999848;
                end
                2: begin
                    a = hypotenuse * 0.034899;
                    b = hypotenuse * 0.999391;
                end
                3: begin
                    a = hypotenuse * 0.052336;
                    b = hypotenuse * 0.998630;
                end
                4: begin
                    a = hypotenuse * 0.069756;
                    b = hypotenuse * 0.997564;
                end
                5: begin
                    a = hypotenuse * 0.087156;
                    b = hypotenuse * 0.996195;
                end
                6: begin
                    a = hypotenuse * 0.104528;
                    b = hypotenuse * 0.994522;
                end
                7: begin
                    a = hypotenuse * 0.121869;
                    b = hypotenuse * 0.992546;
                end
                8: begin
                    a = hypotenuse * 0.139173;
                    b = hypotenuse * 0.990268;
                end
                9: begin
                    a = hypotenuse * 0.156434;
                    b = hypotenuse * 0.987688;
                end
                10: begin
                    a = hypotenuse * 0.173648;
                    b = hypotenuse * 0.984808;
                end
                11: begin
                    a = hypotenuse * 0.190809;
                    b = hypotenuse * 0.981627;
                end
                12: begin
                    a = hypotenuse * 0.207912;
                    b = hypotenuse * 0.978148;
                end
                13: begin
                    a = hypotenuse * 0.224951;
                    b = hypotenuse * 0.974370;
                end
                14: begin
                    a = hypotenuse * 0.241922;
                    b = hypotenuse * 0.970296;
                end
                15: begin
                    a = hypotenuse * 0.258819;
                    b = hypotenuse * 0.965926;
                end
                16: begin
                    a = hypotenuse * 0.275637;
                    b = hypotenuse * 0.961262;
                end
                17: begin
                    a = hypotenuse * 0.292372;
                    b = hypotenuse * 0.956305;
                end
                18: begin
                    a = hypotenuse * 0.309017;
                    b = hypotenuse * 0.951057;
                end
                19: begin
                    a = hypotenuse * 0.325568;
                    b = hypotenuse * 0.945519;
                end
                20: begin
                    a = hypotenuse * 0.342020;
                    b = hypotenuse * 0.939693;
                end
                21: begin
                    a = hypotenuse * 0.358368;
                    b = hypotenuse * 0.933580;
                end
                22: begin
                    a = hypotenuse * 0.374607;
                    b = hypotenuse * 0.927184;
                end
                23: begin
                    a = hypotenuse * 0.390731;
                    b = hypotenuse * 0.920505;
                end
                24: begin
                    a = hypotenuse * 0.406737;
                    b = hypotenuse * 0.913545;
                end
                25: begin
                    a = hypotenuse * 0.422618;
                    b = hypotenuse * 0.906308;
                end
                26: begin
                    a = hypotenuse * 0.438371;
                    b = hypotenuse * 0.898794;
                end
                27: begin
                    a = hypotenuse * 0.453990;
                    b = hypotenuse * 0.891007;
                end
                28: begin
                    a = hypotenuse * 0.469472;
                    b = hypotenuse * 0.882948;
                end
                29: begin
                    a = hypotenuse * 0.484810;
                    b = hypotenuse * 0.874620;
                end
                30: begin
                    a = hypotenuse * 0.500000;
                    b = hypotenuse * 0.866025;
                end
                31: begin
                    a = hypotenuse * 0.515038;
                    b = hypotenuse * 0.857167;
                end
                32: begin
                    a = hypotenuse * 0.529919;
                    b = hypotenuse * 0.848048;
                end
                33: begin
                    a = hypotenuse * 0.544639;
                    b = hypotenuse * 0.838671;
                end
                34: begin
                    a = hypotenuse * 0.559193;
                    b = hypotenuse * 0.829038;
                end
                35: begin
                    a = hypotenuse * 0.573576;
                    b = hypotenuse * 0.819152;
                end
                36: begin
                    a = hypotenuse * 0.587785;
                    b = hypotenuse * 0.809017;
                end
                37: begin
                    a = hypotenuse * 0.601815;
                    b = hypotenuse * 0.798636;
                end
                38: begin
                    a = hypotenuse * 0.615661;
                    b = hypotenuse * 0.788011;
                end
                39: begin
                    a = hypotenuse * 0.629320;
                    b = hypotenuse * 0.777146;
                end
                40: begin
                    a = hypotenuse * 0.642788;
                    b = hypotenuse * 0.766044;
                end
                41: begin
                    a = hypotenuse * 0.656059;
                    b = hypotenuse * 0.754710;
                end
                42: begin
                    a = hypotenuse * 0.669131;
                    b = hypotenuse * 0.743145;
                end
                43: begin
                    a = hypotenuse * 0.681998;
                    b = hypotenuse * 0.731354;
                end
                44: begin
                    a = hypotenuse * 0.694658;
                    b = hypotenuse * 0.719340;
                end
                45: begin
                    a = hypotenuse * 0.707107;
                    b = hypotenuse * 0.707107;
                end
                46: begin
                    a = hypotenuse * 0.719340;
                    b = hypotenuse * 0.694658;
                end
                47: begin
                    a = hypotenuse * 0.731354;
                    b = hypotenuse * 0.681998;
                end
                48: begin
                    a = hypotenuse * 0.743145;
                    b = hypotenuse * 0.669131;
                end
                49: begin
                    a = hypotenuse * 0.754710;
                    b = hypotenuse * 0.656059;
                end
                50: begin
                    a = hypotenuse * 0.766044;
                    b = hypotenuse * 0.642788;
                end
                51: begin
                    a = hypotenuse * 0.777146;
                    b = hypotenuse * 0.629320;
                end
                52: begin
                    a = hypotenuse * 0.788011;
                    b = hypotenuse * 0.615661;
                end
                53: begin
                    a = hypotenuse * 0.798636;
                    b = hypotenuse * 0.601815;
                end
                54: begin
                    a = hypotenuse * 0.809017;
                    b = hypotenuse * 0.587785;
                end
                55: begin
                    a = hypotenuse * 0.819152;
                    b = hypotenuse * 0.573576;
                end
                56: begin
                    a = hypotenuse * 0.829038;
                    b = hypotenuse * 0.559193;
                end
                57: begin
                    a = hypotenuse * 0.838671;
                    b = hypotenuse * 0.544639;
                end
                58: begin
                    a = hypotenuse * 0.848048;
                    b = hypotenuse * 0.529919;
                end
                59: begin
                    a = hypotenuse * 0.857167;
                    b = hypotenuse * 0.515038;
                end
                60: begin
                    a = hypotenuse * 0.866025;
                    b = hypotenuse * 0.500000;
                end
                61: begin
                    a = hypotenuse * 0.874620;
                    b = hypotenuse * 0.484810;
                end
                62: begin
                    a = hypotenuse * 0.882948;
                    b = hypotenuse * 0.469472;
                end
                63: begin
                    a = hypotenuse * 0.891007;
                    b = hypotenuse * 0.453990;
                end
                64: begin
                    a = hypotenuse * 0.898794;
                    b = hypotenuse * 0.438371;
                end
                65: begin
                    a = hypotenuse * 0.906308;
                    b = hypotenuse * 0.422618;
                end
                66: begin
                    a = hypotenuse * 0.913545;
                    b = hypotenuse * 0.406737;
                end
                67: begin
                    a = hypotenuse * 0.920505;
                    b = hypotenuse * 0.390731;
                end
                68: begin
                    a = hypotenuse * 0.927184;
                    b = hypotenuse * 0.374607;
                end
                69: begin
                    a = hypotenuse * 0.933580;
                    b = hypotenuse * 0.358368;
                end
                70: begin
                    a = hypotenuse * 0.939693;
                    b = hypotenuse * 0.342020;
                end
                71: begin
                    a = hypotenuse * 0.945519;
                    b = hypotenuse * 0.325568;
                end
                72: begin
                    a = hypotenuse * 0.951057;
                    b = hypotenuse * 0.309017;
                end
                73: begin
                    a = hypotenuse * 0.956305;
                    b = hypotenuse * 0.292372;
                end
                74: begin
                    a = hypotenuse * 0.961262;
                    b = hypotenuse * 0.275637;
                end
                75: begin
                    a = hypotenuse * 0.965926;
                    b = hypotenuse * 0.258819;
                end
                76: begin
                    a = hypotenuse * 0.970296;
                    b = hypotenuse * 0.241922;
                end
                77: begin
                    a = hypotenuse * 0.974370;
                    b = hypotenuse * 0.224951;
                end
                78: begin
                    a = hypotenuse * 0.978148;
                    b = hypotenuse * 0.207912;
                end
                79: begin
                    a = hypotenuse * 0.981627;
                    b = hypotenuse * 0.190809;
                end
                80: begin
                    a = hypotenuse * 0.984808;
                    b = hypotenuse * 0.173648;
                end
                81: begin
                    a = hypotenuse * 0.987688;
                    b = hypotenuse * 0.156434;
                end
                82: begin
                    a = hypotenuse * 0.990268;
                    b = hypotenuse * 0.139173;
                end
                83: begin
                    a = hypotenuse * 0.992546;
                    b = hypotenuse * 0.121869;
                end
                84: begin
                    a = hypotenuse * 0.994522;
                    b = hypotenuse * 0.104528;
                end
                85: begin
                    a = hypotenuse * 0.996195;
                    b = hypotenuse * 0.087156;
                end
                86: begin
                    a = hypotenuse * 0.997564;
                    b = hypotenuse * 0.069756;
                end
                87: begin
                    a = hypotenuse * 0.998630;
                    b = hypotenuse * 0.052336;
                end
                88: begin
                    a = hypotenuse * 0.999391;
                    b = hypotenuse * 0.034899;
                end
                89: begin
                    a = hypotenuse * 0.999848;
                    b = hypotenuse * 0.017452;
                end
                90: begin
                    a = hypotenuse * 1.000000;
                    b = hypotenuse * 0.000000;
                end
                91: begin
                    a = hypotenuse * 0.999848;
                    b = hypotenuse * -0.017452;
                end
                92: begin
                    a = hypotenuse * 0.999391;
                    b = hypotenuse * -0.034899;
                end
                93: begin
                    a = hypotenuse * 0.998630;
                    b = hypotenuse * -0.052336;
                end
                94: begin
                    a = hypotenuse * 0.997564;
                    b = hypotenuse * -0.069756;
                end
                95: begin
                    a = hypotenuse * 0.996195;
                    b = hypotenuse * -0.087156;
                end
                96: begin
                    a = hypotenuse * 0.994522;
                    b = hypotenuse * -0.104528;
                end
                97: begin
                    a = hypotenuse * 0.992546;
                    b = hypotenuse * -0.121869;
                end
                98: begin
                    a = hypotenuse * 0.990268;
                    b = hypotenuse * -0.139173;
                end
                99: begin
                    a = hypotenuse * 0.987688;
                    b = hypotenuse * -0.156434;
                end
                100: begin
                    a = hypotenuse * 0.984808;
                    b = hypotenuse * -0.173648;
                end
                101: begin
                    a = hypotenuse * 0.981627;
                    b = hypotenuse * -0.190809;
                end
                102: begin
                    a = hypotenuse * 0.978148;
                    b = hypotenuse * -0.207912;
                end
                103: begin
                    a = hypotenuse * 0.974370;
                    b = hypotenuse * -0.224951;
                end
                104: begin
                    a = hypotenuse * 0.970296;
                    b = hypotenuse * -0.241922;
                end
                105: begin
                    a = hypotenuse * 0.965926;
                    b = hypotenuse * -0.258819;
                end
                106: begin
                    a = hypotenuse * 0.961262;
                    b = hypotenuse * -0.275637;
                end
                107: begin
                    a = hypotenuse * 0.956305;
                    b = hypotenuse * -0.292372;
                end
                108: begin
                    a = hypotenuse * 0.951057;
                    b = hypotenuse * -0.309017;
                end
                109: begin
                    a = hypotenuse * 0.945519;
                    b = hypotenuse * -0.325568;
                end
                110: begin
                    a = hypotenuse * 0.939693;
                    b = hypotenuse * -0.342020;
                end
                111: begin
                    a = hypotenuse * 0.933580;
                    b = hypotenuse * -0.358368;
                end
                112: begin
                    a = hypotenuse * 0.927184;
                    b = hypotenuse * -0.374607;
                end
                113: begin
                    a = hypotenuse * 0.920505;
                    b = hypotenuse * -0.390731;
                end
                114: begin
                    a = hypotenuse * 0.913545;
                    b = hypotenuse * -0.406737;
                end
                115: begin
                    a = hypotenuse * 0.906308;
                    b = hypotenuse * -0.422618;
                end
                116: begin
                    a = hypotenuse * 0.898794;
                    b = hypotenuse * -0.438371;
                end
                117: begin
                    a = hypotenuse * 0.891007;
                    b = hypotenuse * -0.453990;
                end
                118: begin
                    a = hypotenuse * 0.882948;
                    b = hypotenuse * -0.469472;
                end
                119: begin
                    a = hypotenuse * 0.874620;
                    b = hypotenuse * -0.484810;
                end
                120: begin
                    a = hypotenuse * 0.866025;
                    b = hypotenuse * -0.500000;
                end
                121: begin
                    a = hypotenuse * 0.857167;
                    b = hypotenuse * -0.515038;
                end
                122: begin
                    a = hypotenuse * 0.848048;
                    b = hypotenuse * -0.529919;
                end
                123: begin
                    a = hypotenuse * 0.838671;
                    b = hypotenuse * -0.544639;
                end
                124: begin
                    a = hypotenuse * 0.829038;
                    b = hypotenuse * -0.559193;
                end
                125: begin
                    a = hypotenuse * 0.819152;
                    b = hypotenuse * -0.573576;
                end
                126: begin
                    a = hypotenuse * 0.809017;
                    b = hypotenuse * -0.587785;
                end
                127: begin
                    a = hypotenuse * 0.798636;
                    b = hypotenuse * -0.601815;
                end
                128: begin
                    a = hypotenuse * 0.788011;
                    b = hypotenuse * -0.615661;
                end
                129: begin
                    a = hypotenuse * 0.777146;
                    b = hypotenuse * -0.629320;
                end
                130: begin
                    a = hypotenuse * 0.766044;
                    b = hypotenuse * -0.642788;
                end
                131: begin
                    a = hypotenuse * 0.754710;
                    b = hypotenuse * -0.656059;
                end
                132: begin
                    a = hypotenuse * 0.743145;
                    b = hypotenuse * -0.669131;
                end
                133: begin
                    a = hypotenuse * 0.731354;
                    b = hypotenuse * -0.681998;
                end
                134: begin
                    a = hypotenuse * 0.719340;
                    b = hypotenuse * -0.694658;
                end
                135: begin
                    a = hypotenuse * 0.707107;
                    b = hypotenuse * -0.707107;
                end
                136: begin
                    a = hypotenuse * 0.694658;
                    b = hypotenuse * -0.719340;
                end
                137: begin
                    a = hypotenuse * 0.681998;
                    b = hypotenuse * -0.731354;
                end
                138: begin
                    a = hypotenuse * 0.669131;
                    b = hypotenuse * -0.743145;
                end
                139: begin
                    a = hypotenuse * 0.656059;
                    b = hypotenuse * -0.754710;
                end
                140: begin
                    a = hypotenuse * 0.642788;
                    b = hypotenuse * -0.766044;
                end
                141: begin
                    a = hypotenuse * 0.629320;
                    b = hypotenuse * -0.777146;
                end
                142: begin
                    a = hypotenuse * 0.615661;
                    b = hypotenuse * -0.788011;
                end
                143: begin
                    a = hypotenuse * 0.601815;
                    b = hypotenuse * -0.798636;
                end
                144: begin
                    a = hypotenuse * 0.587785;
                    b = hypotenuse * -0.809017;
                end
                145: begin
                    a = hypotenuse * 0.573576;
                    b = hypotenuse * -0.819152;
                end
                146: begin
                    a = hypotenuse * 0.559193;
                    b = hypotenuse * -0.829038;
                end
                147: begin
                    a = hypotenuse * 0.544639;
                    b = hypotenuse * -0.838671;
                end
                148: begin
                    a = hypotenuse * 0.529919;
                    b = hypotenuse * -0.848048;
                end
                149: begin
                    a = hypotenuse * 0.515038;
                    b = hypotenuse * -0.857167;
                end
                150: begin
                    a = hypotenuse * 0.500000;
                    b = hypotenuse * -0.866025;
                end
                151: begin
                    a = hypotenuse * 0.484810;
                    b = hypotenuse * -0.874620;
                end
                152: begin
                    a = hypotenuse * 0.469472;
                    b = hypotenuse * -0.882948;
                end
                153: begin
                    a = hypotenuse * 0.453990;
                    b = hypotenuse * -0.891007;
                end
                154: begin
                    a = hypotenuse * 0.438371;
                    b = hypotenuse * -0.898794;
                end
                155: begin
                    a = hypotenuse * 0.422618;
                    b = hypotenuse * -0.906308;
                end
                156: begin
                    a = hypotenuse * 0.406737;
                    b = hypotenuse * -0.913545;
                end
                157: begin
                    a = hypotenuse * 0.390731;
                    b = hypotenuse * -0.920505;
                end
                158: begin
                    a = hypotenuse * 0.374607;
                    b = hypotenuse * -0.927184;
                end
                159: begin
                    a = hypotenuse * 0.358368;
                    b = hypotenuse * -0.933580;
                end
                160: begin
                    a = hypotenuse * 0.342020;
                    b = hypotenuse * -0.939693;
                end
                161: begin
                    a = hypotenuse * 0.325568;
                    b = hypotenuse * -0.945519;
                end
                162: begin
                    a = hypotenuse * 0.309017;
                    b = hypotenuse * -0.951057;
                end
                163: begin
                    a = hypotenuse * 0.292372;
                    b = hypotenuse * -0.956305;
                end
                164: begin
                    a = hypotenuse * 0.275637;
                    b = hypotenuse * -0.961262;
                end
                165: begin
                    a = hypotenuse * 0.258819;
                    b = hypotenuse * -0.965926;
                end
                166: begin
                    a = hypotenuse * 0.241922;
                    b = hypotenuse * -0.970296;
                end
                167: begin
                    a = hypotenuse * 0.224951;
                    b = hypotenuse * -0.974370;
                end
                168: begin
                    a = hypotenuse * 0.207912;
                    b = hypotenuse * -0.978148;
                end
                169: begin
                    a = hypotenuse * 0.190809;
                    b = hypotenuse * -0.981627;
                end
                170: begin
                    a = hypotenuse * 0.173648;
                    b = hypotenuse * -0.984808;
                end
                171: begin
                    a = hypotenuse * 0.156434;
                    b = hypotenuse * -0.987688;
                end
                172: begin
                    a = hypotenuse * 0.139173;
                    b = hypotenuse * -0.990268;
                end
                173: begin
                    a = hypotenuse * 0.121869;
                    b = hypotenuse * -0.992546;
                end
                174: begin
                    a = hypotenuse * 0.104528;
                    b = hypotenuse * -0.994522;
                end
                175: begin
                    a = hypotenuse * 0.087156;
                    b = hypotenuse * -0.996195;
                end
                176: begin
                    a = hypotenuse * 0.069756;
                    b = hypotenuse * -0.997564;
                end
                177: begin
                    a = hypotenuse * 0.052336;
                    b = hypotenuse * -0.998630;
                end
                178: begin
                    a = hypotenuse * 0.034899;
                    b = hypotenuse * -0.999391;
                end
                179: begin
                    a = hypotenuse * 0.017452;
                    b = hypotenuse * -0.999848;
                end
                180: begin
                    a = hypotenuse * 0.000000;
                    b = hypotenuse * -1.000000;
                end
                181: begin
                    a = hypotenuse * -0.017452;
                    b = hypotenuse * -0.999848;
                end
                182: begin
                    a = hypotenuse * -0.034899;
                    b = hypotenuse * -0.999391;
                end
                183: begin
                    a = hypotenuse * -0.052336;
                    b = hypotenuse * -0.998630;
                end
                184: begin
                    a = hypotenuse * -0.069756;
                    b = hypotenuse * -0.997564;
                end
                185: begin
                    a = hypotenuse * -0.087156;
                    b = hypotenuse * -0.996195;
                end
                186: begin
                    a = hypotenuse * -0.104528;
                    b = hypotenuse * -0.994522;
                end
                187: begin
                    a = hypotenuse * -0.121869;
                    b = hypotenuse * -0.992546;
                end
                188: begin
                    a = hypotenuse * -0.139173;
                    b = hypotenuse * -0.990268;
                end
                189: begin
                    a = hypotenuse * -0.156434;
                    b = hypotenuse * -0.987688;
                end
                190: begin
                    a = hypotenuse * -0.173648;
                    b = hypotenuse * -0.984808;
                end
                191: begin
                    a = hypotenuse * -0.190809;
                    b = hypotenuse * -0.981627;
                end
                192: begin
                    a = hypotenuse * -0.207912;
                    b = hypotenuse * -0.978148;
                end
                193: begin
                    a = hypotenuse * -0.224951;
                    b = hypotenuse * -0.974370;
                end
                194: begin
                    a = hypotenuse * -0.241922;
                    b = hypotenuse * -0.970296;
                end
                195: begin
                    a = hypotenuse * -0.258819;
                    b = hypotenuse * -0.965926;
                end
                196: begin
                    a = hypotenuse * -0.275637;
                    b = hypotenuse * -0.961262;
                end
                197: begin
                    a = hypotenuse * -0.292372;
                    b = hypotenuse * -0.956305;
                end
                198: begin
                    a = hypotenuse * -0.309017;
                    b = hypotenuse * -0.951057;
                end
                199: begin
                    a = hypotenuse * -0.325568;
                    b = hypotenuse * -0.945519;
                end
                200: begin
                    a = hypotenuse * -0.342020;
                    b = hypotenuse * -0.939693;
                end
                201: begin
                    a = hypotenuse * -0.358368;
                    b = hypotenuse * -0.933580;
                end
                202: begin
                    a = hypotenuse * -0.374607;
                    b = hypotenuse * -0.927184;
                end
                203: begin
                    a = hypotenuse * -0.390731;
                    b = hypotenuse * -0.920505;
                end
                204: begin
                    a = hypotenuse * -0.406737;
                    b = hypotenuse * -0.913545;
                end
                205: begin
                    a = hypotenuse * -0.422618;
                    b = hypotenuse * -0.906308;
                end
                206: begin
                    a = hypotenuse * -0.438371;
                    b = hypotenuse * -0.898794;
                end
                207: begin
                    a = hypotenuse * -0.453990;
                    b = hypotenuse * -0.891007;
                end
                208: begin
                    a = hypotenuse * -0.469472;
                    b = hypotenuse * -0.882948;
                end
                209: begin
                    a = hypotenuse * -0.484810;
                    b = hypotenuse * -0.874620;
                end
                210: begin
                    a = hypotenuse * -0.500000;
                    b = hypotenuse * -0.866025;
                end
                211: begin
                    a = hypotenuse * -0.515038;
                    b = hypotenuse * -0.857167;
                end
                212: begin
                    a = hypotenuse * -0.529919;
                    b = hypotenuse * -0.848048;
                end
                213: begin
                    a = hypotenuse * -0.544639;
                    b = hypotenuse * -0.838671;
                end
                214: begin
                    a = hypotenuse * -0.559193;
                    b = hypotenuse * -0.829038;
                end
                215: begin
                    a = hypotenuse * -0.573576;
                    b = hypotenuse * -0.819152;
                end
                216: begin
                    a = hypotenuse * -0.587785;
                    b = hypotenuse * -0.809017;
                end
                217: begin
                    a = hypotenuse * -0.601815;
                    b = hypotenuse * -0.798636;
                end
                218: begin
                    a = hypotenuse * -0.615661;
                    b = hypotenuse * -0.788011;
                end
                219: begin
                    a = hypotenuse * -0.629320;
                    b = hypotenuse * -0.777146;
                end
                220: begin
                    a = hypotenuse * -0.642788;
                    b = hypotenuse * -0.766044;
                end
                221: begin
                    a = hypotenuse * -0.656059;
                    b = hypotenuse * -0.754710;
                end
                222: begin
                    a = hypotenuse * -0.669131;
                    b = hypotenuse * -0.743145;
                end
                223: begin
                    a = hypotenuse * -0.681998;
                    b = hypotenuse * -0.731354;
                end
                224: begin
                    a = hypotenuse * -0.694658;
                    b = hypotenuse * -0.719340;
                end
                225: begin
                    a = hypotenuse * -0.707107;
                    b = hypotenuse * -0.707107;
                end
                226: begin
                    a = hypotenuse * -0.719340;
                    b = hypotenuse * -0.694658;
                end
                227: begin
                    a = hypotenuse * -0.731354;
                    b = hypotenuse * -0.681998;
                end
                228: begin
                    a = hypotenuse * -0.743145;
                    b = hypotenuse * -0.669131;
                end
                229: begin
                    a = hypotenuse * -0.754710;
                    b = hypotenuse * -0.656059;
                end
                230: begin
                    a = hypotenuse * -0.766044;
                    b = hypotenuse * -0.642788;
                end
                231: begin
                    a = hypotenuse * -0.777146;
                    b = hypotenuse * -0.629320;
                end
                232: begin
                    a = hypotenuse * -0.788011;
                    b = hypotenuse * -0.615661;
                end
                233: begin
                    a = hypotenuse * -0.798636;
                    b = hypotenuse * -0.601815;
                end
                234: begin
                    a = hypotenuse * -0.809017;
                    b = hypotenuse * -0.587785;
                end
                235: begin
                    a = hypotenuse * -0.819152;
                    b = hypotenuse * -0.573576;
                end
                236: begin
                    a = hypotenuse * -0.829038;
                    b = hypotenuse * -0.559193;
                end
                237: begin
                    a = hypotenuse * -0.838671;
                    b = hypotenuse * -0.544639;
                end
                238: begin
                    a = hypotenuse * -0.848048;
                    b = hypotenuse * -0.529919;
                end
                239: begin
                    a = hypotenuse * -0.857167;
                    b = hypotenuse * -0.515038;
                end
                240: begin
                    a = hypotenuse * -0.866025;
                    b = hypotenuse * -0.500000;
                end
                241: begin
                    a = hypotenuse * -0.874620;
                    b = hypotenuse * -0.484810;
                end
                242: begin
                    a = hypotenuse * -0.882948;
                    b = hypotenuse * -0.469472;
                end
                243: begin
                    a = hypotenuse * -0.891007;
                    b = hypotenuse * -0.453990;
                end
                244: begin
                    a = hypotenuse * -0.898794;
                    b = hypotenuse * -0.438371;
                end
                245: begin
                    a = hypotenuse * -0.906308;
                    b = hypotenuse * -0.422618;
                end
                246: begin
                    a = hypotenuse * -0.913545;
                    b = hypotenuse * -0.406737;
                end
                247: begin
                    a = hypotenuse * -0.920505;
                    b = hypotenuse * -0.390731;
                end
                248: begin
                    a = hypotenuse * -0.927184;
                    b = hypotenuse * -0.374607;
                end
                249: begin
                    a = hypotenuse * -0.933580;
                    b = hypotenuse * -0.358368;
                end
                250: begin
                    a = hypotenuse * -0.939693;
                    b = hypotenuse * -0.342020;
                end
                251: begin
                    a = hypotenuse * -0.945519;
                    b = hypotenuse * -0.325568;
                end
                252: begin
                    a = hypotenuse * -0.951057;
                    b = hypotenuse * -0.309017;
                end
                253: begin
                    a = hypotenuse * -0.956305;
                    b = hypotenuse * -0.292372;
                end
                254: begin
                    a = hypotenuse * -0.961262;
                    b = hypotenuse * -0.275637;
                end
                255: begin
                    a = hypotenuse * -0.965926;
                    b = hypotenuse * -0.258819;
                end
                256: begin
                    a = hypotenuse * -0.970296;
                    b = hypotenuse * -0.241922;
                end
                257: begin
                    a = hypotenuse * -0.974370;
                    b = hypotenuse * -0.224951;
                end
                258: begin
                    a = hypotenuse * -0.978148;
                    b = hypotenuse * -0.207912;
                end
                259: begin
                    a = hypotenuse * -0.981627;
                    b = hypotenuse * -0.190809;
                end
                260: begin
                    a = hypotenuse * -0.984808;
                    b = hypotenuse * -0.173648;
                end
                261: begin
                    a = hypotenuse * -0.987688;
                    b = hypotenuse * -0.156434;
                end
                262: begin
                    a = hypotenuse * -0.990268;
                    b = hypotenuse * -0.139173;
                end
                263: begin
                    a = hypotenuse * -0.992546;
                    b = hypotenuse * -0.121869;
                end
                264: begin
                    a = hypotenuse * -0.994522;
                    b = hypotenuse * -0.104528;
                end
                265: begin
                    a = hypotenuse * -0.996195;
                    b = hypotenuse * -0.087156;
                end
                266: begin
                    a = hypotenuse * -0.997564;
                    b = hypotenuse * -0.069756;
                end
                267: begin
                    a = hypotenuse * -0.998630;
                    b = hypotenuse * -0.052336;
                end
                268: begin
                    a = hypotenuse * -0.999391;
                    b = hypotenuse * -0.034899;
                end
                269: begin
                    a = hypotenuse * -0.999848;
                    b = hypotenuse * -0.017452;
                end
                270: begin
                    a = hypotenuse * -1.000000;
                    b = hypotenuse * -0.000000;
                end
                271: begin
                    a = hypotenuse * -0.999848;
                    b = hypotenuse * 0.017452;
                end
                272: begin
                    a = hypotenuse * -0.999391;
                    b = hypotenuse * 0.034899;
                end
                273: begin
                    a = hypotenuse * -0.998630;
                    b = hypotenuse * 0.052336;
                end
                274: begin
                    a = hypotenuse * -0.997564;
                    b = hypotenuse * 0.069756;
                end
                275: begin
                    a = hypotenuse * -0.996195;
                    b = hypotenuse * 0.087156;
                end
                276: begin
                    a = hypotenuse * -0.994522;
                    b = hypotenuse * 0.104528;
                end
                277: begin
                    a = hypotenuse * -0.992546;
                    b = hypotenuse * 0.121869;
                end
                278: begin
                    a = hypotenuse * -0.990268;
                    b = hypotenuse * 0.139173;
                end
                279: begin
                    a = hypotenuse * -0.987688;
                    b = hypotenuse * 0.156434;
                end
                280: begin
                    a = hypotenuse * -0.984808;
                    b = hypotenuse * 0.173648;
                end
                281: begin
                    a = hypotenuse * -0.981627;
                    b = hypotenuse * 0.190809;
                end
                282: begin
                    a = hypotenuse * -0.978148;
                    b = hypotenuse * 0.207912;
                end
                283: begin
                    a = hypotenuse * -0.974370;
                    b = hypotenuse * 0.224951;
                end
                284: begin
                    a = hypotenuse * -0.970296;
                    b = hypotenuse * 0.241922;
                end
                285: begin
                    a = hypotenuse * -0.965926;
                    b = hypotenuse * 0.258819;
                end
                286: begin
                    a = hypotenuse * -0.961262;
                    b = hypotenuse * 0.275637;
                end
                287: begin
                    a = hypotenuse * -0.956305;
                    b = hypotenuse * 0.292372;
                end
                288: begin
                    a = hypotenuse * -0.951057;
                    b = hypotenuse * 0.309017;
                end
                289: begin
                    a = hypotenuse * -0.945519;
                    b = hypotenuse * 0.325568;
                end
                290: begin
                    a = hypotenuse * -0.939693;
                    b = hypotenuse * 0.342020;
                end
                291: begin
                    a = hypotenuse * -0.933580;
                    b = hypotenuse * 0.358368;
                end
                292: begin
                    a = hypotenuse * -0.927184;
                    b = hypotenuse * 0.374607;
                end
                293: begin
                    a = hypotenuse * -0.920505;
                    b = hypotenuse * 0.390731;
                end
                294: begin
                    a = hypotenuse * -0.913545;
                    b = hypotenuse * 0.406737;
                end
                295: begin
                    a = hypotenuse * -0.906308;
                    b = hypotenuse * 0.422618;
                end
                296: begin
                    a = hypotenuse * -0.898794;
                    b = hypotenuse * 0.438371;
                end
                297: begin
                    a = hypotenuse * -0.891007;
                    b = hypotenuse * 0.453990;
                end
                298: begin
                    a = hypotenuse * -0.882948;
                    b = hypotenuse * 0.469472;
                end
                299: begin
                    a = hypotenuse * -0.874620;
                    b = hypotenuse * 0.484810;
                end
                300: begin
                    a = hypotenuse * -0.866025;
                    b = hypotenuse * 0.500000;
                end
                301: begin
                    a = hypotenuse * -0.857167;
                    b = hypotenuse * 0.515038;
                end
                302: begin
                    a = hypotenuse * -0.848048;
                    b = hypotenuse * 0.529919;
                end
                303: begin
                    a = hypotenuse * -0.838671;
                    b = hypotenuse * 0.544639;
                end
                304: begin
                    a = hypotenuse * -0.829038;
                    b = hypotenuse * 0.559193;
                end
                305: begin
                    a = hypotenuse * -0.819152;
                    b = hypotenuse * 0.573576;
                end
                306: begin
                    a = hypotenuse * -0.809017;
                    b = hypotenuse * 0.587785;
                end
                307: begin
                    a = hypotenuse * -0.798636;
                    b = hypotenuse * 0.601815;
                end
                308: begin
                    a = hypotenuse * -0.788011;
                    b = hypotenuse * 0.615661;
                end
                309: begin
                    a = hypotenuse * -0.777146;
                    b = hypotenuse * 0.629320;
                end
                310: begin
                    a = hypotenuse * -0.766044;
                    b = hypotenuse * 0.642788;
                end
                311: begin
                    a = hypotenuse * -0.754710;
                    b = hypotenuse * 0.656059;
                end
                312: begin
                    a = hypotenuse * -0.743145;
                    b = hypotenuse * 0.669131;
                end
                313: begin
                    a = hypotenuse * -0.731354;
                    b = hypotenuse * 0.681998;
                end
                314: begin
                    a = hypotenuse * -0.719340;
                    b = hypotenuse * 0.694658;
                end
                315: begin
                    a = hypotenuse * -0.707107;
                    b = hypotenuse * 0.707107;
                end
                316: begin
                    a = hypotenuse * -0.694658;
                    b = hypotenuse * 0.719340;
                end
                317: begin
                    a = hypotenuse * -0.681998;
                    b = hypotenuse * 0.731354;
                end
                318: begin
                    a = hypotenuse * -0.669131;
                    b = hypotenuse * 0.743145;
                end
                319: begin
                    a = hypotenuse * -0.656059;
                    b = hypotenuse * 0.754710;
                end
                320: begin
                    a = hypotenuse * -0.642788;
                    b = hypotenuse * 0.766044;
                end
                321: begin
                    a = hypotenuse * -0.629320;
                    b = hypotenuse * 0.777146;
                end
                322: begin
                    a = hypotenuse * -0.615661;
                    b = hypotenuse * 0.788011;
                end
                323: begin
                    a = hypotenuse * -0.601815;
                    b = hypotenuse * 0.798636;
                end
                324: begin
                    a = hypotenuse * -0.587785;
                    b = hypotenuse * 0.809017;
                end
                325: begin
                    a = hypotenuse * -0.573576;
                    b = hypotenuse * 0.819152;
                end
                326: begin
                    a = hypotenuse * -0.559193;
                    b = hypotenuse * 0.829038;
                end
                327: begin
                    a = hypotenuse * -0.544639;
                    b = hypotenuse * 0.838671;
                end
                328: begin
                    a = hypotenuse * -0.529919;
                    b = hypotenuse * 0.848048;
                end
                329: begin
                    a = hypotenuse * -0.515038;
                    b = hypotenuse * 0.857167;
                end
                330: begin
                    a = hypotenuse * -0.500000;
                    b = hypotenuse * 0.866025;
                end
                331: begin
                    a = hypotenuse * -0.484810;
                    b = hypotenuse * 0.874620;
                end
                332: begin
                    a = hypotenuse * -0.469472;
                    b = hypotenuse * 0.882948;
                end
                333: begin
                    a = hypotenuse * -0.453990;
                    b = hypotenuse * 0.891007;
                end
                334: begin
                    a = hypotenuse * -0.438371;
                    b = hypotenuse * 0.898794;
                end
                335: begin
                    a = hypotenuse * -0.422618;
                    b = hypotenuse * 0.906308;
                end
                336: begin
                    a = hypotenuse * -0.406737;
                    b = hypotenuse * 0.913545;
                end
                337: begin
                    a = hypotenuse * -0.390731;
                    b = hypotenuse * 0.920505;
                end
                338: begin
                    a = hypotenuse * -0.374607;
                    b = hypotenuse * 0.927184;
                end
                339: begin
                    a = hypotenuse * -0.358368;
                    b = hypotenuse * 0.933580;
                end
                340: begin
                    a = hypotenuse * -0.342020;
                    b = hypotenuse * 0.939693;
                end
                341: begin
                    a = hypotenuse * -0.325568;
                    b = hypotenuse * 0.945519;
                end
                342: begin
                    a = hypotenuse * -0.309017;
                    b = hypotenuse * 0.951057;
                end
                343: begin
                    a = hypotenuse * -0.292372;
                    b = hypotenuse * 0.956305;
                end
                344: begin
                    a = hypotenuse * -0.275637;
                    b = hypotenuse * 0.961262;
                end
                345: begin
                    a = hypotenuse * -0.258819;
                    b = hypotenuse * 0.965926;
                end
                346: begin
                    a = hypotenuse * -0.241922;
                    b = hypotenuse * 0.970296;
                end
                347: begin
                    a = hypotenuse * -0.224951;
                    b = hypotenuse * 0.974370;
                end
                348: begin
                    a = hypotenuse * -0.207912;
                    b = hypotenuse * 0.978148;
                end
                349: begin
                    a = hypotenuse * -0.190809;
                    b = hypotenuse * 0.981627;
                end
                350: begin
                    a = hypotenuse * -0.173648;
                    b = hypotenuse * 0.984808;
                end
                351: begin
                    a = hypotenuse * -0.156434;
                    b = hypotenuse * 0.987688;
                end
                352: begin
                    a = hypotenuse * -0.139173;
                    b = hypotenuse * 0.990268;
                end
                353: begin
                    a = hypotenuse * -0.121869;
                    b = hypotenuse * 0.992546;
                end
                354: begin
                    a = hypotenuse * -0.104528;
                    b = hypotenuse * 0.994522;
                end
                355: begin
                    a = hypotenuse * -0.087156;
                    b = hypotenuse * 0.996195;
                end
                356: begin
                    a = hypotenuse * -0.069756;
                    b = hypotenuse * 0.997564;
                end
                357: begin
                    a = hypotenuse * -0.052336;
                    b = hypotenuse * 0.998630;
                end
                358: begin
                    a = hypotenuse * -0.034899;
                    b = hypotenuse * 0.999391;
                end
                359: begin
                    a = hypotenuse * -0.017452;
                    b = hypotenuse * 0.999848;
                end
                360: begin
                    a = hypotenuse * -0.000000;
                    b = hypotenuse * 1.000000;
                end
                default: begin
                    a = hypotenuse * 0.0;
                    b = hypotenuse * 1.0;
                end
            endcase
        end
    endgenerate
endmodule