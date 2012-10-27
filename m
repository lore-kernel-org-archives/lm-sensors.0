From: Greg Mansfield <greg@GregMansfield.com>
Date: Sat, 27 Oct 2012 16:44:37 +0000
Subject: [lm-sensors] Giga-Byte Technology GA-MA990FXA-UD3 motherboard sensors configuration file
Message-Id: <508C0F75.8060607@GregMansfield.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

# libsensors configuration file for Gigabyte GA-MA990FXA-UD3 motherboard

# Began with configuration file for Gigabyte GA-MA770-DS3 motherboard

chip "it8720-*"

     # lmsensors' values were compared with values from online images
     # of Everest or EasyTune 6 displays
     # Labels are copied from BIOS setup screens when value shown

     # Voltages

     label   in0 "Vcore"
         # 1.312
         # BIOS: 1.312
     set     in0_min 0.85
     set     in0_max 1.40

     label   in1 "DDR3 V"
         # 1.472
         # BIOS: 1.472
                 # No scaling so no compute
     set     in1_min 1.5 * 0.95 # 95% of nominal
     set     in1_max 1.5 * 1.10 # 110% of nominal

     label   in2 "+3.3V"
         # 3.264
         # BIOS: 3.280
     set     in2_min 3.3 * 0.95 # 95% of nominal
     set     in2_max 3.3 * 1.05 # 105% of nominal

     label   in3 "Vcc"
         # 2.944
         # Assume standard Winbond scaling resistors 6.8 - 10 (1.68)
     compute in3 @ * ((6.8/10)+1), @ / ((6.8/10)+1)
     set     in3_min 5 * 0.95 # 95% of nominal
     set     in3_max 5 * 1.05 # 105% of nominal

     label   in4 "+12V"
         # 3.072
         # BIOS: 12.239
     compute in4 @ * 4, @ / 4
     set     in4_min 12 * 0.95 # 95% of nominal
     set     in4_max 12 * 1.05 # 105% of nominal

     label   in5 "-12V"
         # 3.088
     compute in5 @ * -4, @ / -4
     set     in5_min -12 * 0.95 # 95% of nominal
     set     in5_max -12 * 1.05 # 105% of nominal

     ignore in6
         # 4.080

     label in7 "VCCH"
         # 2.96
     compute in7 @ *1.68, @/1.68
     set     in7_min 5 * 0.95 # 95% of nominal
     set     in7_max 5 * 1.05 # 105% of nominal

     label   in8 "Vbat"
         # 3.088
         # Internal connection


     # Temperatures

     label   temp1  "System"
     set     temp1_min 20
     set     temp1_max 60

     label   temp2  "CPU"
     set     temp2_min 20
     set     temp2_max 60

     label   temp3 "Northbridge"
     set     temp3_min 20
     set     temp3_max 90

     # Fans
     # The labels chosen are the ones printed on the motherboard

     label   fan1 "CPU_FAN"
     set     fan1_min 0 # fancontrol may stop fan
     label   fan2 "SYS_FAN1"
     label   fan3 "SYS_FAN2"
     label   fan4 #PWR_FAN"

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
