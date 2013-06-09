From: Steven Vanden Branden <stevenvandenbrandenstift@gmail.com>
Date: Sun, 09 Jun 2013 13:02:18 +0000
Subject: [lm-sensors] k10temp-pci-00c3 goes from 11 to 0 degrees
Message-Id: <CABp=A6OdWf_q8vcc65R532xJswsYQBnNgX9ZyyaLDy6hx4qWGA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7139907208506521288=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7139907208506521288==
Content-Type: multipart/alternative; boundary=20cf3040e5382156d004deb84631

--20cf3040e5382156d004deb84631
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hello,

im trying to get my Amd A4-5300 apu temperature readings.

AMD A4-5300 APU with Radeon(tm) HD Graphics (fam: 15, model: 10, stepping:
01)

im running on:
3.9.4-1-ARCH
lm_sensors-3.3.4-1
MSI fm2-a75ma-e35 motherboard


sensor output (i changed to APU temp label)

# sensors
k10temp-pci-00c3
Adapter: PCI adapter
APU Temp:      +0.0C  (high =3D +70.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)


this value seems to go up little afther waiting, when rerunning the sensors
it drops down again to 0.

should i use the fam15h_power module? i tried but it does not work either.

i tried manually deleting and forcing both modules but it seems the the
module gets loaded right but the temp is not good.

I comfirm the sensor working on windows 7 and in the bios wich is update to
the latest version (2.0).

i want to help sort this out,
just tell me how i can help, i can program/compile/debug,

greets,
Steven VDB

