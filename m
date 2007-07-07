From: "Jeremy Harmon" <intrathink@gmail.com>
Date: Sat, 07 Jul 2007 04:11:49 +0000
Subject: [lm-sensors] Weird Voltage Values on a nForce4 motherboard
Message-Id: <67017e450707062111w7f81898y1a1274474341b979@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0651449796643382013=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0651449796643382013==
Content-Type: multipart/alternative; 
	boundary="----=_Part_52034_4733716.1183781509815"

------=_Part_52034_4733716.1183781509815
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm sure these voltage values can't be correct, all of the temps seem
accurate though.

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +47=B0C

w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.57 V  (min =3D  +0.70 V, max =3D  +1.87 V)
+12V:      +3.65 V  (min =3D  +0.79 V, max =3D  +0.79 V)       ALARM
+3.3V:     +3.39 V  (min =3D  +0.80 V, max =3D  +0.13 V)       ALARM
+5V:       +4.96 V  (min =3D  +6.45 V, max =3D  +5.33 V)       ALARM
-12V:      +0.39 V  (min =3D -13.35 V, max =3D -14.91 V)       ALARM
V5SB:      +4.95 V  (min =3D  +0.91 V, max =3D  +3.44 V)       ALARM
VBat:      +3.06 V  (min =3D  +1.49 V, max =3D  +0.86 V)       ALARM
fan1:        0 RPM  (min =3D 9375 RPM, div =3D 8)              ALARM
CPU Fan:  3183 RPM  (min =3D 21093 RPM, div =3D 8)              ALARM
fan3:     6553 RPM  (min =3D 25000 RPM, div =3D 2)              ALARM
M/B Temp:    +38=B0C  (high =3D  +125=B0C, hyst =3D   -25=B0C)   sensor =3D
diode
CPU Temp:  +45.0=B0C  (high =3D   +80=B0C, hyst =3D   -25=B0C)   sensor =3D
diode
temp3:     +67.0=B0C  (high =3D  +125=B0C, hyst =3D   -25=B0C)   sensor =3D
diode
vid:      +0.000 V  (VRM Version 2.4)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled


-----------------------------------
sensors-detect

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 0000:00:01.1: nVidia Corporation nForce=
4
SMBus (MCP)

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
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

Next adapter: NVIDIA i2c adapter 2 at 5:00.0
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter 1 at 5:00.0
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter 0 at 5:00.0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x37
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Probing for `EDID EEPROM'...                                Success!
    (confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53 0x54
0x55 0x56 0x57
Probing for `Maxim MAX6900'...                              No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x56
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Probing for `Sony Vaio EEPROM'...                           No

Next adapter: ivtv i2c driver #0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x1b
Handled by driver `wm8775' (already loaded), chip type `wm8775'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x43
Handled by driver `tuner' (already loaded), chip type `tda9887'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x44
Handled by driver `cx25840' (already loaded), chip type `cx25840'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x50
Handled by driver `tveeprom' (already loaded), chip type `tveeprom'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x61
Handled by driver `tuner' (already loaded), chip type `LG NTSC (TAPE
series)'
    (note: this is probably NOT a sensor chip!)

Next adapter: SMBus nForce2 adapter at 4c40
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
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
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `Fintek custom power control IC'...             No
Probing for `Winbond W83791D'...                            No

