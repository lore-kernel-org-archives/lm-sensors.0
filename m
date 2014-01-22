From: Derek Piper <dcpiper@indiana.edu>
Date: Wed, 22 Jan 2014 15:25:30 +0000
Subject: [lm-sensors] CPU temps on Supermicro H8DCL
Message-Id: <201401221025.30452.dcpiper@indiana.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_qL+3SVjiqrdTwcE"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_qL+3SVjiqrdTwcE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit


	Hi,

	I have a Supermicro H8DCL with two AMD Opteron 4334 processors. I have 
attached the output of 'sensors-detect' and then the output of 'sensors'. I am 
getting CPU temperature readings that are wrong (too low). I have tried the 
config from the lm-sensors site for the H8DC8 but I still get these values. The 
w83627 also looks wrong too but that's less of a problem for me (I really am 
just after the cpu temperatures at the moment).
	Is there a known conversion for Opteron temperatures for the k10temp 
module?

	Thanks,

	Derek

--Boundary-00=_qL+3SVjiqrdTwcE
Content-Type: text/plain;
  charset="UTF-8";
  name="lm-sensors.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lm-sensors.txt"

# sensors-detect revision 6031 (2012-03-07 17:14:01 +0100)
# System: Supermicro H8DCL [1234567890]

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):=20
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           Success!
    (driver `k10temp')
AMD Family 15h power sensors...                             Success!
    (driver `fam15h_power')
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):=20
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
=46ound `Winbond W83627DHG-P/W83527HG Super IO Sensors'       Success!
    (address 0xa10, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):=20
=46ound `IPMI BMC KCS' at 0xca2...                            Success!
    (confidence 8, driver `to-be-written')

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): YES
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):=20
Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc SB60=
0/SB700/SB800 SMBus
Module i2c-dev loaded successfully.

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively):=20
Client found at address 0x1d
Probing for `Texas Instruments TMP421'...                   No
Probing for `ST STTS424'...                                 No
Probing for `ST STTS424E'...                                No
Probing for `ST STTS2002'...                                No
Probing for `ST STTS3000'...                                No
Probing for `NXP SE97/SE97B'...                             No
Probing for `NXP SE98'...                                   No
Probing for `Analog Devices ADT7408'...                     No
Probing for `IDT TS3000/TSE2002'...                         No
Probing for `Maxim MAX6604'...                              No
Probing for `Microchip MCP9804'...                          No
Probing for `Microchip MCP98242'...                         No
Probing for `Microchip MCP98243'...                         Success!
    (confidence 5, driver `jc42')
Probing for `Microchip MCP9843'...                          No
Probing for `ON CAT6095/CAT34TS02'...                       No
Probing for `Atmel AT30TS00'...                             No
Client found at address 0x1f
Probing for `Texas Instruments TMP421'...                   No
Probing for `ST STTS424'...                                 No
Probing for `ST STTS424E'...                                No
Probing for `ST STTS2002'...                                No
Probing for `ST STTS3000'...                                No
Probing for `NXP SE97/SE97B'...                             No
Probing for `NXP SE98'...                                   No
Probing for `Analog Devices ADT7408'...                     No
Probing for `IDT TS3000/TSE2002'...                         No
Probing for `Maxim MAX6604'...                              No
Probing for `Microchip MCP9804'...                          No
Probing for `Microchip MCP98242'...                         No
Probing for `Microchip MCP98243'...                         Success!
    (confidence 5, driver `jc42')
Probing for `Microchip MCP9843'...                          No
Probing for `ON CAT6095/CAT34TS02'...                       No
Probing for `Atmel AT30TS00'...                             No
Client found at address 0x2f
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM96080'...             No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83791D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Nuvoton W83795G/ADG'...                        Success!
    (confidence 8, driver `w83795')
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Maxim MAX6639'...                              No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `Fintek custom power control IC'...             No
Probing for `Winbond W83791SD'...                           No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `w83627ehf':
  * ISA bus, address 0xa10
    Chip `Winbond W83627DHG-P/W83527HG Super IO Sensors' (confidence: 9)

Driver `jc42':
  * Bus `SMBus PIIX4 adapter at 0b00'
    Busdriver `i2c_piix4', I2C address 0x1d
    Chip `Microchip MCP98243' (confidence: 5)
  * Bus `SMBus PIIX4 adapter at 0b00'
    Busdriver `i2c_piix4', I2C address 0x1f
    Chip `Microchip MCP98243' (confidence: 5)

Driver `to-be-written':
  * ISA bus, address 0xca2
    Chip `IPMI BMC KCS' (confidence: 8)

Driver `fam15h_power' (autoloaded):
  * Chip `AMD Family 15h power sensors' (confidence: 9)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 15h thermal sensors' (confidence: 9)

Driver `w83795':
  * Bus `SMBus PIIX4 adapter at 0b00'
    Busdriver `i2c_piix4', I2C address 0x2f
    Chip `Nuvoton W83795G/ADG' (confidence: 8)

Note: there is no driver for IPMI BMC KCS yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
jc42
w83627ehf
w83795
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)YES
Successful!

Monitoring programs won't work until the needed modules are
loaded. You may want to run '/etc/init.d/kmod start'
to load them.

Unloading i2c-dev... OK
Unloading cpuid... OK



# sensors
fam15h_power-pci-00c4
Adapter: PCI adapter
power1:       33.84 W  (crit =3D  95.11 W)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +2.9=C2=B0C  (high =3D +70.0=C2=B0C)
                       (crit =3D +70.0=C2=B0C, hyst =3D +67.0=C2=B0C)

fam15h_power-pci-00cc
Adapter: PCI adapter
power1:       31.03 W  (crit =3D  95.11 W)

k10temp-pci-00cb
Adapter: PCI adapter
temp1:         +3.4=C2=B0C  (high =3D +70.0=C2=B0C)
                       (crit =3D +70.0=C2=B0C, hyst =3D +67.0=C2=B0C)

w83627dhg-isa-0a10
Adapter: ISA adapter
Vcore:        +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
in1:          +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
AVCC:         +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
+3.3V:        +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
in4:          +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
in5:          +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
in6:          +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
3VSB:         +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
Vbat:         +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
fan1:           0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan2:           0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan3:           0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan4:           0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
temp1:         -1.0=C2=B0C  (high =3D  -1.0=C2=B0C, hyst =3D  -1.0=C2=B0C) =
 ALARM  sensor =3D CPU diode
temp2:         +0.0=C2=B0C  (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C) =
 ALARM  sensor =3D CPU diode
temp3:         +0.0=C2=B0C  (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C) =
 ALARM  sensor =3D CPU diode
cpu0_vid:    +0.000 V
intrusion0:  ALARM


--Boundary-00=_qL+3SVjiqrdTwcE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_qL+3SVjiqrdTwcE--
