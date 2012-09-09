From: =?utf-8?Q?G=C3=B6ran_Uddeborg?= <goeran@uddeborg.se>
Date: Sun, 09 Sep 2012 17:53:12 +0000
Subject: [lm-sensors] Configuration for Foxconn A7GM-S 2.0
Message-Id: <20556.55176.173597.530756@freddi.uddeborg>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've tried to configure lm-sensors correctly for my TV-box following
the instructions on
http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling Having done it,
I thought I could contribute my result if you want to incorporate it
in the wiki.  Maybe I could register and do it myself, I haven't
tried.  But I thought it could be a good idea if someone more
experienced did a review first anyway.

My motherboard is a Foxconn A7&M-S 2.0 with "BIOS ID" 872F1P04 and
"BIOS Version" 08.00.14.  According to sensors, the exact chip is an
IT8716.  The BIOS reports CPU, DRAM, 3.3V, 12V and 1.1V readings.  All
but the 12V could be found directly available without scaling.  For
12V I used the instructions on the VoltageLabelsAndScaling page and
think I've figured out that it goes in steps of 64mV.  I.e. the
scaling factor is 4.

So my configuration for this motherboard ended up like this:

chip "it8716-*"
     label  in0 "CPU core"
     label  in1 "DRAM voltage"
     label  in2 "+3.3V"
     ignore in3
     label  in4 "+12.0V"
     label  in5 "+1.1V"
     ignore in6
     ignore in7
     ignore in8

     compute in4  @ * (64/16), @ / (64/16)

     label  fan1 "CPU fan"
     # One of these is the "System fan", but I don't have anything connected
     # to that socket, so I don't know which one.
     ignore fan2
     ignore fan3

     label  temp1 "CPU temp"
     label  temp2 "System temp"
     ignore temp3

     # Min and max for Athlon II X2 245e
     set in0_min  0.875
     set in0_max  1.4
     # JEDEC standard for DDR2
     set in1_min  1.7
     set in1_max  1.9
     # 5 % tolerance on the remaining measurements
     set in2_min  3.3   * 0.95
     set in2_max  3.3   * 1.05
     set in4_min 12.0   * 0.95
     set in4_max 12.0   * 1.05
     set in5_min  1.1   * 0.95
     set in5_max  1.1   * 1.05

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
