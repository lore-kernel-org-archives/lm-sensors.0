From: Kazuya <kazuya25@hotmail.fr>
Date: Tue, 05 Jul 2011 11:54:45 +0000
Subject: Re: [lm-sensors] [?? Probable Spam]  Re:  IT8772E info and reports
Message-Id: <BLU0-SMTP101E548161D713BF62CDDC1A05F0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7969515587670211362=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7969515587670211362==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01CC3B12.B87B24F0"
Content-Language: fr

------=_NextPart_000_0005_01CC3B12.B87B24F0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20

=20

-----Message d'origine-----
De : Jeff Rickman [mailto:jrickman@myamigos.us]=20
Envoy=E9 : lundi 4 juillet 2011 19:14
=C0 : Kazuya
Cc : lm-sensors@lm-sensors.org
Objet : [?? Probable Spam] Re: [lm-sensors] IT8772E info and reports

=20

Hi,

=20

On 7/4/2011 9:33 AM, Kazuya wrote:

> Hello,

>=20

> I am a bit stuck currently. I would like to know if you can help me. I =


> would like to access to the temperature of my processor. That what I=20

> have already done ..

>=20

> If you need more information I can send everything you want.

>=20

> My system :

>=20

> root@teddy:~# uname -a

>=20

> *Linux teddy 2.6.32-5-amd64 #1 SMP Tue Jun 14 09:42:28 UTC 2011 x86_64

> GNU/Linux***

>=20

> Other information :

>=20

> Shuttle SH67H3 =96 i5 2300

>=20

> The last version of sensors detect gives :

>=20

> root@teddy:~# perl sensors-detect

>=20

> *# sensors-detect revision 5981 (2011-07-03 13:57:57 +0200)*

>=20

> *# System: Shuttle SH67H3*

>=20

> *# Board: Shuttle FH67*

>=20

> **

>=20

> *This program will help you determine which kernel modules you need*

>=20

> *to load to use lm_sensors most effectively. It is generally safe*

>=20

> *and recommended to accept the default answers to all questions,*

>=20

> *unless you know what you're doing.*

>=20

> **

>=20

> *Some south bridges, CPUs or memory controllers contain embedded=20

> sensors.*

>=20

> *Do you want to scan for them? This is totally safe. (YES/no): yes*

>=20

> *Module cpuid loaded successfully.*

>=20

> *Silicon Integrated Systems SIS5595... No*

>=20

> *VIA VT82C686 Integrated Sensors... No*

>=20

> *VIA VT8231 Integrated Sensors... No*

>=20

> *AMD K8 thermal sensors... No*

>=20

> *AMD Family 10h thermal sensors... No*

>=20

> *AMD Family 11h thermal sensors... No*

>=20

> *AMD Family 12h and 14h thermal sensors... No*

>=20

> *AMD Family 15h thermal sensors... No*

>=20

> *AMD Family 15h power sensors... No*

>=20

> *Intel digital thermal sensor... Success!*

>=20

