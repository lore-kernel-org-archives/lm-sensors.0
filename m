From: Kazuya <kazuya25@hotmail.fr>
Date: Mon, 04 Jul 2011 14:33:52 +0000
Subject: [lm-sensors] IT8772E info and reports
Message-Id: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5721156157130578335=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5721156157130578335==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0035_01CC3A5F.C8E09F90"
Content-Language: fr

------=_NextPart_000_0035_01CC3A5F.C8E09F90
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

I am  a bit stuck currently. I would like to know if you can help me. I
would like to access to the temperature of my processor. That what I have
already done ..

If you need more information I can send everything you want.

My system :

root@teddy:~# uname -a

Linux teddy 2.6.32-5-amd64 #1 SMP Tue Jun 14 09:42:28 UTC 2011 x86_64
GNU/Linux

 

Other information :

Shuttle SH67H3 - i5 2300                                                

 

The last version of sensors detect gives :

 

root@teddy:~# perl sensors-detect

# sensors-detect revision 5981 (2011-07-03 13:57:57 +0200)

# System: Shuttle SH67H3

# Board: Shuttle FH67

 

This program will help you determine which kernel modules you need

to load to use lm_sensors most effectively. It is generally safe

and recommended to accept the default answers to all questions,

unless you know what you're doing.

 

Some south bridges, CPUs or memory controllers contain embedded sensors.

Do you want to scan for them? This is totally safe. (YES/no): yes

Module cpuid loaded successfully.

Silicon Integrated Systems SIS5595...                       No

VIA VT82C686 Integrated Sensors...                          No

VIA VT8231 Integrated Sensors...                            No

AMD K8 thermal sensors...                                   No

AMD Family 10h thermal sensors...                           No

AMD Family 11h thermal sensors...                           No

AMD Family 12h and 14h thermal sensors...                   No

AMD Family 15h thermal sensors...                           No

AMD Family 15h power sensors...                             No

