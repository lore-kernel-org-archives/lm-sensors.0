From: man@oceanography.ru (Jack)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: sensors.conf for as99127f on asus a7m-266
Message-Id: <3E90214B.9090405@oceanography.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i've got asus a7m266 with as99127f chip, default config for it won't do 
well, i've hacked this:



chip "as99127f-*"

     label in0 "VCore"
     ignore in1
     label in2 "+3.3V"
     label in3 "+5V"
     label in4 "+12V"
     label in5 "-12V"
     label in6 "-5V"
     label fan1 "CPU fan"
     label fan2 "Pwr fan"
     label fan3 "SBr fan"
     label temp1 "SBr temp"
     label temp2 "CPU temp"
     ignore temp3

     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
     compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
     compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
     compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
     compute temp2 (@*2), (@/2)

     set in0_min vid*0.95
     set in0_max vid*1.05
     set in1_min vid*0.95
     set in1_max vid*1.05
     set in2_min 3.3 * 0.95
     set in2_max 3.3 * 1.05
     set in3_min 5.0 * 0.95
     set in3_max 5.0 * 1.05
     set in4_min 12 * 0.90
     set in4_max 12 * 1.10
     set in5_min -12 * 0.90
     set in5_max -12 * 1.10
     set in6_min -5 * 0.95
     set in6_max -5 * 1.05
     set fan1_min 3500
     set fan2_min 1000
     set fan3_min 5500

     set temp1_over 40
     set temp1_hyst 35
     set temp2_over 70
     set temp2_hyst 65

     set beeps 0
     set beep_enable 1













actually, even with the same chip, as you say, there are different
values of resistors so on different mzboards configs would be different
hence, i think configuration should be specific not only for the chip,
but for the chip AND the mzboard. the lest, config should allow
mzboard-specific subconfigurations for chips, so various people will
quickly find their formulae for their mzboards and would send you
the data, and there'll be one good sensors.conf that anyone can
use just finding their mzboard there, not probing for various stuff