sensors-detect
# sensors-detect revision 6170 (2013-05-20 21:25:22 +0200)
# System: MSI MS-7721 [1.0]
# Board: MSI FM2-A75MA-E35 (MS-7721)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): Silicon
Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O
at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found unknown chip with ID 0x1106

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no): Probing for `IPMI BMC KCS' at 0xca0...
       No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): Probing for
`National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): Using driver
`i2c-piix4' for device 0000:00:14.0: AMD Hudson-2 SMBus

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively): Client found at address 0x28
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM96080'...             No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: Radeon i2c bit bus 0x90 (i2c-1)
Do you want to scan it? (yes/NO/selectively):
Next adapter: Radeon i2c bit bus 0x91 (i2c-2)
Do you want to scan it? (yes/NO/selectively):
Next adapter: Radeon i2c bit bus 0x92 (i2c-3)
Do you want to scan it? (yes/NO/selectively):
Next adapter: Radeon i2c bit bus 0x93 (i2c-4)
Do you want to scan it? (yes/NO/selectively):
Next adapter: Radeon i2c bit bus 0x94 (i2c-5)
Do you want to scan it? (yes/NO/selectively):
Next adapter: Radeon i2c bit bus 0x95 (i2c-6)
Do you want to scan it? (yes/NO/selectively):
Next adapter: Radeon aux bus DP-auxch (i2c-7)
Do you want to scan it? (yes/NO/selectively):
Sorry, no sensors were detected.

--20cf3040e5382156d004deb84631
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hello,<div><br></div><div style>im trying to get my Amd A4=
-5300 apu temperature readings.</div><div style><br></div><div style><div>A=
MD A4-5300 APU with Radeon(tm) HD Graphics (fam: 15, model: 10, stepping: 0=
1)</div>
</div><div style><br></div><div style>im running on:</div><div style>3.9.4-=
1-ARCH</div><div style>lm_sensors-3.3.4-1</div><div style>MSI fm2-a75ma-e35=
 motherboard</div><div style><br></div><div style><br></div><div style>
sensor output (i changed to APU temp label)</div><div style><div><br></div>=
<div># sensors=A0</div><div>k10temp-pci-00c3</div><div>Adapter: PCI adapter=
</div><div>APU Temp: =A0 =A0 =A0+0.0C =A0(high =3D +70.0=B0C)</div><div>=A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D +70.0=B0C, hyst =3D +=
69.0=B0C)</div>
<div><br></div><div><br></div><div style>this value seems to go up little a=
fther waiting, when rerunning the sensors it drops down again to 0.</div><d=
iv style><br></div><div style>should i use the fam15h_power module? i tried=
 but it does not work either.</div>
<div style><br></div><div style>i tried manually deleting and forcing both =
modules but it seems the the module gets loaded right but the temp is not g=
ood.</div><div style><br></div><div style>I comfirm the sensor working on w=
indows 7 and in the bios wich is update to the latest version (2.0).</div>
<div style><br></div><div style>i want to help sort this out,</div><div sty=
le>just tell me how i can help, i can program/compile/debug,</div><div styl=
e><br></div><div style>greets,</div><div style>Steven VDB</div><div><br>
</div><div><div>sensors-detect</div><div># sensors-detect revision 6170 (20=
13-05-20 21:25:22 +0200)</div><div># System: MSI MS-7721 [1.0]</div><div># =
Board: MSI FM2-A75MA-E35 (MS-7721)</div><div><br></div><div>This program wi=
ll help you determine which kernel modules you need</div>
<div>to load to use lm_sensors most effectively. It is generally safe</div>=
<div>and recommended to accept the default answers to all questions,</div><=
div>unless you know what you&#39;re doing.</div><div><br></div><div>Some so=
uth bridges, CPUs or memory controllers contain embedded sensors.</div>
<div>Do you want to scan for them? This is totally safe. (YES/no): Silicon =
Integrated Systems SIS5595... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 N=
o</div><div>VIA VT82C686 Integrated Sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0No</div><div>VIA VT8231 Integrated Sensors... =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div>
<div>AMD K8 thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 No</div><div>AMD Family 10h thermal sensors... =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>AMD Family 11h=
 thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No<=
/div><div>
AMD Family 12h and 14h thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 No</div><div>AMD Family 15h thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>AMD Family 15h power sensors... =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>AMD Fa=
mily 16h power sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 No</div>
<div>Intel digital thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 No</div><div>Intel AMB FB-DIMM thermal sensor... =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>VIA C7 thermal sen=
sor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0No</div><div>
VIA Nano thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0No</div><div><br></div><div>Some Super I/O chips contain=
 embedded sensors. We have to write to</div><div>standard I/O ports to prob=
e them. This is usually safe.</div>
<div>Do you want to scan for Super I/O sensors? (YES/no): Probing for Super=
-I/O at 0x2e/0x2f</div><div>Trying family `National Semiconductor/ITE&#39;.=
.. =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>Trying family `SMSC&#39;... =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</di=
v>
<div>Trying family `VIA/Winbond/Nuvoton/Fintek&#39;... =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 No</div><div>Trying family `ITE&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div>Probing for Su=
per-I/O at 0x4e/0x4f</div><div>Trying family `National Semiconductor/ITE&#3=
9;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>
<div>Trying family `SMSC&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>Trying family `VIA/Winbond/Nuv=
oton/Fintek&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 Yes</div><div>Found unknown=
 chip with ID 0x1106</div><div><br></div><div>Some systems (mainly servers)=
 implement IPMI, a set of common interfaces</div>
<div>through which system health data may be retrieved, amongst other thing=
s.</div><div>We first try to get the information from SMBIOS. If we don&#39=
;t find it</div><div>there, we have to read from arbitrary I/O ports to pro=
be for such</div>
<div>interfaces. This is normally safe. Do you want to scan for IPMI</div><=
div>interfaces? (YES/no): Probing for `IPMI BMC KCS&#39; at 0xca0... =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div>Probing for `IPMI BMC S=
MIC&#39; at 0xca8... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>
<div><br></div><div>Some hardware monitoring chips are accessible through t=
he ISA I/O ports.</div><div>We have to write to arbitrary I/O ports to prob=
e them. This is usually</div><div>safe though. Yes, you do have ISA I/O por=
ts even if you do not have any</div>
<div>ISA slots! Do you want to scan the ISA I/O ports? (YES/no): Probing fo=
r `National Semiconductor LM78&#39; at 0x290... =A0 =A0 =A0 No</div><div>Pr=
obing for `National Semiconductor LM79&#39; at 0x290... =A0 =A0 =A0 No</div=
><div>Probing for `Winbond W83781D&#39; at 0x290... =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 No</div>
<div>Probing for `Winbond W83782D&#39; at 0x290... =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 No</div><div><br></div><div>Lastly, we can probe the I2C/SMBus =
adapters for connected hardware</div><div>monitoring devices. This is the m=
ost risky part, and while it works</div>
<div>reasonably well on most systems, it has been reported to cause trouble=
</div><div>on some systems.</div><div>Do you want to probe the I2C/SMBus ad=
apters now? (YES/no): Using driver `i2c-piix4&#39; for device 0000:00:14.0:=
 AMD Hudson-2 SMBus</div>
<div><br></div><div>Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)</div>=
<div>Do you want to scan it? (YES/no/selectively): Client found at address =
0x28</div><div>Probing for `National Semiconductor LM78&#39;... =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0No</div>
<div>Probing for `National Semiconductor LM79&#39;... =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0No</div><div>Probing for `National Semiconductor LM80&#39;... =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div>Probing for `National Semicondu=
ctor LM96080&#39;... =A0 =A0 =A0 =A0 =A0 =A0 No</div>
<div>Probing for `Winbond W83781D&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0No</div><div>Probing for `Winbond W83782D&#39;... =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div>Probing=
 for `Winbond W83627HF&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 No</div>
<div>Probing for `Winbond W83627EHF&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0No</div><div>Probing for `Winbond W83627DHG/W83667HG/W8=
3677HG&#39;... =A0 =A0 =A0 =A0No</div><div>Probing for `Asus AS99127F (rev.=
1)&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div>
<div>Probing for `Asus AS99127F (rev.2)&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0No</div><div>Probing for `Asus ASB100 Bach&#39;... =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>Probing for `Analo=
g Devices ADM1029&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>
<div>Probing for `ITE IT8712F&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div>Client found at address 0x52</div><=
div>Probing for `Analog Devices ADM1033&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 No</div><div>Probing for `Analog Devices ADM1034&#39;... =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>
<div>Probing for `SPD EEPROM&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 Yes</div><div>=A0 =A0 (confidence 8, not a hard=
ware monitoring chip)</div><div>Client found at address 0x53</div><div>Prob=
ing for `Analog Devices ADM1033&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 No</div>
<div>Probing for `Analog Devices ADM1034&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 No</div><div>Probing for `SPD EEPROM&#39;... =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Yes</div><div>=A0 =A0 (=
confidence 8, not a hardware monitoring chip)</div><div>
<br></div><div>Next adapter: Radeon i2c bit bus 0x90 (i2c-1)</div><div>Do y=
ou want to scan it? (yes/NO/selectively):=A0</div><div>Next adapter: Radeon=
 i2c bit bus 0x91 (i2c-2)</div><div>Do you want to scan it? (yes/NO/selecti=
vely):=A0</div>
<div>Next adapter: Radeon i2c bit bus 0x92 (i2c-3)</div><div>Do you want to=
 scan it? (yes/NO/selectively):=A0</div><div>Next adapter: Radeon i2c bit b=
us 0x93 (i2c-4)</div><div>Do you want to scan it? (yes/NO/selectively):=A0<=
/div>
<div>Next adapter: Radeon i2c bit bus 0x94 (i2c-5)</div><div>Do you want to=
 scan it? (yes/NO/selectively):=A0</div><div>Next adapter: Radeon i2c bit b=
us 0x95 (i2c-6)</div><div>Do you want to scan it? (yes/NO/selectively):=A0<=
/div>
<div>Next adapter: Radeon aux bus DP-auxch (i2c-7)</div><div>Do you want to=
 scan it? (yes/NO/selectively):=A0</div><div>Sorry, no sensors were detecte=
d.</div></div><div><br></div></div></div>

--20cf3040e5382156d004deb84631--


--===============7139907208506521288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7139907208506521288==--