Intel digital thermal sensor...                             Success!

    (driver `coretemp')

Intel AMB FB-DIMM thermal sensor...                         No

VIA C7 thermal sensor...                                    No

VIA Nano thermal sensor...                                  No

 

Some Super I/O chips contain embedded sensors. We have to write to

standard I/O ports to probe them. This is usually safe.

Do you want to scan for Super I/O sensors? (YES/no): yes

Probing for Super-I/O at 0x2e/0x2f

Trying family `National Semiconductor/ITE'...               No

Trying family `SMSC'...                                     No

Trying family `VIA/Winbond/Nuvoton/Fintek'...               No

Trying family `ITE'...                                      Yes

Found `ITE IT8772E Super IO Sensors'                        Success!

    (address 0xa30, driver `to-be-written')

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

interfaces? (YES/no): yes

Probing for `IPMI BMC KCS' at 0xca0...                      No

Probing for `IPMI BMC SMIC' at 0xca8...                     No

 

Some hardware monitoring chips are accessible through the ISA I/O ports.

We have to write to arbitrary I/O ports to probe them. This is usually

safe though. Yes, you do have ISA I/O ports even if you do not have any

ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes

Probing for `National Semiconductor LM78' at 0x290...       No

Probing for `National Semiconductor LM79' at 0x290...       No

Probing for `Winbond W83781D' at 0x290...                   No

Probing for `Winbond W83782D' at 0x290...                   No

 

Lastly, we can probe the I2C/SMBus adapters for connected hardware

monitoring devices. This is the most risky part, and while it works

reasonably well on most systems, it has been reported to cause trouble

on some systems.

Do you want to probe the I2C/SMBus adapters now? (YES/no): yes

Using driver `i2c-i801' for device 0000:00:1f.3: Intel Cougar Point (PCH)

 

Next adapter: SMBus I801 adapter at f040 (i2c-0)

Do you want to scan it? (yes/NO/selectively): yes

Client found at address 0x50

Handled by driver `eeprom' (already loaded), chip type `eeprom'

    (note: this is probably NOT a sensor chip!)

Client found at address 0x52

Handled by driver `eeprom' (already loaded), chip type `eeprom'

    (note: this is probably NOT a sensor chip!)

 

Now follows a summary of the probes I have just done.

Just press ENTER to continue:

 

Driver `to-be-written':

  * ISA bus, address 0xa30

    Chip `ITE IT8772E Super IO Sensors' (confidence: 9)

 

Driver `coretemp':

  * Chip `Intel digital thermal sensor' (confidence: 9)

 

Note: there is no driver for ITE IT8772E Super IO Sensors yet.

Check http://www.lm-sensors.org/wiki/Devices for updates.

 

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes

Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors

for initialization at boot time.

You should now start the lm_sensors service to load the required

kernel modules.

 

Unloading cpuid... OK

 

root@ted:~# modprobe it87 force_id=0x8721

FATAL: Error inserting it87
(/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such device

 

As you told me I tried modprobe it87 force_id=0x8721

IT8772E yes LPC (2011-06-10) Found on Foxconn and Shuttle H67 boards. No
datasheet yet. One request (Boris Hajduk). Support can probably be added to
the it87 driver. Try "modprobe it87 force_id=0x8721" and report.

 

Thank you,

Do not hesitate to ask me any question if you want !


------=_NextPart_000_0035_01CC3A5F.C8E09F90
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DFR link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span =
lang=3DEN-US>Hello,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>I am&nbsp; a bit stuck currently. I would like to know if =
you can help me. I would like to access to the temperature of my =
processor. That what I have already done ..<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>If you need more information I can =
send everything you want.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>My system :<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>root@teddy:~# uname =
-a<o:p></o:p></span></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Linux teddy 2.6.32-5-amd64 #1 SMP Tue Jun 14 =
09:42:28 UTC 2011 x86_64 GNU/Linux</span></b><b><span =
lang=3DEN-US><o:p></o:p></span></b></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Other information :<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>Shuttle SH67H3 &#8211; i5 =
2300&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>The last version of sensors detect gives =
:<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>root@teddy:~# perl sensors-detect<o:p></o:p></span></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'># =
sensors-detect revision 5981 (2011-07-03 13:57:57 =
+0200)<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'># System: Shuttle =
SH67H3<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'># Board: Shuttle =
FH67<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>This program =
will help you determine which kernel modules you =
need<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>to load to use lm_sensors most effectively. It is =
generally safe<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>and recommended to accept the default =
answers to all questions,<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>unless you =
know what you're doing.<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Some south =
bridges, CPUs or memory controllers contain embedded =
sensors.<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Do you want to scan for them? This is =
totally safe. (YES/no): yes<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Module cpuid =
loaded successfully.<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Silicon =
Integrated Systems =
SIS5595...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>VIA VT82C686 Integrated =
Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>VIA VT8231 Integrated =
Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; No<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>AMD K8 =
thermal =
sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>AMD Family 10h thermal =
sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; No<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>AMD Family =
11h thermal =
sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; No<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>AMD Family =
12h and 14h thermal =
sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>AMD Family 15h thermal =
sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; No<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>AMD Family =
15h power =
sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Intel =
digital thermal =
sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>&nbsp;&nbsp;&nbsp; (driver =
`coretemp')<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Intel AMB FB-DIMM thermal =
sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>VIA C7 thermal =
sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>VIA Nano =
thermal =
sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Some Super =
I/O chips contain embedded sensors. We have to write =
to<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>standard I/O ports to probe them. This is usually =
safe.<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Do you want to scan for Super I/O =
sensors? (YES/no): yes<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Probing for =
Super-I/O at 0x2e/0x2f<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Trying =
family `National =
Semiconductor/ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Trying =
family =
`SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Trying family =
`VIA/Winbond/Nuvoton/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Trying family =
`ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; Yes<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Found `ITE IT8772E Super IO =
Sensors'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Success!<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>&nbsp;&nbsp;&nbsp; (address 0xa30, =
driver `to-be-written')<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Probing for =
Super-I/O at 0x4e/0x4f<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Trying =
family `National =
Semiconductor/ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Trying =
family =
`SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Trying family =
`VIA/Winbond/Nuvoton/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Trying family =
`ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Some systems =
(mainly servers) implement IPMI, a set of common =
interfaces<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>through which system health data may be =
retrieved, amongst other things.<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>We first try =
to get the information from SMBIOS. If we don't find =
it<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>there, we have to read from arbitrary I/O ports to =
probe for such<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>interfaces. This is normally safe. Do =
you want to scan for IPMI<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>interfaces? =
(YES/no): yes<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Probing for `IPMI BMC KCS' at =
0xca0...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Probing for `IPMI BMC SMIC' at =
0xca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Some =
hardware monitoring chips are accessible through the ISA I/O =
ports.<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>We have to write to arbitrary I/O ports =
to probe them. This is usually<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>safe though. =
Yes, you do have ISA I/O ports even if you do not have =
any<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>ISA slots! Do you want to scan the ISA I/O ports? =
(yes/NO): yes<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Probing for `National Semiconductor =
LM78' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Probing for `National Semiconductor LM79' at =
0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Probing for `Winbond W83781D' at =
0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Probing for `Winbond W83782D' at =
0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Lastly, we =
can probe the I2C/SMBus adapters for connected =
hardware<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>monitoring devices. This is the most =
risky part, and while it works<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>reasonably =
well on most systems, it has been reported to cause =
trouble<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>on some =
systems.<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Do you want to probe the I2C/SMBus =
adapters now? (YES/no): yes<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Using driver =
`i2c-i801' for device 0000:00:1f.3: Intel Cougar Point =
(PCH)<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Next =
adapter: SMBus I801 adapter at f040 (i2c-0)<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Do you want =
to scan it? (yes/NO/selectively): yes<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Client found =
at address 0x50<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Handled by driver `eeprom' (already =
loaded), chip type `eeprom'<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>&nbsp;&nbsp;&nbsp; (note: this is probably NOT a =
sensor chip!)<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>Client found at address =
0x52<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Handled by driver `eeprom' (already loaded), chip =
type `eeprom'<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>&nbsp;&nbsp;&nbsp; (note: this is =
probably NOT a sensor chip!)<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Now follows =
a summary of the probes I have just done.<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Just press =
ENTER to continue:<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Driver =
`to-be-written':<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>&nbsp; * ISA bus, address =
0xa30<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>&nbsp;&nbsp;&nbsp; Chip `ITE IT8772E =
Super IO Sensors' (confidence: 9)<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Driver =
`coretemp':<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>&nbsp; * Chip `Intel digital thermal =
sensor' (confidence: 9)<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Note: there =
is no driver for ITE IT8772E Super IO Sensors =
yet.<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Check http://www.lm-sensors.org/wiki/Devices for =
updates.<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Do you want =
to overwrite /etc/sysconfig/lm_sensors? (YES/no): =
yes<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'color:red'>Copy prog/init/lm_sensors.init to =
/etc/init.d/lm_sensors<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>for =
initialization at boot time.<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>You should =
now start the lm_sensors service to load the =
required<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>kernel =
modules.<o:p></o:p></span></b></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span lang=3DEN-US style=3D'color:red'>Unloading =
cpuid... OK<o:p></o:p></span></b></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>root@ted:~# modprobe it87 =
force_id=3D0x8721<o:p></o:p></span></p><p class=3DMsoNormal><b><span =
lang=3DEN-US style=3D'color:red'>FATAL: Error inserting it87 =
(/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such =
device<o:p></o:p></span></b></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>As you told me I tried modprobe it87 =
force_id=3D0x8721<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>IT8772E yes LPC (2011-06-10) Found on Foxconn and Shuttle =
H67 boards. No datasheet yet. One request (Boris Hajduk). Support can =
probably be added to the it87 driver. </span>Try &quot;modprobe it87 =
force_id=3D0x8721&quot; and report.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span =
lang=3DEN-US>Thank you,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Do not hesitate to ask me any question if you =
want&nbsp;!<o:p></o:p></span></p></div></body></html>
------=_NextPart_000_0035_01CC3A5F.C8E09F90--


--===============5721156157130578335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5721156157130578335==--
