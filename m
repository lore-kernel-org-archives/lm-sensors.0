From: "Andrew Voznytsa" <andrew.voznytsa@gmail.com>
Date: Tue, 05 Feb 2008 12:20:27 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was:
Message-Id: <002e01c867f1$801358f0$0204a8c0@IT>
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

In short - it works! Relevant outputs are below. Just a few questions -
would you recommend to use this code in production system (as for me looked
like simplified version of previous driver, looks like clean and nice, but
is it stable enough)? Perhaps stupid question but is there any kind of
'WHQL' for linux kernel development?
 
Syslog output:

Feb  5 14:04:36 farm dme1737 0-002e: Found a SCH5027 chip at 0x2e (rev
0x69).
Feb  5 14:04:36 farm dme1737 0-002e: Optional features: pwm3=yes, pwm5=no,
pwm6=no, fan3=yes, fan4=yes, fan5=yes, fan6=yes.

Sensors output:

sch5027-i2c-0-2e
Adapter: SMBus I801 adapter at 3000
in0:         +4.60 V  (min =  +0.00 V, max =  +6.64 V)
in1:         +1.14 V  (min =  +0.00 V, max =  +2.99 V)
in2:         +3.37 V  (min =  +0.00 V, max =  +4.38 V)
in3:         +1.53 V  (min =  +0.00 V, max =  +6.64 V)
in4:        +12.87 V  (min =  +0.00 V, max = +15.94 V)
in5:         +3.29 V  (min =  +0.00 V, max =  +4.38 V)
in6:         +3.14 V  (min =  +0.00 V, max =  +4.38 V)
fan1:        885 RPM  (min =  720 RPM)
fan2:          0 RPM  (min =  720 RPM)  ALARM
fan3:          0 RPM  (min =  720 RPM)  ALARM
fan4:          0 RPM  (min =  720 RPM)  ALARM
fan5:       2040 RPM  (min =  720 RPM)
fan6:          0 RPM  (min =  720 RPM)  ALARM
temp1:       -56.0 C  (low  = -127.0 C, high = +127.0 C)
temp2:       +39.4 C  (low  = -127.0 C, high = +127.0 C)
temp3:       +36.2 C  (low  = -127.0 C, high = +127.0 C)
cpu0_vid:   +0.000 V

(fan1 - CPU, fan5 - chassis, temp1 - temperature margin in case of CPU
supporting 'PECI' feature (negative value is ok), or CPU temperature
(usually positive number), temp2 - motherboard, temp3 - dimm).

ls -l /sys/class/hwmon/hwmon*/device/ output:

/sys/class/hwmon/hwmon0/device/:
total 0
lrwxrwxrwx 1 root root    0 Feb  5 14:05 driver ->
../../../bus/platform/drivers/coretemp
-r--r--r-- 1 root root 4096 Feb  5 14:05 modalias
-r--r--r-- 1 root root 4096 Feb  5 14:05 name
drwxr-xr-x 2 root root    0 Feb  5 14:05 power
lrwxrwxrwx 1 root root    0 Feb  5 14:05 subsystem -> ../../../bus/platform
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_crit
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_crit_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_input
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_label
-rw-r--r-- 1 root root 4096 Feb  5 14:01 uevent

/sys/class/hwmon/hwmon1/device/:
total 0
lrwxrwxrwx 1 root root    0 Feb  5 14:05 driver ->
../../../bus/platform/drivers/coretemp
-r--r--r-- 1 root root 4096 Feb  5 14:05 modalias
-r--r--r-- 1 root root 4096 Feb  5 14:05 name
drwxr-xr-x 2 root root    0 Feb  5 14:05 power
lrwxrwxrwx 1 root root    0 Feb  5 14:05 subsystem -> ../../../bus/platform
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_crit
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_crit_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_input
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_label
-rw-r--r-- 1 root root 4096 Feb  5 14:01 uevent

/sys/class/hwmon/hwmon2/device/:
total 0
lrwxrwxrwx 1 root root    0 Feb  5 14:05 driver ->
../../../bus/platform/drivers/coretemp
-r--r--r-- 1 root root 4096 Feb  5 14:05 modalias
-r--r--r-- 1 root root 4096 Feb  5 14:05 name
drwxr-xr-x 2 root root    0 Feb  5 14:05 power
lrwxrwxrwx 1 root root    0 Feb  5 14:05 subsystem -> ../../../bus/platform
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_crit
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_crit_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_input
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_label
-rw-r--r-- 1 root root 4096 Feb  5 14:01 uevent

