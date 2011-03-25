From: mike <mikpolniak@roadrunner.com>
Date: Fri, 25 Mar 2011 12:22:08 +0000
Subject: [lm-sensors] add new chipset ID to f71882fg.c for Fintek F71889AD
Message-Id: <20110325082208.6196573b@slack64.homefree.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

FYI this is new Intel SandyBridge board with Fintek F71889AD chipset:

 run >>sensors-detect

# sensors-detect revision 5861 (2010-09-21 17:21:05 +0200)
# System: MSI MS-7678
# Board: MSI H67MA-E45 (MS-7678)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found unknown chip with ID 0x1005
    (logical device 4 has address 0x290, could be sensors)
****************************************************************
using kernel-2.6.38

add this line to f71882fg.c

#define SIO_F71889_ID           0x1005  /* Chipset ID */

*************************************************************
then run>>sensors
sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +16.0°C  (high = +80.0°C, crit = +98.0°C)     

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +21.0°C  (high = +80.0°C, crit = +98.0°C)     

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +20.0°C  (high = +80.0°C, crit = +98.0°C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +25.0°C  (high = +80.0°C, crit = +98.0°C)     

f71889fg-isa-0290
Adapter: ISA adapter
in0:         +1.66 V
in1:         +0.74 V  (max =  +2.04 V)   
in2:         +0.07 V
in3:         +0.97 V
in4:         +1.12 V
in5:         +0.74 V
in6:         +1.04 V
in7:         +1.61 V
in8:         +1.64 V
fan1:        557 RPM
fan2:          0 RPM  ALARM
fan3:          0 RPM  ALARM
temp1:       +19.0°C  (high = +255.0°C, hyst = +251.0°C)  ALARM
                      (crit = +255.0°C, hyst = +251.0°C)  ALARM
sensor = Intel PECI
temp2:       +24.0°C  (high = +255.0°C, hyst = +251.0°C)  ALARM
                      (crit = +255.0°C, hyst = +251.0°C)  ALARM
sensor = thermistor
temp3:       +21.0°C  (high = +255.0°C, hyst = +253.0°C)  ALARM
                      (crit = +255.0°C, hyst = +253.0°C)  ALARM
sensor = transistor

Just need help in configuring the actual values of the in* voltages.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
