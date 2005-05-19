From: cliff_dugal@bigfoot.com (Cliff Dugal)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: W83697HF support works for ABIT KR7A-RAID
Message-Id: <200207010248.53146.cliff_dugal@bigfoot.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I thought I might as well let you guys know that lm_sensors 2.6.3 seems 
to work perfectly for the Winbond W83697HF on my ABIT KR7A-RAID M/B 
(well, at least by ISA). The monitoring on this board is different than 
the stock sensors.conf file though. For my configuration, I use:

    label in0 "VCore"
    label in2 "VIO"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "AGP"
    label in6 "DDR"
    label in7 "5VSB"
    label in8 "VBat"
    label fan1 "CPU fan"
    label fan2 "Case fan"
    label temp1 "Sys temp"
    label temp2 "CPU temp"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

    set in0_min 1.8 * 0.95
    set in0_max 1.8 * 1.05
    set in2_min 3.3 * 0.94
    set in2_max 3.3 * 1.06
    set in3_min 5.0 * 0.94
    set in3_max 5.0 * 1.06
    set in4_min 12 * 0.94
    set in4_max 12 * 1.06
    set in5_min 1.5 * 0.94
    set in5_max 1.5 * 1.06
    set in6_min 2.5 * 0.94
    set in6_max 2.5 * 1.06
    set in7_min 5 * 0.85
    set in7_max 5 * 1.15
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

    set fan1_div 2
    set fan1_min 5000
    set fan2_div 4
    set fan2_min 1500

    set temp1_hyst 45
    set temp1_over 50
    set temp2_hyst 60
    set temp2_over 65

The configuration is probably not perfect, but it works for me.

Thanks for the great util!

Cliff
