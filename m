From: he liang <billpeace@gmail.com>
Date: Fri, 10 Jul 2009 20:13:16 +0000
Subject: [lm-sensors] Can someone give me some help? thanks
Message-Id: <c98b13f80907101313g76b337batfe028da5046fcd00@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0739114408092496067=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0739114408092496067==
Content-Type: multipart/alternative; boundary=0016e64652e2468265046e5f9a00

--0016e64652e2468265046e5f9a00
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: NVIDIA i2c adapter  (i2c-0)
Do you want to scan it? (YES/no/selectively): yes

Next adapter: NVIDIA i2c adapter  (i2c-1)
Do you want to scan it? (YES/no/selectively): yes

Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively): yes

Next adapter: SMBus I801 adapter at 0400 (i2c-3)
Do you want to scan it? (YES/no/selectively): yes
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
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): yes
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
Do you want to scan for Super I/O sensors? (YES/no): yes
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

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no): yes
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x290
    Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To load everything that is needed, add this to /etc/modules:

#----cut here----
# Chip drivers
w83627ehf
coretemp
#----cut here----

Do you want to add these lines automatically? (yes/NO)yes
psy@psy-desktop:~$ sudo sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

--0016e64652e2468265046e5f9a00
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p># sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)</p>
<p>This program will help you determine which kernel modules you need<br>to=
 load to use lm_sensors most effectively. It is generally safe<br>and recom=
mended to accept the default answers to all questions,<br>unless you know w=
hat you&#39;re doing.</p>

<p>We can start with probing for (PCI) I2C or SMBus adapters.<br>Do you wan=
t to probe now? (YES/no): y<br>Probing for PCI bus adapters...<br>Use drive=
r `i2c-i801&#39; for device 0000:00:1f.3: Intel 82801H ICH8</p>
<p>We will now try to load each adapter module in turn.<br>Module `i2c-i801=
&#39; already loaded.<br>If you have undetectable or unsupported adapters, =
you can have them<br>scanned by manually loading the modules before running=
 this script.</p>

<p>We are now going to do the I2C/SMBus adapter probings. Some chips may<br=
>be double detected; we choose the one with the highest confidence<br>value=
 in that case.<br>If you found that the adapter hung after probing a certai=
