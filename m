From: Raj Mathur <raju@linux-delhi.org>
Date: Wed, 10 Sep 2008 09:35:36 +0000
Subject: [lm-sensors] High temperatures on Intel DG31PR
Message-Id: <200809101453.36339.raju@linux-delhi.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I have a new Intel DG31PR motherboard with an Intel 7200 Core 2 Duo=20
processor reporting what look like very high temperatures.  Running=20
Debian GNU/Linux Testing.

Software:

Kernel:		Linux XXX 2.6.26-1-686 #1 SMP Thu Aug 28 12:00:54 UTC 2008 i686=20
GNU/Linux
libsensors3                           1:2.10.7-1                           =

libsensors4                           1:3.0.2-1+b2                         =

lm-sensors                            1:3.0.2-1+b2                         =


sensors-detect seems to find the sensors fine (transcript at bottom). =20
However now I find that some of the temperatures seem to be=20
unreasonably high.  Please see Sys Temp (76.0C) and Aux Temp (127.0C)=20
in the sensors output under.

Is this normal/expected?  If not, any solution for this issue?  I'd be=20
glad to provide any other information required.

Regards,

-- Raju

*** sensors output
-------------------------------
w83627dhg-isa-0290
Adapter: ISA adapter
VCore:       +1.05 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:        +10.61 V  (min =3D  +2.53 V, max =3D  +4.75 V)   ALARM
AVCC:        +3.33 V  (min =3D  +3.66 V, max =3D  +2.99 V)   ALARM
3VCC:        +3.31 V  (min =3D  +2.26 V, max =3D  +3.17 V)   ALARM
in4:         +1.82 V  (min =3D  +0.78 V, max =3D  +1.58 V)   ALARM
in5:         +1.26 V  (min =3D  +1.11 V, max =3D  +1.17 V)   ALARM
in6:         +0.31 V  (min =3D  +1.48 V, max =3D  +1.23 V)   ALARM
VSB:         +3.30 V  (min =3D  +1.28 V, max =3D  +2.34 V)   ALARM
VBAT:        +3.18 V  (min =3D  +3.58 V, max =3D  +3.10 V)   ALARM
Case Fan:    803 RPM  (min =3D 1163 RPM, div =3D 8)  ALARM
CPU Fan:     917 RPM  (min =3D 2280 RPM, div =3D 8)  ALARM
Aux Fan:       0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan4:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
Sys Temp:    +76.0=B0C  (high =3D  +1.0=B0C, hyst =3D +43.0=B0C)  ALARM  se=
nsor =3D=20
diode
CPU Temp:    +35.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
AUX Temp:   +127.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  se=
nsor =3D=20
thermistor
cpu0_vid:   +2.050 V

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +53.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +51.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)
-------------------------------

*** sensors-detect output (verbiage edited)

-------------------------------
# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
Do you want to load `i2c-dev' now? (YES/no):

Next adapter: SMBus I801 adapter at f000 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x52
Handled by driver `eeprom' (already loaded), chip type `eeprom'
    (note: this is probably NOT a sensor chip!)

Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627DHG Super IO Sensors'                  Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x290
    Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

#----cut here----
# Chip drivers
w83627ehf
coretemp
#----cut here----
-------------------------------

--=20
Raj Mathur                raju@kandalaya.org      http://kandalaya.org/
       GPG: 78D4 FC67 367F 40E2 0DD5  0FEF C968 D0EF CC68 D17F
PsyTrance & Chill: http://schizoid.in/   ||   It is the mind that moves

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
