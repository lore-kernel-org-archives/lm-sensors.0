From: Beth <beth.null@gmail.com>
Date: Fri, 08 Aug 2008 18:45:32 +0000
Subject: [lm-sensors] Problems with a MSI K8T Neo2 v2.0 (wrong voltages and
Message-Id: <7641eb8f0808081145q3ad0208ftaa94915e52e0043@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all, this is my first message to the list, so  first of all:
Pleased to meet everyone here.

Well guys and girls, I have a little problem trying to control the cpu
fan speed of a MSI K8T Neo2 v2.0 [
http://global.msi.com.tw/index.php?func=3Dproddesc&prod_no 8&maincat_no=3D1
]

Really there are two problems, one related to incorrect reported
voltages and the other is that it seems that pwmconfig can't match any
pwm control with the cpu-fan.

Here you have the sensors-detect output

(I am using ubuntu 8.04 and kernel 2.6.24-19-generic, with an AMD
Athlon(tm) 64 X2 Dual Core Processor 4200+)

***************************************************************************=
***********************************************

# sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 0000:00:11.0: VIA Technologies
VT8237 South Bridge

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no):
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus Via Pro adapter at 5000 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2f
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM78-J'...              No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83791SD'...                           No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `Fintek custom power control IC'...             No
Probing for `Winbond W83791D'...                            No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627THF/THG Super IO Sensors'              Success!
    (address 0x290, driver `w83627hf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   Success!
    (driver `k8temp')
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x290
    Chip `Winbond W83627THF/THG Super IO Sensors' (confidence: 9)

Driver `k8temp' (should be inserted):
  Detects correctly:
  * Chip `AMD K8 thermal sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To load everything that is needed, add this to /etc/modules:

#----cut here----
# Chip drivers
w83627hf
k8temp
#----cut here----

Do you want to add these lines automatically? (yes/NO)


***************************************************************************=
***********************************************

I added the modules in a previous sensors-detect run, reboot, tested
with modprobe and all I can imagine.

Here is the output of "sensors":

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +41.0=B0C
Core1 Temp:  +46.0=B0C

w83627thf-isa-0290
Adapter: ISA adapter
VCore:       +1.37 V  (min =3D  +0.70 V, max =3D  +1.87 V)
+12V:        +2.98 V  (min =3D +11.92 V, max =3D +12.10 V)
+3.3V:       +3.33 V  (min =3D  +1.47 V, max =3D  +0.72 V)
+5V:         +5.01 V  (min =3D  +5.33 V, max =3D  +5.33 V)
-12V:        +0.96 V  (min =3D  -2.25 V, max =3D  -3.07 V)
V5SB:        +5.00 V  (min =3D  +0.43 V, max =3D  +5.35 V)
VBat:        +3.49 V  (min =3D  +1.84 V, max =3D  +3.65 V)
fan1:          0 RPM  (min =3D 4115 RPM, div =3D 2)
CPU Fan:    5314 RPM  (min =3D 5273 RPM, div =3D 2)
fan3:          0 RPM  (min =3D 2678 RPM, div =3D 2)
M/B Temp:    +48.0=B0C  (high =3D +12.0=B0C, hyst =3D +48.0=B0C)  sensor =
=3D thermistor
CPU Temp:    +47.0=B0C  (high =3D +70.0=B0C, hyst =3D +65.0=B0C)  sensor =
=3D diode
temp3:       +39.5=B0C  (high =3D +70.0=B0C, hyst =3D +65.0=B0C)  sensor =
=3D thermistor
cpu0_vid:   +0.000 V
beep_enable:enabled


The temps seems to be accurate but the voltages are wrong.

And if I try to do a pwmconfig no correlations are detected:


***************************************************************************=
***********************************************

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
   hwmon0/device is k8temp
   hwmon1/device is w83627thf

Found the following PWM controls:
   hwmon1/device/pwm1
   hwmon1/device/pwm2
   hwmon1/device/pwm3

Giving the fans some time to reach full speed...
Found the following fan sensors:
   hwmon1/device/fan1_input     current speed: 0 ... skipping!
   hwmon1/device/fan2_input     current speed: 5357 RPM
   hwmon1/device/fan3_input     current speed: 0 ... skipping!

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control hwmon1/device/pwm1 ...
  hwmon1/device/fan2_input ... speed was 5357 now 5400
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon1/device/pwm1,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)?

Testing pwm control hwmon1/device/pwm2 ...
  hwmon1/device/fan2_input ... speed was 5357 now 5443
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon1/device/pwm2,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)?

Testing pwm control hwmon1/device/pwm3 ...
  hwmon1/device/fan2_input ... speed was 5357 now 5357
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon1/device/pwm3,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)?

Testing is complete.
Please verify that all fans have returned to their normal speed.

The fancontrol script can automatically respond to temperature changes
of your system by changing fanspeeds.
Do you want to set up its configuration file now (y)? n

***************************************************************************=
***********************************************

Well for the first message I think that is a bit long one ;), anyone
could help me a bit and get no crazy with a 5000 rpm fan?

Thanks for your support and best regards.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
