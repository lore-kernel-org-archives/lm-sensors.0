From: Dan Davison <davison@stats.ox.ac.uk>
Date: Mon, 24 Nov 2008 01:38:30 +0000
Subject: [lm-sensors] pwmconfig failure under Ubuntu Intrepid with Intel
Message-Id: <20081124013830.GA9778@stats.ox.ac.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0131285116945416257=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0131285116945416257==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

pwmconfig fails with the message

  /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed

Looking at the pwmconfig shell-script, the error occurs because there are=
 no pwm* files in the relevant place:

~> ls /sys/class/hwmon/hwmon*/device/
/sys/class/hwmon/hwmon1/device/:
driver  hwmon  modalias  name  power  subsystem  temp1_crit  temp1_crit_a=
larm  temp1_input  temp1_label  uevent

/sys/class/hwmon/hwmon2/device/:
driver  hwmon  modalias  name  power  subsystem  temp1_crit  temp1_crit_a=
larm  temp1_input  temp1_label  uevent


However, despite a few hours googling, I am unclear whether there is
any hope that I can get this working, and if so what to do next. This
is a Fujitsu-Siemens Lifebook S Series laptop which has the an Intel
Core Duo processor with Intel 945GM chipset, and is running Ubuntu
Intrepid (fully updated).

I've looked at http://www.lm-sensors.org/wiki/Devices, but don't fully
understand the information there. Under SENSOR CHIP DRIVERS there is
this entry

Intel   Core, Core 2  yes  coretemp   2.6.22  (2007-03-25) Integrated sen=
sor in CPU. Driver contributed by Rudolf Marek.=20

Is this good news, or is it saying that there's just temperature stuff
but no fan control?

and under I2C/SMBUS BUS DRIVERS there are several entries for Intel
none of which obviously correspond to my hardware.

I've run sensors-detect which results in (full output at bottom)=20

Driver `smartbatt' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 18e0'
    Busdriver `i2c-i801', I2C address 0x0b
    Chip `Smart Battery' (confidence: 5)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

This coretemp module is loaded and is providing temperature
readings. I don't know if it has anything to do with fan control.

Running sensors gives

~> sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +26.8=C2=B0C  (crit =3D +100.0=C2=B0C)                 =20
temp2:       +26.8=C2=B0C  (crit =3D +100.0=C2=B0C)                 =20

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +43.0=C2=B0C  (crit =3D +100.0=C2=B0C)                 =20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +43.0=C2=B0C  (crit =3D +100.0=C2=B0C)           =20


(I have not observed the first two temperatures be anything other than
26.8).

I'd like to be able to modify my fan behaviour but don't know what to
do in order that pwmconfig runs. Thanks very much for any help. Full
output from sensors-detect follows.

Dan

Next adapter: SMBus I801 adapter at 18e0 (i2c-0)
Do you want to scan it? (YES/no/selectively):=20
Client found at address 0x0b
Probing for `Smart Battery'...                              Success!
    (confidence 5, driver `smartbatt')
Client found at address 0x19
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              No
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `Maxim MAX6680/MAX6681'...                      No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):=20
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):=20
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown non-standard chip with ID 0x7a
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):=20
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `smartbatt' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 18e0'
    Busdriver `i2c-i801', I2C address 0x0b
    Chip `Smart Battery' (confidence: 5)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:=20

To load everything that is needed, add this to /etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
# Chip drivers
# Warning: the required module smartbatt is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
smartbatt
coretemp
#----cut here----




--=20
http://www.stats.ox.ac.uk/~davison


--===============0131285116945416257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0131285116945416257==--
