From: Romain Dolbeau <romain.dolbeau@caps-entreprise.com>
Date: Tue, 06 May 2008 12:41:12 +0000
Subject: [lm-sensors]  sensors.conf for the Supermicro PDSMi+
Message-Id: <482051E8.605@caps-entreprise.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010106070407070504020903"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010106070407070504020903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Same device than the X7DBE, but used differently.

-- 
Romain Dolbeau
<romain.dolbeau@caps-entreprise.com>


--------------010106070407070504020903
Content-Type: text/plain;
 name="PDSMi+.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PDSMi+.conf"

# settings for the supermicro PDSMi+
#
# Notes:
# 1) as of linux 2.4.21, temp6 is read by lm-sensors but doesn't actually
#    seem to exist in the chip (?), so an error is displayed...
#
# Originally written by Romain Dolbeau <romain@dolbeau.org>
# Uses at your own risk !
chip "w83793-i2c-*-2f"

# 0x10, CPU Core
    label in0 "CPU Core"
# 0x11, unconnected according to support, 1.5V in BIOS ?
    label in1 "+1.5V"
    set in1_min 1.5*0.95
    set in1_max 1.5*1.05
# 0x12, unconnected according to support, VTT=1.2V in BIOS ?
    label in2 "VTT"
    set in2_min 1.2*0.95
    set in2_max 1.2*1.05
# 0x14, -12V
    label in3 "-12V"
    compute in3 (((@/8)*18500)/256)-16, (((@+16)*256)/18500)*8
    set in3_min -12*1.05
    set in3_max -12*0.95
# 0x15, DIMM
    label in4 "DIMM"
# 0x16, +3.3V
    label in5 "+3.3V"
    set in5_min 3.3*0.95
    set in5_max 3.3*1.05
# 0x17, +12V
    label in6 "+12V"
    compute in6 @*12,@/12
    set in6_min 12*0.95
    set in6_max 12*1.05
# Ox18, +5V
    label in7 "+5V"
    compute in7 @-0.15,@+0.15
    set in7_min 5*0.95
    set in7_max 5*1.05
# 0x19, 5VSB
    label in8 "5VSB"
    compute in8 @-0.15,@+0.15
    set in8_min 5*0.95
    set in8_max 5*1.05
# 0x1a, Battery Voltage
    label in9 "VBAT"

    label temp1 "CPU Temp"
    ignore temp2
    ignore temp3
    ignore temp4
    label temp5 "System Temp"
    ignore temp6

    label fan1 "fan1"
    label fan2 "fan2"
    label fan3 "fan3"
    label fan4 "fan4"
    label fan5 "fan5"
    ignore fan6
    label fan7 "CPU fan"
    ignore fan8
    ignore fan9
    ignore fan10
    ignore fan12
    ignore fan12


--------------010106070407070504020903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010106070407070504020903--
