From: Schwarz <schwarz.gentoo@vp.pl>
Date: Tue, 21 Apr 2009 16:13:10 +0000
Subject: [lm-sensors] Problem with MSI MS-7031
Message-Id: <20090421181310.205493a9@nat.nasa.one.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/S=DFYo2XlsApm4sn29Ugdz2"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--MP_/S=DFYo2XlsApm4sn29Ugdz2
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have problem reading sensors from MSI MS-7031 (or MSI RS350M) this is
Fujitsu-Siemens OEM board, with Socekt 478 and integrated Radeon 9200
Pro (IGA) CPU: Pentium 4 3GHz HT with 1GB ram.
Chipset: ATI iXP300=20
Sensors: w83627thf
This board have smartfun control turned on. (slow down fans under 40C)
My system is Gentoo x86 STABLE on Gentoo Hardened Kernel
Profile: [Gentoo Server]
lm_sensors 2.10.7

My sensors output:
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.94 V  (min =3D  +1.94 V, max =3D  +1.94 V)       ALARM  (beep)
+12V:     +15.50 V  (min =3D +15.50 V, max =3D +15.50 V)       ALARM  (beep)
+3.3V:     +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM  (beep)
+5V:       +6.80 V  (min =3D  +6.80 V, max =3D  +6.80 V)       ALARM  (beep)
-12V:      +6.06 V  (min =3D  +6.06 V, max =3D  +6.06 V)       ALARM  (beep)
V5SB:      +6.85 V  (min =3D  +6.85 V, max =3D  +6.85 V)       ALARM  (beep)
VBat:      +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM  (beep)
fan1:        0 RPM  (min =3D    0 RPM, div =3D 128)              ALARM
(beep) CPU Fan:     0 RPM  (min =3D    0 RPM, div =3D 128)
ALARM  (beep) fan3:        0 RPM  (min =3D    0 RPM, div =3D
128)              ALARM  (beep) M/B Temp:     -1=B0C  (high =3D    -1=B0C,
hyst =3D    -1=B0C)   sensor =3D diode   ALARM   (beep) CPU Temp:   +0.0=B0C
(high =3D    +0=B0C, hyst =3D    +0=B0C)   sensor =3D diode   ALARM   (beep)
temp3:      +0.0=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)   sensor =3D=
 diode
ALARM   (beep) alarms:   Chassis intrusion
detection                      ALARM beep_enable: Sound alarm enabled

Everything shows wrong value.
Changing sensors type in /etc/sensors.conf does not help (I tried:
1,2,3,4)
In BIOS I see that
CPU have ~45C
GPU: ~60C (Integrated ATI Radeon 9200 Pro)
fan1: ~3000rpm (Pentagram 80x80mm 12V ~0.2mA)
fan2: ~1200rpm (really big and slow 160x160mm 12V ~0.17mA)
fan3: does not exist

I attached sensors-detect output as s.log

pls, help me get somthing from my sensors...=20
--=20
Schwarz . Gentoo @gmail.com


--MP_/S=DFYo2XlsApm4sn29Ugdz2
Content-Type: text/x-log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=s.log

Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5790, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5801, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5790, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5801, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5790, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5801, <STDIN> line 1.
# sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc ATI SMBus

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: radeonfb monid (i2c-0)
Do you want to scan it? (YES/no/selectively): 
Next adapter: radeonfb dvi (i2c-1)
Do you want to scan it? (YES/no/selectively): 
Next adapter: radeonfb vga (i2c-2)
Do you want to scan it? (YES/no/selectively): Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5790, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5801, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5790, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5801, <STDIN> line 1.

Next adapter: radeonfb crt2 (i2c-3)
Do you want to scan it? (YES/no/selectively): 
Next adapter: SMBus PIIX4 adapter at 1000 (i2c-4)
Do you want to scan it? (YES/no/selectively): Client found at address 0x2f
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
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O at 0x2e/0x2f
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

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 
Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x290
    Chip `Winbond W83627THF/THG Super IO Sensors' (confidence: 9)

Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5929, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5929, <STDIN> line 1.
Use of uninitialized value in pattern match (m//) at /usr/sbin/sensors-detect line 5931, <STDIN> line 1.
To load everything that is needed, execute the commands below...

#----cut here----
# Chip drivers
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----end cut here----
Do you want to overwrite /etc/conf.d/lm_sensors? Enter s for other filename (YES/no/s): Done.
You should now start the lm_sensors service to load the required
kernel modules.


--MP_/S=DFYo2XlsApm4sn29Ugdz2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/S=DFYo2XlsApm4sn29Ugdz2--