/sys/class/hwmon/hwmon3/device/:
total 0
lrwxrwxrwx 1 root root    0 Feb  5 14:05 driver ->
../../../bus/platform/drivers/coretemp
-r--r--r-- 1 root root 4096 Feb  5 14:05 modalias
-r--r--r-- 1 root root 4096 Feb  5 14:05 name
drwxr-xr-x 2 root root    0 Feb  5 14:05 power
lrwxrwxrwx 1 root root    0 Feb  5 14:05 subsystem -> ../../../bus/platform
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_crit
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_crit_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_input
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_label
-rw-r--r-- 1 root root 4096 Feb  5 14:01 uevent

/sys/class/hwmon/hwmon4/device/:
total 0
-r--r--r-- 1 root root 4096 Feb  5 14:05 cpu0_vid
lrwxrwxrwx 1 root root    0 Feb  5 14:05 driver ->
../../../../../../bus/i2c/drivers/dme1737
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan1_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan1_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan1_min
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan1_type
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan2_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan2_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan2_min
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan2_type
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan3_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan3_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan3_min
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan3_type
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan4_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan4_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan4_min
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan4_type
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan5_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan5_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan5_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan5_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan6_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 fan6_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan6_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 fan6_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 in0_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 in0_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in0_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in0_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 in1_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 in1_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in1_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in1_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 in2_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 in2_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in2_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in2_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 in3_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 in3_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in3_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in3_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 in4_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 in4_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in4_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in4_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 in5_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 in5_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in5_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in5_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 in6_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 in6_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in6_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 in6_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 modalias
-r--r--r-- 1 root root 4096 Feb  5 14:05 name
drwxr-xr-x 2 root root    0 Feb  5 14:05 power
-r--r--r-- 1 root root 4096 Feb  5 14:05 pwm1
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm1_auto_channels_zone
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm1_auto_point1_pwm
-r--r--r-- 1 root root 4096 Feb  5 14:05 pwm1_auto_point2_pwm
-r--r--r-- 1 root root 4096 Feb  5 14:05 pwm1_auto_pwm_min
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm1_enable
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm1_freq
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm1_ramp_rate
-r--r--r-- 1 root root 4096 Feb  5 14:05 pwm2
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm2_auto_channels_zone
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm2_auto_point1_pwm
-r--r--r-- 1 root root 4096 Feb  5 14:05 pwm2_auto_point2_pwm
-r--r--r-- 1 root root 4096 Feb  5 14:05 pwm2_auto_pwm_min
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm2_enable
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm2_freq
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm2_ramp_rate
-r--r--r-- 1 root root 4096 Feb  5 14:05 pwm3
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm3_auto_channels_zone
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm3_auto_point1_pwm
-r--r--r-- 1 root root 4096 Feb  5 14:05 pwm3_auto_point2_pwm
-r--r--r-- 1 root root 4096 Feb  5 14:05 pwm3_auto_pwm_min
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm3_enable
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm3_freq
-rw-r--r-- 1 root root 4096 Feb  5 14:04 pwm3_ramp_rate
lrwxrwxrwx 1 root root    0 Feb  5 14:05 subsystem ->
../../../../../../bus/i2c
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_fault
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp1_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 temp1_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 temp1_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp2_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp2_fault
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp2_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 temp2_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 temp2_min
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp3_alarm
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp3_fault
-r--r--r-- 1 root root 4096 Feb  5 14:05 temp3_input
-rw-r--r-- 1 root root 4096 Feb  5 14:05 temp3_max
-rw-r--r-- 1 root root 4096 Feb  5 14:05 temp3_min
-rw-r--r-- 1 root root 4096 Feb  5 14:05 uevent
-rw-r--r-- 1 root root 4096 Feb  5 14:05 vrm
-r--r--r-- 1 root root 4096 Feb  5 14:05 zone1_auto_channels_temp
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone1_auto_point1_temp
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone1_auto_point1_temp_hyst
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone1_auto_point2_temp
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone1_auto_point3_temp
-r--r--r-- 1 root root 4096 Feb  5 14:05 zone2_auto_channels_temp
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone2_auto_point1_temp
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone2_auto_point1_temp_hyst
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone2_auto_point2_temp
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone2_auto_point3_temp
-r--r--r-- 1 root root 4096 Feb  5 14:05 zone3_auto_channels_temp
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone3_auto_point1_temp
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone3_auto_point1_temp_hyst
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone3_auto_point2_temp
-rw-r--r-- 1 root root 4096 Feb  5 14:04 zone3_auto_point3_temp

