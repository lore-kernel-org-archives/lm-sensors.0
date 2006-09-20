From: paul.aviles@nickelnetworks.com (Paul Aviles)
Date: Wed, 20 Sep 2006 02:34:02 +0000
Subject: [lm-sensors] Sensors questions - Can't get
Message-Id: <200609200234.k8K2Y63n013063@www.palei.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am getting some errors in my sensors (2.8.7 libsensors 2.8.7 and kernel
2.6.17.4) output and was wondering how to fix them. I am attaching my
configuration below.

Regards,

Paul Aviles

ERRORS
ERROR: Can't get alarm mask data!
ERROR: Can't get IN4 data!
ERROR: Can't get PWM1 data!
ERROR: Can't get PWM2 data!
ERROR: Can't get PWM3 data!


[root at demo1 etc]# sensors
eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 1480
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 1480
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

adt7463-i2c-0-2e
Adapter: SMBus I801 adapter at 1480
ERROR: Can't get alarm mask data!
+2.6V:     +2.591 V  (min =  +2.47 V, max =  +2.73 V)
CPU Volt:  +1.327 V  (min =  +1.25 V, max =  +1.40 V)
+3.3V:     +3.399 V  (min =  +3.13 V, max =  +3.47 V)
+5V:      +5.117 V  (min =  +4.74 V, max =  +5.26 V)
ERROR: Can't get IN4 data!
Fan2:      6271 RPM  (min = 3000 RPM)
Fan3:     10246 RPM  (min = 3000 RPM)
Fan1:     10505 RPM  (min = 3000 RPM)
CPU Temp: +53.25?C  (low  =    +5?C, high =   +68?C)
Loc Temp: +37.25?C  (low  =    +5?C, high =   +40?C)
Sys Temp: +46.75?C  (low  =    +5?C, high =   +50?C)
ERROR: Can't get PWM1 data!
ERROR: Can't get PWM2 data!
ERROR: Can't get PWM3 data!


/etc/sensors.conf
#  To your /etc/modules.conf file, add the lines:
#     alias char-major-89 i2c-dev
#  To your /etc/rc.xxx files, add the lines:
#     modprobe i2c-i801
#     modprobe lm85
#     sensors -s

chip "lm85-*" "adt7463-*"

#    ignore pwm1
#    ignore pwm2
#    ignore pwm3
    ignore pwm4
    ignore pwm5
    ignore in4
    ignore fan4
    ignore fan5

    label in0 "+2.6V"
    label in1 "CPU Volt"
    label in2 "+3.3V"
    label in3 "+5V"

    label fan1 "Fan2"
    label fan2 "Fan3"
    label fan3 "Fan1"

    label pwm1 "pwm2"
    label pwm2 "pwm3"
    label pwm3 "pwm1"

    label temp1 "CPU Temp"
    label temp2 "Loc Temp"
    label temp3 "Sys Temp"

    set in0_min  2.6 * 0.95
    set in0_max  2.6 * 1.05
    set in1_min  1.315 * 0.95
    set in1_max  1.33 * 1.05
    set in2_min  3.3 * 0.95
    set in2_max  3.3 * 1.05
    set in3_min  5.0 * 0.95
    set in3_max  5.0 * 1.05

    set fan1_min 3000
    set fan2_min 3000
    set fan3_min 3000

    set temp1_min 5
    set temp1_max 68

    set temp2_min 5
    set temp2_max 40

    set temp3_min 5
    set temp3_max 50

    set vrm  9.1

#lsmod
Module                  Size  Used by
autofs4                20996  0
iptable_filter          3840  1
ip_tables              14324  1 iptable_filter
x_tables               14340  1 ip_tables
eeprom                  7824  0
lm85                   28708  0
hwmon_vid               3584  1 lm85
dm_mod                 53912  0
thermal                14088  0
processor              20212  1 thermal
fan                     5636  0
button                  7568  0
uhci_hcd               22028  0
ehci_hcd               30216  0
i2c_i801                9228  0
i2c_core               20608  3 eeprom,lm85,i2c_i801
e1000                 104120  0
floppy                 57028  0
ext3                  120200  3
jbd                    53012  1 ext3
raid0                   8704  4
aic7xxx               130740  0
scsi_transport_spi     22656  1 aic7xxx
sd_mod                 19712  0
scsi_mod              126856  3 aic7xxx,scsi_transport_spi,sd_mod