> *(driver `coretemp')*

>=20

> *Intel AMB FB-DIMM thermal sensor... No*

>=20

> *VIA C7 thermal sensor... No*

>=20

> *VIA Nano thermal sensor... No*

>=20

> **

>=20

> *Some Super I/O chips contain embedded sensors. We have to write to*

>=20

> *standard I/O ports to probe them. This is usually safe.*

>=20

> *Do you want to scan for Super I/O sensors? (YES/no): yes*

>=20

> *Probing for Super-I/O at 0x2e/0x2f*

>=20

> *Trying family `National Semiconductor/ITE'... No*

>=20

> *Trying family `SMSC'... No*

>=20

> *Trying family `VIA/Winbond/Nuvoton/Fintek'... No*

>=20

> *Trying family `ITE'... Yes*

>=20

> *Found `ITE IT8772E Super IO Sensors' Success!*

>=20

> *(address 0xa30, driver `to-be-written')*

>=20

> *Probing for Super-I/O at 0x4e/0x4f*

>=20

> *Trying family `National Semiconductor/ITE'... No*

>=20

> *Trying family `SMSC'... No*

>=20

> *Trying family `VIA/Winbond/Nuvoton/Fintek'... No*

>=20

> *Trying family `ITE'... No*

>=20

> **

>=20

> *Some systems (mainly servers) implement IPMI, a set of common=20

> interfaces*

>=20

> *through which system health data may be retrieved, amongst other=20

> things.*

>=20

> *We first try to get the information from SMBIOS. If we don't find it*

>=20

> *there, we have to read from arbitrary I/O ports to probe for such*

>=20

> *interfaces. This is normally safe. Do you want to scan for IPMI*

>=20

> *interfaces? (YES/no): yes*

>=20

> *Probing for `IPMI BMC KCS' at 0xca0... No*

>=20

> *Probing for `IPMI BMC SMIC' at 0xca8... No*

>=20

> **

>=20

> *Some hardware monitoring chips are accessible through the ISA I/O=20

> ports.*

>=20

> *We have to write to arbitrary I/O ports to probe them. This is=20

> usually*

>=20

> *safe though. Yes, you do have ISA I/O ports even if you do not have=20

> any*

>=20

> *ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes*

>=20

> *Probing for `National Semiconductor LM78' at 0x290... No*

>=20

> *Probing for `National Semiconductor LM79' at 0x290... No*

>=20

> *Probing for `Winbond W83781D' at 0x290... No*

>=20

> *Probing for `Winbond W83782D' at 0x290... No*

>=20

> **

>=20

> *Lastly, we can probe the I2C/SMBus adapters for connected hardware*

>=20

> *monitoring devices. This is the most risky part, and while it works*

>=20

> *reasonably well on most systems, it has been reported to cause=20

> trouble*

>=20

> *on some systems.*

>=20

> *Do you want to probe the I2C/SMBus adapters now? (YES/no): yes*

>=20

> *Using driver `i2c-i801' for device 0000:00:1f.3: Intel Cougar Point=20

> (PCH)*

>=20

> **

>=20

> *Next adapter: SMBus I801 adapter at f040 (i2c-0)*

>=20

> *Do you want to scan it? (yes/NO/selectively): yes*

>=20

> *Client found at address 0x50*

>=20

> *Handled by driver `eeprom' (already loaded), chip type `eeprom'*

>=20

> *(note: this is probably NOT a sensor chip!)*

>=20

> *Client found at address 0x52*

>=20

> *Handled by driver `eeprom' (already loaded), chip type `eeprom'*

>=20

> *(note: this is probably NOT a sensor chip!)*

>=20

> **

>=20

> *Now follows a summary of the probes I have just done.*

>=20

> *Just press ENTER to continue:*

>=20

> **

>=20

> *Driver `to-be-written':*

>=20

> ** ISA bus, address 0xa30*

>=20

> *Chip `ITE IT8772E Super IO Sensors' (confidence: 9)*

>=20

> **

>=20

> *Driver `coretemp':*

>=20

> ** Chip `Intel digital thermal sensor' (confidence: 9)*

>=20

> **

>=20

> *Note: there is no driver for ITE IT8772E Super IO Sensors yet.*

>=20

> *Check  <http://www.lm-sensors.org/wiki/Devices>
http://www.lm-sensors.org/wiki/Devices for updates.*

>=20

> **

>=20

> *Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes*

>=20

> *Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors*

>=20

> *for initialization at boot time.*

>=20

> *You should now start the lm_sensors service to load the required*

>=20

> *kernel modules.*

>=20

> **

>=20

> *Unloading cpuid... OK*

>=20

> root@teddy:~# modprobe it87 force_id=3D0x8721

>=20

> *FATAL: Error inserting it87

> (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such=20

> device*

>=20

> As you told me I tried modprobe it87 force_id=3D0x8721

>=20

> IT8772E yes LPC (2011-06-10) Found on Foxconn and Shuttle H67 boards.=20

> No datasheet yet. One request (Boris Hajduk). Support can probably be=20

> added to the it87 driver. Try "modprobe it87 force_id=3D0x8721" and =
report.

>=20

> Thank you,

>=20

> Do not hesitate to ask me any question if you want !

>=20

=20

What distribution is this?

root@teddy:~# cat /etc/issue

Debian GNU/Linux 6.0 \n \l

=20

root@teddy:~# cat /etc/debian_version

6.0.2

=20

root@teddy:~# uname -a

Linux teddy 2.6.32-5-amd64 #1 SMP Tue Jun 14 09:42:28 UTC 2011 x86_64
GNU/Linux

=20

=20

What is the output from the 'sensors -v' command? That should display =
what
version of LM_Sensors is installed and what libsensors library version =
is
used.

root@teddy:~# sensors -v

sensors version 3.1.2 with libsensors version 3.1.2

=20

What is the output from the 'sensors' command? If the necessary drivers =
have
properly loaded, that command will display various outputs

root@teddy:~# sensors

No sensors found!

Make sure you loaded all the kernel drivers you need.

Try sensors-detect to find out which these are.

=20

=20

=20

The 'it87' module should be present if LM_Sensors is properly installed. =


Also, the 'coretemp' module should be present if LM_Sensors is properly
installed. Did you attempt to "modprobe coretemp" and observe what =
happened?

root@teddy:~# modprobe coretemp

FATAL: Error inserting coretemp
(/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/coretemp.ko): No such
device

=20

Did you attempt to start the lm_sensors service to load the required
modules? If you tried to start the service, what did you observe?

root@ted:~# service lm-sensors start

Setting sensors limits.

=20

root@ted:~# /etc/init.d/lm-sensors start

Setting sensors limits.

=20

Thank you


------=_NextPart_000_0005_01CC3B12.B87B24F0
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1"><meta name=3DGenerator content=3D"Microsoft Word =
14 (filtered medium)"><style><!--
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Texte brut Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
span.TextebrutCar
	{mso-style-name:"Texte brut Car";
	mso-style-priority:99;
	mso-style-link:"Texte brut";
	font-family:"Calibri","sans-serif";}
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
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span =
style=3D'mso-fareast-language:FR'>-----Message =
d'origine-----<br>De&nbsp;: Jeff Rickman [mailto:jrickman@myamigos.us] =
<br>Envoy=E9&nbsp;: lundi 4 juillet 2011 19:14<br>=C0&nbsp;: =
Kazuya<br>Cc&nbsp;: lm-sensors@lm-sensors.org<br>Objet&nbsp;: [?? =
Probable Spam] Re: [lm-sensors] IT8772E info and reports</span></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>Hi,<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>On =
7/4/2011 9:33 AM, Kazuya wrote:<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; Hello,<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; I am a bit stuck currently. I would like to =
know if you can help me. I <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
would like to access to the temperature of my processor. That what I =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; have already done =
..<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; If you need more information I can send =
everything you want.<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; My system :<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; root@teddy:~# uname -a<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Linux teddy 2.6.32-5-amd64 #1 SMP Tue Jun 14 =
09:42:28 UTC 2011 x86_64<o:p></o:p></p><p class=3DMsoPlainText>&gt; =
GNU/Linux***<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; Other information :<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; Shuttle SH67H3 &#8211; i5 =
2300<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; The last version of sensors detect gives =
:<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; root@teddy:~# perl =
sensors-detect<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *# sensors-detect revision 5981 (2011-07-03 =
13:57:57 +0200)*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *# System: Shuttle SH67H3*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *# Board: Shuttle FH67*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *This program will help you determine which =
kernel modules you need*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *to load to use lm_sensors most effectively. =
It is generally safe*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *and recommended to accept the default answers =
to all questions,*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *unless you know what you're =
doing.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Some south bridges, CPUs or memory =
controllers contain embedded <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
sensors.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Do you want to scan for them? This is totally =
safe. (YES/no): yes*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Module cpuid loaded =
successfully.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Silicon Integrated Systems SIS5595... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *VIA VT82C686 Integrated Sensors... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *VIA VT8231 Integrated Sensors... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *AMD K8 thermal sensors... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *AMD Family 10h thermal sensors... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *AMD Family 11h thermal sensors... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *AMD Family 12h and 14h thermal sensors... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *AMD Family 15h thermal sensors... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *AMD Family 15h power sensors... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Intel digital thermal sensor... =
Success!*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *(driver `coretemp')*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Intel AMB FB-DIMM thermal sensor... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *VIA C7 thermal sensor... No*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *VIA Nano thermal sensor... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Some Super I/O chips contain embedded =
sensors. We have to write to*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *standard I/O ports to probe them. This is =
usually safe.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Do you want to scan for Super I/O sensors? =
(YES/no): yes*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Probing for Super-I/O at =
0x2e/0x2f*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Trying family `National Semiconductor/ITE'... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Trying family `SMSC'... No*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Trying family `VIA/Winbond/Nuvoton/Fintek'... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Trying family `ITE'... Yes*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Found `ITE IT8772E Super IO Sensors' =
Success!*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *(address 0xa30, driver =
`to-be-written')*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Probing for Super-I/O at =
0x4e/0x4f*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Trying family `National Semiconductor/ITE'... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Trying family `SMSC'... No*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Trying family `VIA/Winbond/Nuvoton/Fintek'... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Trying family `ITE'... No*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Some systems (mainly servers) implement IPMI, =
a set of common <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
interfaces*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *through which system health data may be =
retrieved, amongst other <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
things.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *We first try to get the information from =
SMBIOS. If we don't find it*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *there, we have to read from arbitrary I/O =
ports to probe for such*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *interfaces. This is normally safe. Do you =
want to scan for IPMI*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *interfaces? (YES/no): yes*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Probing for `IPMI BMC KCS' at 0xca0... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Probing for `IPMI BMC SMIC' at 0xca8... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Some hardware monitoring chips are accessible =
through the ISA I/O <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
ports.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *We have to write to arbitrary I/O ports to =
probe them. This is <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
usually*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *safe though. Yes, you do have ISA I/O ports =
even if you do not have <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
any*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *ISA slots! Do you want to scan the ISA I/O =
ports? (yes/NO): yes*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Probing for `National Semiconductor LM78' at =
0x290... No*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Probing for `National Semiconductor LM79' at =
0x290... No*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Probing for `Winbond W83781D' at 0x290... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Probing for `Winbond W83782D' at 0x290... =
No*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Lastly, we can probe the I2C/SMBus adapters =
for connected hardware*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *monitoring devices. This is the most risky =
part, and while it works*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *reasonably well on most systems, it has been =
reported to cause <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
trouble*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *on some systems.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Do you want to probe the I2C/SMBus adapters =
now? (YES/no): yes*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Using driver `i2c-i801' for device =
0000:00:1f.3: Intel Cougar Point <o:p></o:p></p><p =
class=3DMsoPlainText>&gt; (PCH)*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Next adapter: SMBus I801 adapter at f040 =
(i2c-0)*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Do you want to scan it? (yes/NO/selectively): =
yes*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Client found at address =
0x50*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Handled by driver `eeprom' (already loaded), =
chip type `eeprom'*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *(note: this is probably NOT a sensor =
chip!)*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Client found at address =
0x52*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Handled by driver `eeprom' (already loaded), =
chip type `eeprom'*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *(note: this is probably NOT a sensor =
chip!)*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Now follows a summary of the probes I have =
just done.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Just press ENTER to =
continue:*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Driver `to-be-written':*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; ** ISA bus, address 0xa30*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Chip `ITE IT8772E Super IO Sensors' =
(confidence: 9)*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Driver `coretemp':*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; ** Chip `Intel digital thermal sensor' =
(confidence: 9)*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Note: there is no driver for ITE IT8772E =
Super IO Sensors yet.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt; *Check </span><a =
href=3D"http://www.lm-sensors.org/wiki/Devices"><span lang=3DEN-US =
style=3D'color:windowtext;text-decoration:none'>http://www.lm-sensors.org=
/wiki/Devices</span></a><span lang=3DEN-US> for =
updates.*<o:p></o:p></span></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Do you want to overwrite =
/etc/sysconfig/lm_sensors? (YES/no): yes*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Copy prog/init/lm_sensors.init to =
/etc/init.d/lm_sensors*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *for initialization at boot =
time.*<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *You should now start the lm_sensors service =
to load the required*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *kernel modules.*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; **<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *Unloading cpuid... OK*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt; root@teddy:~# modprobe it87 =
force_id=3D0x8721<o:p></o:p></span></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; *FATAL: Error inserting it87<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; =
(/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; device*<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; As you told me I tried modprobe it87 =
force_id=3D0x8721<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; IT8772E yes LPC (2011-06-10) Found on Foxconn =
and Shuttle H67 boards. <o:p></o:p></p><p class=3DMsoPlainText>&gt; No =
datasheet yet. One request (Boris Hajduk). Support can probably be =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; added to the it87 driver. =
Try &quot;modprobe it87 force_id=3D0x8721&quot; and =
report.<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; Thank you,<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; Do not hesitate to ask me any question if you =
want !<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span =
style=3D'font-size:16.0pt'>What distribution is =
this?<o:p></o:p></span></p><p class=3DMsoPlainText><b><span =
style=3D'color:black'>root@teddy:~#</span></b><span =
style=3D'color:black'> cat /etc/issue<o:p></o:p></span></p><p =
class=3DMsoPlainText><span style=3D'color:red'>Debian GNU/Linux 6.0 \n =
\l<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><b>root@teddy:~#</b> cat =
/etc/debian_version<o:p></o:p></p><p class=3DMsoPlainText><span =
style=3D'color:red'>6.0.2<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><b>root@teddy:~#</b> uname -a<o:p></o:p></p><p =
class=3DMsoPlainText><span style=3D'color:red'>Linux teddy =
2.6.32-5-amd64 #1 SMP Tue Jun 14 09:42:28 UTC 2011 x86_64 =
GNU/Linux<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-size:16.0pt'>What =
is the output from the 'sensors -v' command? </span><span =
style=3D'font-size:16.0pt'>That should display what version of =
LM_Sensors is installed and what libsensors library version is =
used.<o:p></o:p></span></p><p class=3DMsoPlainText><b><span =
lang=3DEN-US>root@teddy:~#</span></b><span lang=3DEN-US> sensors =
-v<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>sensors version 3.1.2 with libsensors version =
3.1.2<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-size:16.0pt'>What =
is the output from the 'sensors' command? If the necessary drivers have =
properly loaded, that command will display various outputs<b><span =
style=3D'color:black'><o:p></o:p></span></b></span></p><p =
class=3DMsoPlainText><b><span lang=3DEN-US =
style=3D'color:black'>root@teddy:~#</span></b><span lang=3DEN-US =
style=3D'color:black'> sensors<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>No sensors =
found!<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>Make sure you loaded all the kernel drivers you =
need.<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>Try sensors-detect to find out which these =
are.<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span =
style=3D'font-size:16.0pt'>The 'it87' module should be present if =
LM_Sensors is properly installed. <o:p></o:p></span></p><p =
class=3DMsoPlainText><span style=3D'font-size:16.0pt'>Also, the =
'coretemp' module should be present if LM_Sensors is properly installed. =
Did you attempt to &quot;modprobe coretemp&quot; and observe what =
happened?<o:p></o:p></span></p><p =
class=3DMsoPlainText><b>root@teddy:~#</b> modprobe =
coretemp<o:p></o:p></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>FATAL: Error inserting coretemp =
(/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/coretemp.ko): No such =
device<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span style=3D'font-size:16.0pt'>Did you attempt to =
start the lm_sensors service to load the required modules? If you tried =
to start the service, what did you observe?<o:p></o:p></span></p><p =
class=3DMsoPlainText><b><span lang=3DEN-US>root@ted:~#</span></b><span =
lang=3DEN-US> service lm-sensors start<o:p></o:p></span></p><p =
class=3DMsoPlainText><span style=3D'color:red'>Setting sensors =
limits.<o:p></o:p></span></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><b><span lang=3DEN-US =
style=3D'color:black'>root@ted:~#</span></b><span lang=3DEN-US =
style=3D'color:black'> /etc/init.d/lm-sensors =
start<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>Setting sensors limits.<o:p></o:p></span></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span =
style=3D'color:black'>Thank you<o:p></o:p></span></p></div></body></html>
------=_NextPart_000_0005_01CC3B12.B87B24F0--


--===============7969515587670211362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7969515587670211362==--
