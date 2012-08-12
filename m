From: "Warren Post" <warren@copaninvest.com>
Date: Sun, 12 Aug 2012 22:40:01 +0000
Subject: [lm-sensors] Configuration file for Intel DG31GL
Message-Id: <op.wix88zhxn283x7@verdi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I can't claim to know what I'm doing, but I have cobbled together a  
configuration file for my Intel DG31GL that meets my needs and thought I'd  
share it with the community:

***config file begins***

# lm_sensors configuration file for the Intel DG31GL motherboard
# 2011-01-02, Warren Post <warren@copaninvest.com>
# Comments welcome

# Winbond configuration adapted from Hans de Goede's work at:
# http://www.lm-sensors.org/wiki/Configurations/ASRock/AM2NF3-VSTA
chip "w83627dhg-*"

     label in0 "VCore"
     label in1 "VCore2"
     label in2 "AVCC"
     label in3 "3VCC"
     label in6 "12V"
     label in7 "VSB"
     label in8 "VBAT"

# +12V and +5V use dividers recommended by datasheet
     compute in6 @*(1+(56/10)),  @/(1+(56/10))
     compute in9 @*(1+(22/10)),  @/(1+(22/10))

# in4 and in5 are not used (they seem to be hooked up to 3.3v/2, but thats
# already monitored)

     ignore in4
     ignore in5

# we need to set all voltage limits (hurray for a well written BIOS)
# Note you may need to adapt in0 and in1 depending on your CPU

     set in0_min   0.9
     set in0_max   1.5
     set in1_min   0.9
     set in1_max   1.7       # Supress alarm; default value 1.5
     set in2_min   3.3*0.95
     set in2_max   3.3*1.05
     set in3_min   3.3*0.95
     set in3_max   3.3*1.05
     set in6_min   0         # Supress alarm; default value 12.0*0.9
     set in6_max   12.0*1.1
     set in7_min   3.3*0.95
     set in7_max   3.3*1.05
     set in8_min   3.0
     set in8_max   3.3*1.05

# Fans

    ignore fan1    # No sensors available for case fans
    label fan2     "CPU Fan"
    ignore fan3
    ignore fan4
    ignore fan5

# Fan minumums

    set fan2_min    1000

# Temperatures

    label temp1     "Sys Temp"
    label temp2     "CPU Temp"
    label temp3     "CPU2 Temp"
    ignore temp3    # Suppress alarm

    set temp1_max       100  # Supress alarm; default value 45
    set temp1_max_hyst  100  # Supress alarm; default value 40

    set temp2_max       100  # Supress alarm; default value 45
    set temp2_max_hyst  100  # Supress alarm; default value 40

    set temp3_max       45
    set temp3_max_hyst  40


***config file ends***


With my thanks for the lm_sensors project,

-- 
Warren Post
http://my.opera.com/wpost/blog/lm-sensors-config-file

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
