From: "=?ISO-8859-1?Q?Andr=E9s_Moreira?=" <elkpichico@gmail.com>
Date: Sun, 07 Sep 2008 19:52:22 +0000
Subject: [lm-sensors] few information on gateway T-1625
Message-Id: <b69e42c40809071252l7b5dc005l5e99be4ce3a9b19@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3892941841283947461=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3892941841283947461==
Content-Type: multipart/alternative; 
	boundary="----=_Part_86830_8618805.1220817143031"

------=_Part_86830_8618805.1220817143031
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
 I recently bought a gateway T-1625 notebook and I want to know information
about my fan. The fan is making a noise really annoying.

the sensors output is:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +42.0=B0C
Core0 Temp:  +39.0=B0C
Core1 Temp:  +36.0=B0C
Core1 Temp:  +39.0=B0C

and the sensors-detect is :

andres@atlantis:~$ sudo sensors-detect
# sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc SB600
SMBus

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus PIIX4 adapter at 8410 (i2c-0)
Do you want to scan it? (YES/no/selectively):
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
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No
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

Driver `k8temp' (should be inserted):
  Detects correctly:
  * Chip `AMD K8 thermal sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To load everything that is needed, add this to /etc/modules:

#----cut here----
# Chip drivers
k8temp
#----cut here----

Do you want to add these lines automatically? (yes/NO)


How can i do to set up my fan configs?

Thanks a lot!
Bye,
 Andres.



--=20
Andr=E9s Moreira.
"Si el universo fuera un programa estar=EDa escrito en C
y correr=EDa bajo Unix"
An=F3nimo

------=_Part_86830_8618805.1220817143031
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">Hi, <br>&nbsp;I recently bought a gateway T-1625 notebook =
and I want to know information about my fan. The fan is making a noise real=
ly annoying.<br><br>the sensors output is:<br><br>k8temp-pci-00c3<br>Adapte=
r: PCI adapter<br>
Core0 Temp:&nbsp; +42.0=B0C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; <br>Core0 Temp:&nbsp; +39.0=B0C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Core1 Temp:&nbsp; +36.0=B0C&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Core1 Temp:&nbsp; +39.0=
=B0C&nbsp;&nbsp;&nbsp; <br><br>and the sensors-detect is :<br>
<br>andres@atlantis:~$ sudo sensors-detect <br># sensors-detect revision 50=
16 (2007-11-11 22:20:16 +0100)<br><br>This program will help you determine =
which kernel modules you need<br>to load to use lm_sensors most effectively=
. It is generally safe<br>
and recommended to accept the default answers to all questions,<br>unless y=
ou know what you&#39;re doing.<br><br>We can start with probing for (PCI) I=
2C or SMBus adapters.<br>Do you want to probe now? (YES/no): <br>Probing fo=
r PCI bus adapters...<br>
Use driver `i2c-piix4&#39; for device 0000:00:14.0: ATI Technologies Inc SB=
600 SMBus<br><br>We will now try to load each adapter module in turn.<br>Mo=
dule `i2c-piix4&#39; already loaded.<br>If you have undetectable or unsuppo=
rted adapters, you can have them<br>
scanned by manually loading the modules before running this script.<br><br>=
We are now going to do the I2C/SMBus adapter probings. Some chips may<br>be=
 double detected; we choose the one with the highest confidence<br>value in=
 that case.<br>
If you found that the adapter hung after probing a certain address,<br>you =
can specify that address to remain unprobed.<br><br>Next adapter: SMBus PII=
X4 adapter at 8410 (i2c-0)<br>Do you want to scan it? (YES/no/selectively):=
 <br>
Client found at address 0x50<br>Probing for `Analog Devices ADM1033&#39;...=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Analog Dev=
ices ADM1034&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Pro=
bing for `SPD EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<=
br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>Probin=
g for `EDID EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Client=
 found at address 0x51<br>Probing for `Analog Devices ADM1033&#39;...&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; No<br>Probing for `SPD EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; Yes<br>&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware =
monitoring chip)<br>Probing for `EDID EEPROM&#39;...&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; No<br>
<br>Some chips are also accessible through the ISA I/O ports. We have to<br=
>write to arbitrary I/O ports to probe them. This is usually safe though.<b=
r>Yes, you do have ISA I/O ports even if you do not have any ISA slots!<br>
Do you want to scan the ISA I/O ports? (YES/no): <br>Probing for `National =
Semiconductor LM78&#39; at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<=
br>Probing for `National Semiconductor LM78-J&#39; at 0x290...&nbsp;&nbsp;&=
nbsp;&nbsp; No<br>Probing for `National Semiconductor LM79&#39; at 0x290...=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Winbond W83781D&#39; at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; No<br>Probing for `Winbond W83782D&#39; at 0x290...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; No<br>Probing for `Silicon Integrated Systems SIS5595&#39;...=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `VIA VT8=
2C686 Integrated Sensors&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `VIA VT8231 Integrated Sensors&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `IP=
MI BMC KCS&#39; at 0xca0...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; No<br>Probing for `IPMI BMC SMIC&#39; at 0xca8...&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; No<br><br>Some Super I/O chips may also contain sen=
sors. We have to write to<br>
standard I/O ports to probe them. This is usually safe.<br>Do you want to s=
can for Super I/O sensors? (YES/no): <br>Probing for Super-I/O at 0x2e/0x2f=
<br>Trying family `National Semiconductor&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; No<br>
Trying family `SMSC&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; No<br>Trying family `VIA/Winbond/Fintek&#39;...&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `ITE&#=
39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; No<br>Probing for Super-I/O at 0x4e/0x4f<br>
Trying family `National Semiconductor&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; No<br>Trying family `SMSC&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `VIA/Winbond/Fintek&#39;..=
.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying fam=
ily `ITE&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; No<br>
<br>Some CPUs or memory controllers may also contain embedded sensors.<br>D=
o you want to scan for them? (YES/no): <br>AMD K8 thermal sensors...&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nb=
sp; (driver `k8temp&#39;)<br>AMD K10 thermal sensors...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Intel Core family thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Intel AMB FB-DIMM thermal sensor...&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br><br=
>Now follows a summary of the probes I have just done.<br>Just press ENTER =
to continue: <br>
<br>Driver `k8temp&#39; (should be inserted):<br>&nbsp; Detects correctly:<=
br>&nbsp; * Chip `AMD K8 thermal sensors&#39; (confidence: 9)<br><br>I will=
 now generate the commands needed to load the required modules.<br>Just pre=
ss ENTER to continue: <br>
<br>To load everything that is needed, add this to /etc/modules:<br><br>#--=
--cut here----<br># Chip drivers<br>k8temp<br>#----cut here----<br><br>Do y=
ou want to add these lines automatically? (yes/NO)<br><br><br>How can i do =
to set up my fan configs?<br>
<br>Thanks a lot!<br>Bye, <br>&nbsp;Andres.<br>&nbsp; <br><br clear=3D"all"=
><br>-- <br>Andr=E9s Moreira.<br>&quot;Si el universo fuera un programa est=
ar=EDa escrito en C<br>y correr=EDa bajo Unix&quot; <br> An=F3nimo<br>
</div>

------=_Part_86830_8618805.1220817143031--


--===============3892941841283947461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3892941841283947461==--