n address,<br>
you can specify that address to remain unprobed.</p>
<p>Next adapter: NVIDIA i2c adapter=A0 (i2c-0)<br>Do you want to scan it? (=
YES/no/selectively): yes</p>
<p>Next adapter: NVIDIA i2c adapter=A0 (i2c-1)<br>Do you want to scan it? (=
YES/no/selectively): yes</p>
<p>Next adapter: NVIDIA i2c adapter=A0 (i2c-2)<br>Do you want to scan it? (=
YES/no/selectively): yes</p>
<p>Next adapter: SMBus I801 adapter at 0400 (i2c-3)<br>Do you want to scan =
it? (YES/no/selectively): yes<br>Client found at address 0x50<br>Probing fo=
r `Analog Devices ADM1033&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No<br>Probing for `Analog Devices ADM1034&#39;...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Probing for `SPD EEPROM&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes<br>=A0=A0=A0 (co=
nfidence 8, not a hardware monitoring chip)<br>Probing for `EDID EEPROM&#39=
;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Client found at address 0x51<br>
Probing for `Analog Devices ADM1033&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `Analog Devices ADM1034&#3=
9;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Pro=
bing for `SPD EEPROM&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes<br>=A0=A0=A0 (confi=
dence 8, not a hardware monitoring chip)<br>
Probing for `EDID EEPROM&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Client found at a=
ddress 0x52<br>Probing for `Analog Devices ADM1033&#39;...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `Analog Dev=
ices ADM1034&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 No<br>
Probing for `SPD EEPROM&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes<br>=A0=A0=A0 (co=
nfidence 8, not a hardware monitoring chip)<br>Probing for `EDID EEPROM&#39=
;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Client found at address 0x53<br>
Probing for `Analog Devices ADM1033&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `Analog Devices ADM1034&#3=
9;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Pro=
bing for `SPD EEPROM&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes<br>=A0=A0=A0 (confi=
dence 8, not a hardware monitoring chip)<br>
Probing for `EDID EEPROM&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No</p>
<p>Some chips are also accessible through the ISA I/O ports. We have to<br>=
write to arbitrary I/O ports to probe them. This is usually safe though.<br=
>Yes, you do have ISA I/O ports even if you do not have any ISA slots!<br>
Do you want to scan the ISA I/O ports? (YES/no): yes<br>Probing for `Nation=
al Semiconductor LM78&#39; at 0x290...=A0=A0=A0=A0=A0=A0 No<br>Probing for =
`National Semiconductor LM78-J&#39; at 0x290...=A0=A0=A0=A0 No<br>Probing f=
or `National Semiconductor LM79&#39; at 0x290...=A0=A0=A0=A0=A0=A0 No<br>
Probing for `Winbond W83781D&#39; at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `Winbond W83782D&#39; at 0x290..=
.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `=
Silicon Integrated Systems SIS5595&#39;...=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Pr=
obing for `VIA VT82C686 Integrated Sensors&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 No<br>
Probing for `VIA VT8231 Integrated Sensors&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No<br>Probing for `IPMI BMC KCS&#39; at 0xca0...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `I=
PMI BMC SMIC&#39; at 0xca8...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No</p>
<p>Some Super I/O chips may also contain sensors. We have to write to<br>st=
andard I/O ports to probe them. This is usually safe.<br>Do you want to sca=
n for Super I/O sensors? (YES/no): yes <br>Probing for Super-I/O at 0x2e/0x=
2f<br>
Trying family `National Semiconductor&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `SMSC&#39;...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No<br>Trying family `VIA/Winbond/Fintek&#39;...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes<br>Found `Win=
bond W83627DHG Super IO Sensors&#39;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 Success!<br>
=A0=A0=A0 (address 0x290, driver `w83627ehf&#39;)<br>Probing for Super-I/O =
at 0x4e/0x4f<br>Trying family `National Semiconductor&#39;...=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `SMSC&#39;..=
.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Trying family `VIA/Winbond/Fintek&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `ITE&#39;...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No</p>
<p>Some CPUs or memory controllers may also contain embedded sensors.<br>Do=
 you want to scan for them? (YES/no): yes<br>AMD K8 thermal sensors...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>AMD K10 thermal sensors...=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 No<br>
Intel Core family thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!<br>=A0=A0=A0 (driver `coretemp&#=
39;)<br>Intel AMB FB-DIMM thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No</p>
<p>Now follows a summary of the probes I have just done.<br>Just press ENTE=
R to continue:=A0=A0=A0 </p>
<p>Driver `w83627ehf&#39; (should be inserted):<br>=A0 Detects correctly:<b=
r>=A0 * ISA bus, address 0x290<br>=A0=A0=A0 Chip `Winbond W83627DHG Super I=
O Sensors&#39; (confidence: 9)</p>
<p>Driver `coretemp&#39; (should be inserted):<br>=A0 Detects correctly:<br=
>=A0 * Chip `Intel Core family thermal sensor&#39; (confidence: 9)</p>
<p>I will now generate the commands needed to load the required modules.<br=
>Just press ENTER to continue: </p>
<p>To load everything that is needed, add this to /etc/modules:</p>
<p>#----cut here----<br># Chip drivers<br>w83627ehf<br>coretemp<br>#----cut=
 here----</p>
<p>Do you want to add these lines automatically? (yes/NO)yes<br><a href=3D"=
mailto:psy@psy-desktop:~$">psy@psy-desktop:~$</a> sudo sensors<br>No sensor=
s found!<br>Make sure you loaded all the kernel drivers you need.<br>Try se=
nsors-detect to find out which these are.<br>
</p>

--0016e64652e2468265046e5f9a00--


--===============0739114408092496067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0739114408092496067==--
