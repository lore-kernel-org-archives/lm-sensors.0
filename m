From: jingai <jingai@floatingpenguins.com>
Date: Fri, 22 Aug 2014 16:32:22 +0000
Subject: [lm-sensors] MSI Z97M gaming motherboard (NCT6792D)
Message-Id: <4B57331A-0F4F-4E58-AC24-E222F762F24C@floatingpenguins.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is what I have now.  For an MSI Z97M 'gaming' motherboard with Intel 4770k CPU.

I *think* in6 is the cpu voltage.  It is around 0.80V at idle and under load (via mprime) it rises to around 1.2V.

in10 I am unsure of, but it hovers just a little above 0V at idle and is just a bit higher than in6 under load (1.25V being the highest I've seen).

The others (in5, 9, 11-14) I'm not sure.  DRAM voltage should be in there somewhere since it shows in the BIOS (1.488V) but none of the values match that.

Any assistance with the above questions would be most appreciated.  When it's done, I'll be happy to add it to the wiki.

-j

chip "nct6792-isa-0a00"
        label in0 "VCCIN"
                compute in0 @ * 2, @ / 2
                set in0_min 1.75 * 0.95
                set in0_max 1.75 * 1.05
        label in1 "+5V"
                compute in1 @ * (40 / 8), @ / (40 / 8)
                set in1_min 5 * 0.95
                set in1_max 5 * 1.05
        label in2 "AVCC"
                set in2_min 3.3 * 0.95
                set in2_max 3.3 * 1.05
        label in3 "+3.3V"
                set in3_min 3.3 * 0.95
                set in3_max 3.3 * 1.05
        label in4 "+12V"
                compute in4 @ * (96 / 8), @ / (96 / 8)
                set in4_min 12 * 0.95
                set in4_max 12 * 1.05
        ignore in5                      # not sure, stays ~0.82V
#       ignore in6                      # between 0.80V and 1.20V, Vcore?
        label in7 "3VSB"
                set in7_min 3.3 * 0.95
                set in7_max 3.3 * 1.05
        label in8 "Vbat"
                set in8_min 3.3 * 0.90
                set in8_max 3.3 * 1.10
        ignore in9                      # not sure, stays ~1.02V
#       ignore in10                     # between 0.0V and 1.25V, increases under load
        ignore in11                     # always 0.0V
        ignore in12                     # not sure, stays ~1.02V
        ignore in13                     # not sure, stays ~0.74V
        ignore in14                     # not sure, stays ~1.82V

        label fan1 "RSys Fan"
                set fan1_min 1000
        label fan2 "CPU Fan"
                set fan2_min 1000
        label fan3 "FSys Fan1"
                set fan3_min 1000
        label fan4 "FSys Fan2"
                set fan4_min 1000
        ignore fan5

        label temp1 "SYS Temp"          # SYSTIN, reads around 30C, not sure if accurate
                set temp1_max 40
                set temp1_max_hyst 35
        ignore temp2                    # CPUTIN, reads 127.5C always.. dunno
        ignore temp3                    # AUXTIN0
        ignore temp4                    # AUXTIN1
        ignore temp5                    # AUXTIN2
        ignore temp6                    # AUXTIN3
        label temp7 "CPU Temp"          # PECI Agent 0, CPU temp
        ignore temp8                    # PCH_CHIP_CPU_MAX_TEMP
        ignore temp9                    # PCH_CHIP_TEMP
        ignore temp10                   # PCH_CPU_TEMP
        ignore intrusion0
        ignore intrusion1
        ignore beep_enable
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
