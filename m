From: ch@hitnet.rwth-aachen.de (Christian Hammers)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: [config] Elitegroup K7S5A
Message-Id: <20011229171127.B21138@westend.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

Just for the record, or better for those who search the docs/mailing lists
in favour to read the tons of docs and figure the right values for
themselves here my working config:
(Maybe someone really likes my idea of creating single, plug'n'play 
config files for every motherboard in the doc/ directory...)

bye,

 -christian-

#
# Board: 	Elitegroup K7S5A
# Chip: 	1039:0735, Silicon Integrated Systems [SiS] 735 Host (rev 01)
# Version: 	2.6.2 (cvs from 2001-12-29)
# Notes: 	My CPU fan rotates is very slowly. Faster fans might need
# 		adjusted "compute fan" lines.
chip "it87-*"
  label  in0 "VCore"
  label  in1 "+2.5V"
  label  in2 "+3.3V"
  label  in3 "+5V"
  label  in4 "+12V"
  label  in5 "-12V"
  ignore in6
  ignore in7
  ignore in8
  ignore vid
  label  fan1 "Fan CPU"
  label  fan2 "Fan P/S"
  ignore fan3
  ignore temp1
  label  temp2 "Temp MB"
  label  temp3 "Temp CPU"
  #
  compute in2 (1)*@ , @/(1)
  compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
  compute in4 ((30/10) +1)*@ , @/((30/10) +1)
  compute in5 -(36/10)*@,     -@/(36/10)
  compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)
  compute fan1 @/16 , 16*@
  compute fan2 @/2 , 2*@
  #
  set in0_min 1.75 * 0.95
  set in0_max 1.75 * 1.05
  set in1_min 2.4
  set in1_max 2.6
  set in2_min 3.3 * 0.95
  set in2_max 3.3 * 1.05
  set in3_min 5.0 * 0.95
  set in3_max 5.0 * 1.05
  set in4_min 12 * 0.95
  set in4_max 12 * 1.05
  set in5_min -12 * 0.95
  set in5_max -12 * 1.05
  set in7_min 5 * 0.95
  set in7_max 5 * 1.05
  set fan1_min 1000
  set fan1_div 8
  set fan2_min 500
  set fan2_div 8
  set temp2_over 45
  set temp2_hyst 35
  set temp3_over 75
  set temp3_hyst 60


And a valid output looks like this:

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.76 V  (min =  +1.66 V, max =  +1.82 V)   
+2.5V:     +2.48 V  (min =  +2.40 V, max =  +2.60 V)   
+3.3V:     +3.26 V  (min =  +3.13 V, max =  +3.45 V)   
+5V:       +4.84 V  (min =  +4.72 V, max =  +5.24 V)   
+12V:     +12.48 V  (min = +11.36 V, max = +12.60 V)   
-12V:     -12.24 V  (min = -11.38 V, max = -12.60 V)   
Fan CPU:  1507 RPM  (min =  959 RPM, div = 8)          
Fan P/S:  1534 RPM  (min =  499 RPM, div = 8)          
Temp MB:     +29?C  (min =  +35?C, max =  +45?C) 
Temp CPU:    +51?C  (min =  +60?C, max =  +75?C) 

-- 
One of the main causes of the fall of the roman empire was that, lacking zero,
they had no way to indicate successful termination of their C programs.