Next adapter: SMBus nForce2 adapter at 4c00
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
    (confidence 8, driver `eeprom')
Probing for `EDID EEPROM'...                                No
Probing for `Maxim MAX6900'...                              No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
    (confidence 8, driver `eeprom')

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     Success!
    (confidence 9, driver `k8temp')
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627THF Super IO Sensors'                  Success!
    (address 0x290, driver `w83627hf')

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `NVIDIA i2c adapter 0 at 5:00.0'
    Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55 0x5=
6
0x57)
    Chip `EDID EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 4c00'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 4c00'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `k8temp' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `AMD K8 thermal sensors' (confidence: 9)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter ivtv i2c driver #0
# modprobe unknown adapter NVIDIA i2c adapter 0 at 5:00.0
# modprobe unknown adapter NVIDIA i2c adapter 1 at 5:00.0
# modprobe unknown adapter NVIDIA i2c adapter 2 at 5:00.0
i2c-nforce2
# Chip drivers
eeprom
k8temp
w83627hf
#----cut here----

Thanks,
jeremy

------=_Part_52034_4733716.1183781509815
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I&#39;m sure these voltage values can&#39;t be correct, all of the temps se=
em accurate though.<br><br>k8temp-pci-00c3<br>Adapter: PCI adapter<br>Core0=
 Temp:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; +47=B0C<br><br>w83627thf-isa-0290<br>Adapter: ISA adapter
<br>VCore:&nbsp;&nbsp;&nbsp;&nbsp; +1.57 V&nbsp; (min =3D&nbsp; +0.70 V, ma=
x =3D&nbsp; +1.87 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; <br>+12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.65 V&nbs=
p; (min =3D&nbsp; +0.79 V, max =3D&nbsp; +0.79 V)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ALARM&nbsp; <br>+3.3V:&nbsp;&nbsp;&nbsp;&nbsp; +3.39 V&nbsp; (mi=
n =3D&nbsp; +0.80 V, max =3D&nbsp; +0.13 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ALARM&nbsp; <br>+5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.96 V&nbsp;=
 (min =3D&nbsp; +6.45 V, max =3D&nbsp; +5.33 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ALARM&nbsp;=20
<br>-12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.39 V&nbsp; (min =3D -13.35 V, ma=
x =3D -14.91 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM&nbsp; <br>V5SB:&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.95 V&nbsp; (min =3D&nbsp; +0.91 V, max =3D&=
nbsp; +3.44 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM&nbsp; <br>VBat:&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; +3.06 V&nbsp; (min =3D&nbsp; +1.49 V, max =3D&n=
bsp; +0.86 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM&nbsp; <br>fan1:&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D 9375 RPM, div =
=3D 8)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ALARM&nbsp;=20
<br>CPU Fan:&nbsp; 3183 RPM&nbsp; (min =3D 21093 RPM, div =3D 8)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM&n=
bsp; <br>fan3:&nbsp;&nbsp;&nbsp;&nbsp; 6553 RPM&nbsp; (min =3D 25000 RPM, d=
iv =3D 2)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ALARM&nbsp; <br>M/B Temp:&nbsp;&nbsp;&nbsp; +38=B0C&nbsp; (hig=
h =3D&nbsp; +125=B0C, hyst =3D&nbsp;&nbsp; -25=B0C)&nbsp;&nbsp; sensor =3D =
diode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<br>CPU Temp:&nbsp; +45.0=B0C&nbsp; (high =3D&nbsp;&nbsp; +80=B0C, hyst =3D=
&nbsp;&nbsp; -25=B0C)&nbsp;&nbsp; sensor =3D diode&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>temp3:&nbsp;&nbsp;&nbsp;&nbsp; +67.=
0=B0C&nbsp; (high =3D&nbsp; +125=B0C, hyst =3D&nbsp;&nbsp; -25=B0C)&nbsp;&n=
bsp; sensor =3D diode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <br>vid:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.000 V&nbsp; (VRM Version 2=
.4)<br>alarms:&nbsp;&nbsp; Chassis intrusion detection&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM
<br>beep_enable:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Sound alarm enabled<br><br><br>-----------------------------------<br>senso=
rs-detect<br><br>We can start with probing for (PCI) I2C or SMBus adapters.=
<br>Do you want to probe now? (YES/no): <br>
Probing for PCI bus adapters...<br>Use driver `i2c-nforce2&#39; for device =
0000:00:01.1: nVidia Corporation nForce4 SMBus (MCP)<br><br>We will now try=
 to load each adapter module in turn.<br>Module `i2c-nforce2&#39; already l=
oaded.
<br>If you have undetectable or unsupported adapters, you can have them<br>=
scanned by manually loading the modules before running this script.<br><br>=
To continue, we need module `i2c-dev&#39; to be loaded.<br>Do you want to l=
oad `i2c-dev&#39; now? (YES/no):=20
<br>Module loaded successfully.<br><br>We are now going to do the I2C/SMBus=
 adapter probings. Some chips may<br>be double detected; we choose the one =
with the highest confidence<br>value in that case.<br>If you found that the=
 adapter hung after probing a certain address,
<br>you can specify that address to remain unprobed.<br><br>Next adapter: N=
VIDIA i2c adapter 2 at 5:00.0<br>Do you want to scan it? (YES/no/selectivel=
y): <br><br>Next adapter: NVIDIA i2c adapter 1 at 5:00.0<br>Do you want to =
scan it? (YES/no/selectively):=20
<br><br>Next adapter: NVIDIA i2c adapter 0 at 5:00.0<br>Do you want to scan=
 it? (YES/no/selectively): <br>Client found at address 0x37<br>Client found=
 at address 0x50<br>Probing for `Analog Devices ADM1033&#39;...&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for `Analog Devices ADM1034&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<br>Probing for `SPD EEPROM&#39;...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nbsp; (confidence 1, driver=
 `eeprom&#39;)<br>Probing for `EDID EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; Success!
<br>&nbsp;&nbsp;&nbsp; (confidence 8, driver `eeprom&#39;), other addresses=
: 0x51 0x52 0x53 0x54 0x55 0x56 0x57<br>Probing for `Maxim MAX6900&#39;...&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; No<br>Client found at address 0x51<br>Probing for `=
Analog Devices ADM1033&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 No
<br>Probing for `Analog Devices ADM1034&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<br>Probing for `SPD EEPROM&#39;...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nbsp; (confidence 1, driver=
 `eeprom&#39;)<br>Client found at address 0x52
<br>Probing for `Analog Devices ADM1033&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<br>Probing for `Analog Devices ADM1034&#39;...&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `SPD EEPROM&#39;...=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nbsp; (=
confidence 1, driver `eeprom&#39;)
<br>Client found at address 0x53<br>Probing for `Analog Devices ADM1033&#39=
;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Analog=
 Devices ADM1034&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br=
>Probing for `SPD EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Success!
<br>&nbsp;&nbsp;&nbsp; (confidence 1, driver `eeprom&#39;)<br>Client found =
at address 0x54<br>Probing for `SPD EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nbsp; (confidence 1, driver `eep=
rom&#39;)<br>Client found at address 0x55
<br>Probing for `SPD EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; Success!<br>&nbsp;&nbsp;&nbsp; (confidence 1, driver `eeprom&#39;)<br>Cl=
ient found at address 0x56<br>Probing for `SPD EEPROM&#39;...&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!
<br>&nbsp;&nbsp;&nbsp; (confidence 1, driver `eeprom&#39;)<br>Client found =
at address 0x57<br>Probing for `SPD EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nbsp; (confidence 1, driver `eep=
rom&#39;)<br>Probing for `Sony Vaio EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br><br>Next adapter: ivtv i2c driver #0<br>Do you want to scan it? (YES/no=
/selectively): <br>Client found at address 0x1b<br>Handled by driver `wm877=
5&#39; (already loaded), chip type `wm8775&#39;<br>&nbsp;&nbsp;&nbsp; (note=
: this is probably NOT a sensor chip!)
<br>Client found at address 0x43<br>Handled by driver `tuner&#39; (already =
loaded), chip type `tda9887&#39;<br>&nbsp;&nbsp;&nbsp; (note: this is proba=
bly NOT a sensor chip!)<br>Client found at address 0x44<br>Handled by drive=
r `cx25840&#39; (already loaded), chip type `cx25840&#39;
<br>&nbsp;&nbsp;&nbsp; (note: this is probably NOT a sensor chip!)<br>Clien=
t found at address 0x50<br>Handled by driver `tveeprom&#39; (already loaded=
), chip type `tveeprom&#39;<br>&nbsp;&nbsp;&nbsp; (note: this is probably N=
OT a sensor chip!)<br>Client found at address 0x61
<br>Handled by driver `tuner&#39; (already loaded), chip type `LG NTSC (TAP=
E series)&#39;<br>&nbsp;&nbsp;&nbsp; (note: this is probably NOT a sensor c=
hip!)<br><br>Next adapter: SMBus nForce2 adapter at 4c40<br>Do you want to =
scan it? (YES/no/selectively):=20
<br>Client found at address 0x08<br>Client found at address 0x2f<br>Probing=
 for `National Semiconductor LM78&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for =
`National Semiconductor LM78-J&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `National Semic=
onductor LM79&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for `National Semiconductor LM80&#39;...&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>P=
robing for `Analog Devices ADT7470&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; No<br>Probing for `Winbond W83781D&#39;...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>P=
robing for `Winbond W83782D&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for `Winbond W83792D&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Win=
bond W83793R/G&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Winbond W83791SD&#39;...&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No=
<br>Probing for `Winbond W83627HF&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for `Winbond W83627EHF&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Winbond W8362=
7DHG&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; No<br>Probing for `Asus AS99127F (rev.1)&#39;...&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Asus AS99127F (
rev.2)&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Pro=
bing for `Asus ASB100 Bach&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Analog Devices =
ADM9240&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing =
for `Dallas Semiconductor DS1780&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for `National Semiconductor LM81&#39;...&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>P=
robing for `Analog Devices ADM1029&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; No<br>Probing for `ITE IT8712F&#39;...&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; No<br>Probing for `Fintek custom power control IC&#39;...&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for `Winbond W83791D&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br><br>Next adapter=
: SMBus nForce2 adapter at 4c00<br>Do you want to scan it? (YES/no/selectiv=
ely): <br>Client found at address 0x08<br>Client found at address 0x50
<br>Probing for `Analog Devices ADM1033&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<br>Probing for `Analog Devices ADM1034&#39;...&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `SPD EEPROM&#39;...=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nbsp; (=
confidence 8, driver `eeprom&#39;)
<br>Probing for `EDID EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No=
<br>Probing for `Maxim MAX6900&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Client=
 found at address 0x51<br>Probing for `Analog Devices ADM1033&#39;...&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for `Analog Devices ADM1034&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<br>Probing for `SPD EEPROM&#39;...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nbsp; (confidence 8, driver=
 `eeprom&#39;)<br><br>Some chips are also accessible through the ISA I/O po=
rts. We have to
<br>write to arbitrary I/O ports to probe them. This is usually safe though=
.<br>Yes, you do have ISA I/O ports even if you do not have any ISA slots!<=
br>Do you want to scan the ISA I/O ports? (YES/no): <br>Probing for `Nation=
al Semiconductor LM78&#39; at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No
<br>Probing for `National Semiconductor LM78-J&#39; at 0x290...&nbsp;&nbsp;=
&nbsp;&nbsp; No<br>Probing for `National Semiconductor LM79&#39; at 0x290..=
.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Winbond W83781D&#3=
9; at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Winbond =
W83782D&#39; at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for `Winbond W83627HF&#39; at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; No<br>Probing for `Silicon Integrated Systems SIS5595&#39;...&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `VIA VT82C686 Integ=
rated Sensors&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; No<br>Probing for `VIA VT8231 Integrated Sensors&#39;...&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for `AMD K8 thermal sensors&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nbsp; (confidence 9, driver `k8t=
emp&#39;)<br>Probing for `IPMI BMC KCS&#39; at 0xca0...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `IPMI BMC SMIC&#39; at 0x=
ca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br><br>Some Super I/O chips may also contain sensors. We have to write to<=
br>standard I/O ports to probe them. This is usually safe.<br>Do you want t=
o scan for Super I/O sensors? (YES/no): <br>Probing for Super-I/O at 0x2e/0=
x2f
<br>Trying family `ITE&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `National Semiconductor&#39=
;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `SMSC&#39;...&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying=
 family `VIA/Winbond/Fintek&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No
<br>Probing for Super-I/O at 0x4e/0x4f<br>Trying family `ITE&#39;...&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Try=
ing family `National Semiconductor&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 No<br>Trying family `SMSC&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Trying family `VIA/Winbond/Fintek&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>Found `Winbond W83627THF Super IO Sensor=
s&#39;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nbsp; (address 0=
x290, driver `w83627hf&#39;)<br><br>Now follows a summary of the probes I h=
ave just done.
<br>Just press ENTER to continue: <br><br>Driver `eeprom&#39; (should be in=
serted):<br>&nbsp; Detects correctly:<br>&nbsp; * Bus `NVIDIA i2c adapter 0=
 at 5:00.0&#39;<br>&nbsp;&nbsp;&nbsp; Busdriver `UNKNOWN&#39;, I2C address =
0x50 (and 0x51 0x52 0x53 0x54 0x55 0x56 0x57)
<br>&nbsp;&nbsp;&nbsp; Chip `EDID EEPROM&#39; (confidence: 8)<br>&nbsp; * B=
us `SMBus nForce2 adapter at 4c00&#39;<br>&nbsp;&nbsp;&nbsp; Busdriver `i2c=
-nforce2&#39;, I2C address 0x50<br>&nbsp;&nbsp;&nbsp; Chip `SPD EEPROM&#39;=
 (confidence: 8)<br>&nbsp; * Bus `SMBus nForce2 adapter at 4c00&#39;
<br>&nbsp;&nbsp;&nbsp; Busdriver `i2c-nforce2&#39;, I2C address 0x51<br>&nb=
sp;&nbsp;&nbsp; Chip `SPD EEPROM&#39; (confidence: 8)<br><br>&nbsp; EEPROMs=
 are *NOT* sensors! They are data storage chips commonly<br>&nbsp; found on=
 memory modules (SPD), in monitors (EDID), or in some
<br>&nbsp; laptops, for example.<br><br>Driver `k8temp&#39; (should be inse=
rted):<br>&nbsp; Detects correctly:<br>&nbsp; * ISA bus, undetermined addre=
ss (Busdriver `i2c-isa&#39;)<br>&nbsp;&nbsp;&nbsp; Chip `AMD K8 thermal sen=
sors&#39; (confidence: 9)<br>
<br>Driver `w83627hf&#39; (should be inserted):<br>&nbsp; Detects correctly=
:<br>&nbsp; * ISA bus address 0x0290 (Busdriver `i2c-isa&#39;)<br>&nbsp;&nb=
sp;&nbsp; Chip `Winbond W83627THF Super IO Sensors&#39; (confidence: 9)<br>=
<br>I will now generate the commands needed to load the required modules.
<br>Just press ENTER to continue: <br><br>To make the sensors modules behav=
e correctly, add these lines to<br>/etc/modules:<br><br>#----cut here----<b=
r># I2C adapter drivers<br># modprobe unknown adapter ivtv i2c driver #0
<br># modprobe unknown adapter NVIDIA i2c adapter 0 at 5:00.0<br># modprobe=
 unknown adapter NVIDIA i2c adapter 1 at 5:00.0<br># modprobe unknown adapt=
er NVIDIA i2c adapter 2 at 5:00.0<br>i2c-nforce2<br># Chip drivers<br>eepro=
m
<br>k8temp<br>w83627hf<br>#----cut here----<br><br>Thanks,<br>jeremy<br>

------=_Part_52034_4733716.1183781509815--


--===============0651449796643382013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0651449796643382013==--
