From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: sensors.cfg for w83697hf (Abit KR7A-133 mainboard)
Message-Id: <E170W7N-0003Fp-00@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a mainboard with a w83697hf chip (w83781d driver + i2c_isa), but 
there is no data into /etc/sensors.cfg.
I have done one (see attachement), it works for my mainboard (Abit 
KR7A-133), but it should also work for other mainboards (maybe with minor 
modifications).

Then, the w83697hf chip is noted as "support is complete but has not 
been well-tested", and I confirm it works well for me.

Moreover, I would to send you a link in the section "Hardware Monitoring 
Applications using the lm_sensors package" : 
http://ksensors.sourceforge.net

Aurelien Jarno
-------------- next part --------------
chip "w83697hf-*"

    label in0 "VCore"
    label in2 "VIO"
    label in3 "5VSB"
    label in4 "+12V"
    label in5 "AGP"
    label in6 "DDR"
    label in7 "+5V"
    label in8 "VBat"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in2_min 3.5 * 0.95
    set in2_max 3.5 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_min 1.5 * 0.95
    set in5_max 1.5 * 1.05
    set in6_min 2.55 * 0.95
    set in6_max 2.55 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

   label temp1 "MB Temp"
   label temp2 "CPU Temp"

# examples for temperature limits
#    set temp1_over 40
#    set temp1_hyst 37
#    set temp2_over 62
#    set temp2_hyst 57

    set fan1_div 2
    set fan2_div 4
