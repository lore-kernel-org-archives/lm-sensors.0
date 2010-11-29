From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Mon, 29 Nov 2010 06:20:44 +0000
Subject: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer easyStore
Message-Id: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Providing some feedback now that SCH5127 support is "mainline" in
LM_Sensors; no "force_id" option required.

I have an Acer easyStore H340 that has a SCH5127 monitoring chip inside.

[root@anas-01 ~]# uname -a
Linux anas-01.my.home 2.6.35.6-48.fc14.x86_64 #1 SMP Fri Oct 22 15:36:08
UTC 2010 x86_64 x86_64 x86_64 GNU/Linux

[root@anas-01 ~]# sensors -v
sensors version 3.2.0 with libsensors version 3.2.0

LM_Sensors identifies the SCH5127 chip as follows:

[root@anas-01 ~]# sensors-detect
Stopping lm_sensors:                                       [  OK  ]
# sensors-detect revision 5861 (2010-09-21 17:21:05 +0200)
# System: Acer Aspire easyStore H340
# Board: Acer WG945GCM

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC SCH5127 Super IO'                               Success!
    (address 0x800, driver `dme1737')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
Module i2c-dev loaded successfully.

Next adapter: SMBus I801 adapter at 18a0 (i2c-0)
Do you want to scan it? (yes/NO/selectively):

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel Atom thermal sensor' (confidence: 9)

Driver `dme1737':
  * ISA bus, address 0x800
    Chip `SMSC SCH5127 Super IO' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel Atom thermal sensor' (confidence: 9)

Driver `dme1737':
  * ISA bus, address 0x800
    Chip `SMSC SCH5127 Super IO' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Starting lm_sensors: loading module coretemp dme1737       [  OK  ]
Unloading i2c-dev... OK

[root@anas-01 ~]# service lm_sensors status
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +21.0=B0C  (crit =3D +90.0=B0C)

sch5127-isa-0870
Adapter: ISA adapter
V+1.5:       +1.42 V  (min =3D  +1.35 V, max =3D  +1.65 V)
5VTR:        +4.78 V  (min =3D  +4.50 V, max =3D  +5.48 V)
VBAT:        +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
V+5:         +5.09 V  (min =3D  +0.00 V, max =3D  +6.72 V)
Vccp:        +1.48 V  (min =3D  +1.35 V, max =3D  +1.49 V)
VCC:         +3.33 V  (min =3D  +0.00 V, max =3D  +4.38 V)
VTR:         +3.24 V  (min =3D  +0.00 V, max =3D  +4.38 V)
Side Fan:   2250 RPM  (min =3D 600 RPM)
MCH Fan:    5137 RPM  (min =3D 4500 RPM)
CPU Temp:    +47.6=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
SYS Temp:    +35.1=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)

Here is my "/etc/sensors.d/local.conf" file:

[root@anas-01 ~]# cat /etc/sensors.d/local.conf
# libsensors configuration file
# -----------------------------

chip "sch5127-isa-0870"

    label in0 "V+1.5"
    label in1 "5VTR"
    label in2 "VBAT"
    label in3 "V+5"
    label in4 "Vccp"
    label in5 "VCC"
    label in6 "VTR"

# All inputs are listed here in order as displayed in BIOS.
# Values seen by "sensors" closely match values seen in BIOS.

    label fan1 "Side Fan"
    label fan2 "MCH Fan"
    ignore fan3

    label temp1 "CPU Temp"
    ignore temp2
#    label temp2 "SIO Temp"
    label temp3 "SYS Temp"

    compute in0 (@ * 0.8), (@ / 0.8)
    compute in1 (@ * 4), (@ / 4)
    compute in3 (@ * 4.5), (@ / 4.5)

    set in0_min 1.5 * 0.90
    set in0_max 1.5 * 1.10
    set in1_min 5.0 * 0.90
    set in1_max 5.0 * 1.10
    set in4_min 1.50 * 0.90
    set in4_max 1.50 * 1.10

    set fan1_min 600 <- per fan vendor
    set fan2_min 4500
    set temp1_min 20
    set temp1_max 60
    set temp2_min 20
    set temp3_min 20
    set temp3_max 60

Fan1 is a CoolerMaster Excalibur R4-EXBB-20PK-R0 120x120x25 mm fan. It has
a speed range of 600 ~ 2000 RPM +- 10 percent per vendor. It does get loud
at full speed but it also moves air: 26.4 ~ 85.6 CFM +- 10 percent per
vendor.

The system has 2 fan headers, both are 4-pin. I have only tested "fan1"
(Sensors label: Side Fan) ("pwmconfig" detected: hwmon1/device/pwm1) using
"pwmconfig":

[root@anas-01 ~]# pwmconfig
# pwmconfig revision 5857 (2010-08-22)
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

Found the following devices:
   hwmon0/device is coretemp
   hwmon1/device is sch5127

Found the following PWM controls:
   hwmon1/device/pwm1 <- local label "Side Fan"
   hwmon1/device/pwm2 <- local label "MCH Fan"
   hwmon1/device/pwm3 <- no header on motherboard

Giving the fans some time to reach full speed...
Found the following fan sensors:
   hwmon1/device/fan1_input     current speed: 2253 RPM
   hwmon1/device/fan2_input     current speed: 5147 RPM
   hwmon1/device/fan3_input     current speed: 0 ... skipping!

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control hwmon1/device/pwm1 ...
  hwmon1/device/fan1_input ... speed was 2253 now 699
    It appears that fan hwmon1/device/fan1_input
    is controlled by pwm hwmon1/device/pwm1
Would you like to generate a detailed correlation (y)? y
    PWM 255 FAN 2254
    PWM 240 FAN 2250
    PWM 225 FAN 2250
    PWM 210 FAN 2251
    PWM 195 FAN 2156
    PWM 180 FAN 2032
    PWM 165 FAN 1910
    PWM 150 FAN 1774
    PWM 135 FAN 1626
    PWM 120 FAN 1461
    PWM 105 FAN 1286
    PWM 90 FAN 1091
    PWM 75 FAN 907
    PWM 60 FAN 796
    PWM 45 FAN 730
    PWM 30 FAN 701
    PWM 28 FAN 698
    PWM 26 FAN 698
    PWM 24 FAN 700
    PWM 22 FAN 698
    PWM 20 FAN 700
    PWM 18 FAN 700
    PWM 16 FAN 700
    PWM 14 FAN 701
    PWM 12 FAN 701
    PWM 10 FAN 701
    PWM 8 FAN 700
    PWM 6 FAN 701
    PWM 4 FAN 700
    PWM 2 FAN 701
    PWM 0 FAN 701

  hwmon1/device/fan2_input ... speed was 5147 now 5172
    no correlation

Testing pwm control hwmon1/device/pwm2 ...
  hwmon1/device/fan1_input ... speed was 2253 now 2259
    no correlation
  hwmon1/device/fan2_input ... speed was 5147 now 5147
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon1/device/pwm2,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? y

Testing pwm control hwmon1/device/pwm3 ...
  hwmon1/device/fan1_input ... speed was 2253 now 2253
    no correlation
  hwmon1/device/fan2_input ... speed was 5147 now 5152
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon1/device/pwm3,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? n

Testing is complete.
Please verify that all fans have returned to their normal speed.

The fancontrol script can automatically respond to temperature changes
of your system by changing fanspeeds.
Do you want to set up its configuration file now (y)?
What should be the path to your fancontrol config file (/etc/fancontrol)?
Loading configuration from /etc/fancontrol ...

Select fan output to configure, or other action:
1) hwmon1/device/pwm2  3) Change INTERVAL     5) Save and quit
2) hwmon1/device/pwm1  4) Just quit           6) Show configuration
select (1-n): 2

Devices:
hwmon0/device is coretemp
hwmon1/device is sch5127

Current temperature readings are as follows:
hwmon0/device/temp1_input       22
hwmon1/device/temp1_input       48
hwmon1/device/temp2_input       125
hwmon1/device/temp3_input       36

Select a temperature sensor as source for hwmon1/device/pwm1:
1) hwmon0/device/temp1_input
2) hwmon1/device/temp1_input
3) hwmon1/device/temp2_input
4) hwmon1/device/temp3_input
5) None (Do not affect this PWM output)
select (1-n): 2

Enter the low temperature (degree C)
below which the fan should spin at minimum speed (20): 30

Enter the high temperature (degree C)
over which the fan should spin at maximum speed (60):

Enter the PWM value (0-255) to use when the temperature
is over the high temperature limit (255):


Select fan output to configure, or other action:
1) hwmon1/device/pwm2  3) Change INTERVAL     5) Save and quit
2) hwmon1/device/pwm1  4) Just quit           6) Show configuration
select (1-n): 6

Common Settings:
INTERVAL=10

Settings of hwmon1/device/pwm2:
  Depends on
  Controls
  MINTEMP  MAXTEMP  MINSTART  MINSTOP
Settings of hwmon1/device/pwm1:
  Depends on hwmon1/device/temp1_input
  Controls hwmon1/device/fan1_input
  MINTEMP0
  MAXTEMP`
  MINSTART=150
  MINSTOP=3D0


Select fan output to configure, or other action:
1) hwmon1/device/pwm2  3) Change INTERVAL     5) Save and quit
2) hwmon1/device/pwm1  4) Just quit           6) Show configuration
select (1-n): 5

Saving configuration to /etc/fancontrol...
Configuration saved


Experiences so far:

(1) "fancontrol" script does work, but I would like it to run as a
"background" process or even as a daemon. I'm not a programmer so I don't
know if this is even possible or how to do it.

(2) Fan speed on "Fan1" does go up and down with system temperatures.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
