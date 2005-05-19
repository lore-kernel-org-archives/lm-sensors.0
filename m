From: jean.ribiere@wanadoo.fr (Jean Ribiere)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm-sensors-2.70 and chip W83977EF
Message-Id: <200304040904.02936.jean.ribiere@wanadoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have installed lm-sensors-2.7.0.

Context :
- slackware-8.1
- kernel 2.4.20

The driver loaded is w83781d but with the command sensors
the result is not correct :
- the value pour -5V is out of limits
- the fan speeds are 0

I have found in the moterboard (Abit BE6) documentation,
the chip is a W83977EF and dmidecode gives a similar information :
# dmidecode 1.8
...
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor: <http://www.abit.com.tw>
		Product: i440BX-W83977 (BE6)
		Version:
		Serial Number:
...

Below, various informations :

lsmod
==Module                  Size  Used by    Tainted: P
i2c-dev                 3940   0  (autoclean)
ipt_TOS                 1048  12  (autoclean)
ipt_ULOG                3752   5  (autoclean)
ipt_LOG                 3160   2  (autoclean)
ipt_REJECT              2776   4  (autoclean)
ipt_state                568  10  (autoclean)
iptable_mangle          2160   1  (autoclean)
ip_nat_irc              2576   0  (unused)
ip_nat_ftp              3344   0  (unused)
iptable_nat            18904   2  [ip_nat_irc ip_nat_ftp]
ip_conntrack_irc        3184   1  [ip_nat_irc]
ip_conntrack_ftp        4016   1  [ip_nat_ftp]
ip_conntrack           24288   4  [ipt_state ip_nat_irc ip_nat_ftp iptable_nat 
ip_conntrack_irc ip_conntrack_ftp]
iptable_filter          1668   1  (autoclean)
ip_tables              12952  10  [ipt_TOS ipt_ULOG ipt_LOG ipt_REJECT 
ipt_state iptable_mangle iptable_nat iptable_filter]
eeprom                  3536   0  (unused)
w83781d                19448   0  (unused)
i2c-piix4               4176   0
dmi_scan                1476   0  [i2c-piix4]
i2c-proc                6544   0  [eeprom w83781d]
i2c-core               15056   0  [i2c-dev eeprom w83781d i2c-piix4 i2c-proc]
nvidia               1467392   0  (unused)
ide-scsi                7408   0
natsemi                16320   1
es1371                 26696   0  (unused)
soundcore               3460   4  [es1371]
ac97_codec              9992   0  [es1371]
gameport                1484   0  [es1371]
usb-storage            48796   0  (unused)
usb-uhci               21164   0  (unused)
usbcore                54528   0  [usb-storage usb-uhci]
ppp_deflate             2904   0  (unused)
zlib_deflate           17432   0  [ppp_deflate]
ppp_async               6432   0  (unused)
ppp_generic            15808   0  [ppp_deflate ppp_async]
slip                    7968   0  (unused)
slhc                    4384   0  [ppp_generic slip]
lp                      6368   0  (unused)
parport_pc             20904   1
parport                22912   1  [lp parport_pc]

sensor
===
w83783s-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 5000
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.64 V  (min =  +1.53 V, max =  +1.69 V)
+3.3V:     +3.37 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.17 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.97 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.03 V  (min = -13.21 V, max = -10.90 V)
-5V:       +3.53 V  (min =  -5.26 V, max =  -4.76 V)
fan1:        0 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 3000 RPM, div = 2)
temp1:       -48?C  (limit =  +60?C)                       sensor = thermistor
temp2:     +25.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = thermistor
vid:      +1.625 V
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-50
Adapter: SMBus PIIX4 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus PIIX4 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
Memory size (MB):       64

Values in /proc....
=========darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# pwd
/proc/sys/dev/sensors/w83783s-i2c-0-2d
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# ls -l
 [00mtotal 0
-r--r--r--    1 root     root            0 avr  4 08:46  [00malarms [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mbeep [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mfan1 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mfan2 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mfan3 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mfan_div [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00min0 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00min2 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00min3 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00min4 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00min5 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00min6 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mpwm1 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mpwm2 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00msensor1 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00msensor2 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mtemp1 [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mtemp2 [00m
-r--r--r--    1 root     root            0 avr  4 08:46  [00mvid [00m
-rw-r--r--    1 root     root            0 avr  4 08:46  [00mvrm [00m
 [mdarkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat alarms
0
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat beep
0 0
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat fan1
3000 0
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat fan2
3000 0
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat fan3
3000 0
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat fan_div
2 2 2
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat in0
1.53 1.69 1.63
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat in0   2
3.13 3.45 3.36
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat in2   3
2.81 3.12 3.08
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat in3   4
2.84 3.47 3.15
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat in4   5
0.33 0.78 0.56
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat in5   6
0.78 0.94 3.58
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat in6         pwm1
255
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat pwm1   2
255
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat pwm2            sensor1
3435
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat sensor1   2
3435
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat sensor2                     
temp1
60.0 127.0 -48.0
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat temp1   2
60.0 50.0 27.5
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat temp2               vid
1.625
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# cat vid         vrm
9.0
darkstar:/proc/sys/dev/sensors/w83783s-i2c-0-2d# exit

I can send you any information you need to support this chip.

Best regards