Many thanks,
Andrew Voznytsa


> -----Original Message-----
> From: Juerg Haefliger [mailto:juergh@gmail.com]
> Sent: Tuesday, February 05, 2008 9:32 AM
> To: Andrew Voznytsa
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902
> (was: lm85 in Intel S3000AH case)
> 
> Andrew,
> 
> Can you please give the attached driver a try? It should recognize
> your chip properly.
> Please send the relevant output of /var/log/syslog and 'ls -l
> /sys/class/hwmon/hwmon*/device/' to the list.
> 
> Thanks
> ...juerg
> 
> 
> On Jan 30, 2008 11:08 AM, Andrew Voznytsa <andrew.voznytsa@gmail.com>
> wrote:
> > Hi Juerg,
> >
> > It is easy (around 1 min to compile kernel, so why not?). New output is
> > below. Quick summary - works as you said.
> >
> > # sensors-detect revision 5108 (2008-01-22 04:22:47 -0800)
> >
> > This program will help you determine which kernel modules you need
> > to load to use lm_sensors most effectively. It is generally safe
> > and recommended to accept the default answers to all questions,
> > unless you know what you're doing.
> >
> > We can start with probing for (PCI) I2C or SMBus adapters.
> > Do you want to probe now? (YES/no):
> > Probing for PCI bus adapters...
> > Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
> >
> > We will now try to load each adapter module in turn.
> > Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
> > FATAL: Module i2c_i801 not found.
> > Loading failed... skipping.
> > If you have undetectable or unsupported adapters, you can have them
> > scanned by manually loading the modules before running this script.
> >
> > We are now going to do the I2C/SMBus adapter probings. Some chips may
> > be double detected; we choose the one with the highest confidence
> > value in that case.
> > If you found that the adapter hung after probing a certain address,
> > you can specify that address to remain unprobed.
> >
> > Next adapter: SMBus I801 adapter at 3000 (i2c-0)
> > Do you want to scan it? (YES/no/selectively):
> > Client found at address 0x2e
> > Probing for `Myson MTP008'...                               No
> > Probing for `National Semiconductor LM78'...                No
> > Probing for `National Semiconductor LM78-J'...              No
> > Probing for `National Semiconductor LM79'...                No
> > Probing for `National Semiconductor LM80'...                No
> > Probing for `National Semiconductor LM85 or LM96000'...     No
> > Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... No
> > Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'...        No
> > Probing for `Analog Devices ADT7462'...                     No
> > Probing for `Analog Devices ADT7467 or ADT7468'...          No
> > Probing for `Analog Devices ADT7470'...                     No
> > Probing for `Analog Devices ADT7473'...                     No
> > Probing for `Analog Devices ADT7475'...                     No
> > Probing for `Analog Devices ADT7476'...                     No
> > Probing for `Andigilog aSC7611'...                          No
> > Probing for `Andigilog aSC7621'...                          No
> > Probing for `National Semiconductor LM87'...                No
> > Probing for `National Semiconductor LM93'...                No
> > Probing for `Winbond W83781D'...                            No
> > Probing for `Winbond W83782D'...                            No
> > Probing for `Winbond W83792D'...                            No
> > Probing for `Winbond W83793R/G'...                          No
> > Probing for `Winbond W83791SD'...                           No
> > Probing for `Winbond W83627HF'...                           No
> > Probing for `Winbond W83627EHF'...                          No
> > Probing for `Winbond W83627DHG'...                          No
> > Probing for `Asus AS99127F (rev.1)'...                      No
> > Probing for `Asus AS99127F (rev.2)'...                      No
> > Probing for `Asus ASB100 Bach'...                           No
> > Probing for `Winbond W83L786NR/NG/R/G'...                   No
> > Probing for `Winbond W83L785TS-S'...                        No
> > Probing for `Analog Devices ADM9240'...                     No
> > Probing for `Dallas Semiconductor DS1780'...                No
> > Probing for `National Semiconductor LM81'...                No
> > Probing for `Analog Devices ADM1026'...                     No
> > Probing for `Analog Devices ADM1025'...                     No
> > Probing for `Analog Devices ADM1029'...                     No
> > Probing for `Analog Devices ADM1030'...                     No
> > Probing for `Analog Devices ADM1031'...                     No
> > Probing for `Analog Devices ADM1022'...                     No
> > Probing for `Texas Instruments THMC50'...                   No
> > Probing for `Analog Devices ADM1028'...                     No
> > Probing for `ITE IT8712F'...                                No
> > Probing for `SMSC DME1737'...                               No
> > Probing for `SMSC SCH5027D-NW'...                           Success!
> >     (confidence 6, driver `dme1737')
> > Probing for `Fintek F75373S/SG'...                          No
> > Probing for `Fintek F75375S/SP'...                          No
> > Probing for `Fintek F75387SG/RG'...                         No
> > Probing for `Analog Devices ADM1024'...                     No
> > Probing for `Winbond W83791D'...                            No
> >
> > Client found at address 0x44
> > Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> > Client found at address 0x50
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 Yes
> >     (confidence 8, not a hardware monitoring chip)
> > Probing for `EDID EEPROM'...                                No
> > Client found at address 0x51
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 Yes
> >     (confidence 8, not a hardware monitoring chip)
> > Probing for `EDID EEPROM'...                                No
> > Client found at address 0x52
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 Yes
> >     (confidence 8, not a hardware monitoring chip)
> > Probing for `EDID EEPROM'...                                No
> > Client found at address 0x53
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 Yes
> >     (confidence 8, not a hardware monitoring chip)
> > Probing for `EDID EEPROM'...                                No
> >
> >
> > Some chips are also accessible through the ISA I/O ports. We have to
> > write to arbitrary I/O ports to probe them. This is usually safe though.
> > Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> > Do you want to scan the ISA I/O ports? (YES/no):
> > Probing for `National Semiconductor LM78' at 0x290...       No
> > Probing for `National Semiconductor LM78-J' at 0x290...     No
> > Probing for `National Semiconductor LM79' at 0x290...       No
> > Probing for `Winbond W83781D' at 0x290...                   No
> > Probing for `Winbond W83782D' at 0x290...                   No
> > Probing for `Silicon Integrated Systems SIS5595'...         No
> > Probing for `VIA VT82C686 Integrated Sensors'...            No
> > Probing for `VIA VT8231 Integrated Sensors'...              No
> > Probing for `IPMI BMC KCS' at 0xca0...                      No
> > Probing for `IPMI BMC SMIC' at 0xca8...                     No
> >
> > Some Super I/O chips may also contain sensors. We have to write to
> > standard I/O ports to probe them. This is usually safe.
> > Do you want to scan for Super I/O sensors? (YES/no):
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     Yes
> > Found `SMSC SCH5027D-NW Super IO'
> >     (hardware monitoring capabilities accessible via SMBus only)
> > Probing for Super-I/O at 0x4e/0x4f
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     No
> > Trying family `VIA/Winbond/Fintek'...                       No
> > Trying family `ITE'...                                      No
> >
> > Some CPUs or memory controllers may also contain embedded sensors.
> > Do you want to scan for them? (YES/no):
> > AMD K8 thermal sensors...                                   No
> > AMD K10 thermal sensors...                                  No
> > Intel Core family thermal sensor...                         Success!
> >     (driver `coretemp')
> > Intel AMB FB-DIMM thermal sensor...                         No
> >
> > Now follows a summary of the probes I have just done.
> > Just press ENTER to continue:
> >
> > Driver `dme1737' (should be inserted):
> >   Detects correctly:
> >   * Bus `SMBus I801 adapter at 3000'
> >     Busdriver `i2c-i801', I2C address 0x2e
> >     Chip `SMSC SCH5027D-NW' (confidence: 6)
> >
> > Driver `coretemp' (should be inserted):
> >   Detects correctly:
> >   * Chip `Intel Core family thermal sensor' (confidence: 9)
> >
> > Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
> > To load everything that is needed, add this to one of the system
> > initialization scripts (e.g. /etc/rc.d/rc.local):
> >
> > #----cut here----
> > # I2C adapter drivers
> > modprobe i2c-i801
> > # Chip drivers
> > modprobe dme1737
> > # Warning: the required module coretemp is not currently installed
> > # on your system. For status of 2.6 kernel ports check
> > # http://www.lm-sensors.org/wiki/Devices. If driver is built
> > # into the kernel, or unavailable, comment out the following line.
> > modprobe coretemp
> > /usr/bin/sensors -s
> > #----cut here----
> >
> > If you have some drivers built into your kernel, the list above will
> > contain too many modules. Skip the appropriate ones! You really
> > should try these commands right now to make sure everything is
> > working properly. Monitoring programs won't work until the needed
> > modules are loaded.
> >
> > Best regards,
> > Andrew Voznytsa
> >
> >
> >
> > > -----Original Message-----
> > > From: Juerg Haefliger [mailto:juergh@gmail.com]
> >
> > > Sent: Wednesday, January 30, 2008 8:20 PM
> > > To: Andrew Voznytsa
> > > Cc: lm-sensors@lm-sensors.org
> > > Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902
> > > (was: lm85 in Intel S3000AH case)
> > >
> > > Hi Andrew,
> > >
> > >
> > > On Jan 30, 2008 9:29 AM, Andrew Voznytsa <andrew.voznytsa@gmail.com>
> > > wrote:
> > > > # sensors-detect revision 5108 (2008-01-22 04:22:47 -0800)
> > > >
> > > > This program will help you determine which kernel modules you need
> > > > to load to use lm_sensors most effectively. It is generally safe
> > > > and recommended to accept the default answers to all questions,
> > > > unless you know what you're doing.
> > > >
> > > > We can start with probing for (PCI) I2C or SMBus adapters.
> > > > Do you want to probe now? (YES/no):
> > > > Probing for PCI bus adapters...
> > > > Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
> > > >
> > > > We will now try to load each adapter module in turn.
> > > > Load `i2c-i801' (say NO if built into your kernel)? (YES/no): no
> > > > If you have undetectable or unsupported adapters, you can have them
> > > > scanned by manually loading the modules before running this script.
> > > >
> > > > We are now going to do the I2C/SMBus adapter probings. Some chips
> may
> > > > be double detected; we choose the one with the highest confidence
> > > > value in that case.
> > > > If you found that the adapter hung after probing a certain address,
> > > > you can specify that address to remain unprobed.
> > > >
> > > > Next adapter: SMBus I801 adapter at 3000 (i2c-0)
> > > > Do you want to scan it? (YES/no/selectively):
> > > > Client found at address 0x2e
> > > > Handled by driver `lm85' (already loaded), chip type `lm85'
> > > > Client found at address 0x44
> > > > Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> > > > Client found at address 0x50
> > > > Probing for `Analog Devices ADM1033'...                     No
> > > > Probing for `Analog Devices ADM1034'...                     No
> > > > Probing for `SPD EEPROM'...                                 Yes
> > > >     (confidence 8, not a hardware monitoring chip)
> > > > Probing for `EDID EEPROM'...                                No
> > > > Client found at address 0x51
> > > > Probing for `Analog Devices ADM1033'...                     No
> > > > Probing for `Analog Devices ADM1034'...                     No
> > > > Probing for `SPD EEPROM'...                                 Yes
> > > >     (confidence 8, not a hardware monitoring chip)
> > > > Probing for `EDID EEPROM'...                                No
> > > > Client found at address 0x52
> > > > Probing for `Analog Devices ADM1033'...                     No
> > > > Probing for `Analog Devices ADM1034'...                     No
> > > > Probing for `SPD EEPROM'...                                 Yes
> > > >     (confidence 8, not a hardware monitoring chip)
> > > > Probing for `EDID EEPROM'...                                No
> > > > Client found at address 0x53
> > > > Probing for `Analog Devices ADM1033'...                     No
> > > > Probing for `Analog Devices ADM1034'...                     No
> > > > Probing for `SPD EEPROM'...                                 Yes
> > > >     (confidence 8, not a hardware monitoring chip)
> > > > Probing for `EDID EEPROM'...                                No
> > > >
> > > > Here it is. I'd notice that I used 2.6.23-gentoo-r3 kernel with
> builtin
> > > lm85
> > > > driver. If you need I can easily build any other kernel with any
> > > > drivers/etc.
> > >
> > > Ah yes, that explains why the SCH5027 is not detected here. If you
> > > have the time and care about it you can rebuild a kernel without the
> > > builtin lm85 and rerun the attached sensors-detect. It should then
> > > suggest the dme1737 driver for your chip. Anyways, I tested the
> > > modified script with the dump file that you provided and the i2c-stub
> > > driver so I'm confident it works correctly. I'll submit a patch for
> > > sensors-detect shortly...
> > >
> > > ...juerg
> > >
> > >
> > > > Some chips are also accessible through the ISA I/O ports. We have to
> > > > write to arbitrary I/O ports to probe them. This is usually safe
> though.
> > > > Yes, you do have ISA I/O ports even if you do not have any ISA
> slots!
> > > > Do you want to scan the ISA I/O ports? (YES/no):
> > > > Probing for `National Semiconductor LM78' at 0x290...       No
> > > > Probing for `National Semiconductor LM78-J' at 0x290...     No
> > > > Probing for `National Semiconductor LM79' at 0x290...       No
> > > > Probing for `Winbond W83781D' at 0x290...                   No
> > > > Probing for `Winbond W83782D' at 0x290...                   No
> > > > Probing for `Silicon Integrated Systems SIS5595'...         No
> > > > Probing for `VIA VT82C686 Integrated Sensors'...            No
> > > > Probing for `VIA VT8231 Integrated Sensors'...              No
> > > > Probing for `IPMI BMC KCS' at 0xca0...                      No
> > > > Probing for `IPMI BMC SMIC' at 0xca8...                     No
> > > >
> > > > Some Super I/O chips may also contain sensors. We have to write to
> > > > standard I/O ports to probe them. This is usually safe.
> > > > Do you want to scan for Super I/O sensors? (YES/no):
> > > > Probing for Super-I/O at 0x2e/0x2f
> > > > Trying family `National Semiconductor'...                   No
> > > > Trying family `SMSC'...                                     Yes
> > > > Found `SMSC SCH5027D-NW Super IO'
> > > >     (hardware monitoring capabilities accessible via SMBus only)
> > > > Probing for Super-I/O at 0x4e/0x4f
> > > > Trying family `National Semiconductor'...                   No
> > > > Trying family `SMSC'...                                     No
> > > > Trying family `VIA/Winbond/Fintek'...                       No
> > > > Trying family `ITE'...                                      No
> > > >
> > > > Some CPUs or memory controllers may also contain embedded sensors.
> > > > Do you want to scan for them? (YES/no):
> > > > AMD K8 thermal sensors...                                   No
> > > > AMD K10 thermal sensors...                                  No
> > > > Intel Core family thermal sensor...                         Success!
> > > >     (driver `coretemp')
> > > > Intel AMB FB-DIMM thermal sensor...                         No
> > > >
> > > > Now follows a summary of the probes I have just done.
> > > > Just press ENTER to continue:
> > > >
> > > > Driver `lm85' (should be inserted):
> > > >   Detects correctly:
> > > >   * Bus `SMBus I801 adapter at 3000'
> > > >     Busdriver `i2c-i801', I2C address 0x2e
> > > >     Chip `lm85' (confidence: 6)
> > > >
> > > > Driver `coretemp' (should be inserted):
> > > >   Detects correctly:
> > > >   * Chip `Intel Core family thermal sensor' (confidence: 9)
> > > >
> > > > Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
> > > > To load everything that is needed, add this to one of the system
> > > > initialization scripts (e.g. /etc/rc.d/rc.local):
> > > >
> > > > #----cut here----
> > > > # I2C adapter drivers
> > > > modprobe i2c-i801
> > > > # Chip drivers
> > > > modprobe lm85
> > > > # Warning: the required module coretemp is not currently installed
> > > > # on your system. For status of 2.6 kernel ports check
> > > > # http://www.lm-sensors.org/wiki/Devices. If driver is built
> > > > # into the kernel, or unavailable, comment out the following line.
> > > > modprobe coretemp
> > > > /usr/bin/sensors -s
> > > > #----cut here----
> > > >
> > > > If you have some drivers built into your kernel, the list above will
> > > > contain too many modules. Skip the appropriate ones! You really
> > > > should try these commands right now to make sure everything is
> > > > working properly. Monitoring programs won't work until the needed
> > > > modules are loaded.
> > > >
> > > > Best regards,
> > > > Andrew Voznytsa
> > > >
> > > > > -----Original Message-----
> > > > > From: Juerg Haefliger [mailto:juergh@gmail.com]
> > > >
> > > > > Sent: Wednesday, January 30, 2008 6:08 PM
> > > > > To: Andrew Voznytsa
> > > > > Cc: lm-sensors@lm-sensors.org
> > > > > Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID
> 0x8902
> > > > > (was: lm85 in Intel S3000AH case)
> > > > >
> > > > > Hi Andrew,
> > > > >
> > > > >
> > > > > On Jan 30, 2008 5:18 AM, Andrew Voznytsa
> <andrew.voznytsa@gmail.com>
> > > > > wrote:
> > > > > > Hi Juerg,
> > > > > >
> > > > > > Of course - works perfectly. It said
> > > > > >
> > > > > > [..]
> > > > > > Trying family `SMSC'...                                     Yes
> > > > > > Found `SMSC SCH5027D-NW Super IO'
> > > > > >     (hardware monitoring capabilities accessible via SMBus only)
> > > > > > [..]
> > > > >
> > > > > There should be another instance where the SMSC is detected as an
> I2C
> > > > > device. Can you post the complete log?
> > > > >
> > > > >
> > > > > > If I can do anything else - just let me know.
> > > > > >
> > > > > > Should I try some lm-sensors's svn branch/revision to test if
> all
> > > fans
> > > > > are
> > > > > > monitored now? If there is such - could you send me URL?
> > > > >
> > > > > That won't help. I need to update the dme1737 driver first which
> is
> > > > > part of the kernel, not lm-sensors.
> > > > >
> > > > > ...juerg
> > > > >
> > > > >
> > > > > > Many thanks,
> > > > > > Andrew Voznytsa
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Juerg Haefliger [mailto:juergh@gmail.com]
> > > > > > > Sent: Wednesday, January 30, 2008 7:22 AM
> > > > > > > To: Andrew Voznytsa
> > > > > > > Cc: lm-sensors@lm-sensors.org
> > > > > > > Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID
> > > 0x8902
> > > > > > > (was: lm85 in Intel S3000AH case)
> > > > > > >
> > > > > > > Hi Andrew,
> > > > > > >
> > > > > > > Could you run the attached script and post the output? It
> should
> > > > > > > correctly identify the SCH5027.
> > > > > > >
> > > > > > > ...juerg
> > > > > > >
> > > > > > >
> > > > > > > On Jan 18, 2008 7:25 AM, Andrew Voznytsa
> > > <andrew.voznytsa@gmail.com>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > Hi Juerg,
> > > > > > > >
> > > > > > > > > > > > > > > > Trying family `SMSC'...
> > > > > > > > > Yes
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Found unknown chip with ID 0x8902
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This is indeed unknown. Can you check the
> markings
> > > on
> > > > > the
> > > > > > > chip
> > > > > > > > > so
> > > > > > > > > > > that
> > > > > > > > > > > > > > > we know what we're dealing with? From the
> product
> > > > > picture
> > > > > > > my
> > > > > > > > > guess
> > > > > > > > > > > is
> > > > > > > > > > > > > > > it's the chip in the QFP package close to the
> IDE
> > > > > > > connector.
> > > > > > > > > It
> > > > > > > > > > > should
> > > > > > > > > > > > > > > read something like SMSC xyz.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > There is chip marked SMSC SCH-5027D(not sure
> that D,
> > > > > might
> > > > > > > be
> > > > > > > > > 0)-NW
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > According to spec which comes with MB it should
> be
> > > SMSC
> > > > > SC-
> > > > > > > 5027D
> > > > > > > > > > > > >
> > > > > > > > > > > > > Can you run
> > > > > > > > > > > > > i2cdetect -y 0
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Of course - here is output:
> > > > > > > > > > > >
> > > > > > > > > > > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > > > > > > > > > > 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> > > > > > > > > > > > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > > > > > > > > > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU --
> > > > > > > > > > > > 30: 30 31 32 33 -- -- -- -- -- -- -- -- -- -- -- --
> > > > > > > > > > > > 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> > > > > > > > > > > > 50: 50 51 52 53 -- -- -- -- -- -- -- -- -- -- -- --
> > > > > > > > > > > > 60: -- 61 -- 63 64 -- -- -- -- 69 -- -- -- -- -- --
> > > > > > > > > > > > 70: -- -- -- -- -- -- -- --
> > > > > > > > > > >
> > > > > > > > > > > OK, I figured it out, I believe :-) I received the
> > > datasheet
> > > > > for
> > > > > > > the
> > > > > > > > > > > SCH5027 from SMSC and after a quick glance at it, it
> looks
> > > > > like
> > > > > > > the
> > > > > > > > > > > hardware monitoring features of the DME1737, SCH5027
> and
> > > > > EMC6D10x
> > > > > > > are
> > > > > > > > > > > identical but they advertise themselves differently.
> In
> > > your
> > > > > case,
> > > > > > > the
> > > > > > > > > > > chip is detected as a EMC6D10x and sensors-detect
> suggests
> > > the
> > > > > > > lm85
> > > > > > > > > > > driver. However, I believe the dme1737 driver is more
> > > > > appropriate.
> > > > > > > I
> > > > > > > > > > > will take a closer look at the various datasheets over
> the
> > > > > next
> > > > > > > couple
> > > > > > > > > > > of days to confirm my theory. In the meantime, you can
> try
> > > the
> > > > > > > > > > > following:
> > > > > > > > > > > 1) remove the lm85 driver (rmmod lm85)
> > > > > > > > > > > 2) force the dme1737 driver (modprobe dme1737
> > > force=0,0x2e)
> > > > > > > > > > > 3) post the dme1737-related messages in
> /var/log/messages
> > > to
> > > > > the
> > > > > > > > > mailing
> > > > > > > > > > > list
> > > > > > > > > >
> > > > > > > > > > Here is output:
> > > > > > > > > >
> > > > > > > > > > Jan 18 16:09:12 farm dme1737 0-002e: Failed to query
> Super-
> > > IO
> > > > > for
> > > > > > > > > optional
> > > > > > > > > > features.
> > > > > > > > >
> > > > > > > > > Ah yes, the dme1737 driver doesn't know anything about the
> > > SCH5027
> > > > > > > > > Super-IO so it can't determine if fans 5&6 and PWMs 5&6
> are
> > > > > > > > > configured.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > Jan 18 16:09:12 farm dme1737 0-002e: Optional features:
> > > > > pwm3=yes,
> > > > > > > > > pwm5=no,
> > > > > > > > > > pwm6=no, fan3=yes, fan4=yes, fan5=no, fan6=no.
> > > > > > > > >
> > > > > > > > > If the BIOS shows 6 fans, fans 5&6 should become available
> > > once
> > > > > the
> > > > > > > > > driver is fixed to recognize the SCH5027.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > Jan 18 16:09:12 farm i2c-adapter i2c-0: Found a DME1737
> chip
> > > at
> > > > > 0x2e
> > > > > > > > > (rev
> > > > > > > > > > 0x00)
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Note that the SCH5027 only supports 4 fans, so you
> won't
> > > see
> > > > > > > fan5&6.
> > > > > > > > > > > How many fans do you have in the machine? Can you see
> RPMs
> > > for
> > > > > all
> > > > > > > of
> > > > > > > > > > > them in the BIOS?
> > > > > > > > >
> > > > > > > > > Correction: This is not true. The SCH5027 supports 6 fans,
> > > just
> > > > > like
> > > > > > > > > the dme1737.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > I've 2 fans - CPU (fan1) and chassis (fan5). They are
> > > connected
> > > > > as
> > > > > > > > > Intel's
> > > > > > > > > > manual says.
> > > > > > > > > >
> > > > > > > > > > BIOS shows 6 fans - it shows some (reasonable) RPMs for
> > > fans1, 5
> > > > > and
> > > > > > > > > zero
> > > > > > > > > > for rest (nothing attached there). BIOS is able to
> control
> > > RPMs
> > > > > > > itself,
> > > > > > > > > > depending on CPU, chassis and DIMM temperature sensors.
> > > > > > > > >
> > > > > > > > > Again, I'll take a look at the datasheets and if the chips
> are
> > > > > indeed
> > > > > > > > > compatible, I'll fix the dme1737 driver to support the
> > > sch5027. I
> > > > > > > > > don't have access to a test machine until next week, so it
> has
> > > to
> > > > > wait
> > > > > > > > > until then.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Just let me know if I can help with testing - I can't give
> > > access to
> > > > > my
> > > > > > > > S3000AH-based system but definitely can run some tests, etc.
> > > > > > > >
> > > > > > > > All the best,
> > > > > > > > Andrew
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > >
> > > > > >
> > > >
> > > >
> >
> >


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
