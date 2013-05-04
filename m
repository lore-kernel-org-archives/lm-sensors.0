From: Eric Wedel <Eric.Wedel@hds.com>
Date: Sat, 04 May 2013 06:05:07 +0000
Subject: [lm-sensors] config file for Supermicro X9SRA
Message-Id: <D1E63D527AC16D449D27AECBBF9F72920B23287D@USINDEM103.corp.hds.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_000_D1E63D527AC16D449D27AECBBF9F72920B23287DUSINDEM103corph_"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1016382082051722815==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D1E63D527AC16D449D27AECBBF9F72920B23287DUSINDEM103corph_"

--_000_D1E63D527AC16D449D27AECBBF9F72920B23287DUSINDEM103corph_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Couldn't find a way to add a config file to the lm-sensors wiki, so am post=
ing it here.
Apologies if this isn't the right place.

This config file has been exercised only on debian squeeze, using Guenter R=
oeck's
NCT677* driver update:

  https://github.com/groeck/nct6775/archive/master.tar.gz

or

  http://roeck-us.net/linux/drivers/

Seems to work fine, across three x9sra systems.

regards, Eric Wedel

########################

# Supermicro X9SRA motherboard lm-sensors configuration.
# Voltage inputs & scaling per Supermicro support.  Other
# inputs from BIOS screen and observation.

chip "nct6776-*"

### Voltages

label in0 "Vcore"

label in1 "+12V"
compute in1 @ * (66.2/10), @ / (66.2/10)

label in2 "AVcc"

label in3 "+3.3V"

label in4 "Vdimm"

label in5 "+5V"
compute in5 @ * 4, @ / 4

label in6 "Vtt"

label in7 "+3.3Vsb"

label in8 "Vbatt"

### Temperatures

# not sure about temp1 / temp2 assignments

label temp1 "System temperature"
label temp2 "Peripheral temperature"

ignore temp3

# PECI agent 0:
label temp7 "CPU temperature"

label temp8 "PCH temperature"

ignore temp9
ignore temp10

## fans: gratuitous renumbering between Supermicro & lm-sensors.
## Use display labels which match X9SRA fan connector labels.

label fan1  "fanA"
label fan2  "fan1"
label fan3  "CPU Fan"
label fan4  "fan3"
label fan5  "Exhaust Fan"

########################


--_000_D1E63D527AC16D449D27AECBBF9F72920B23287DUSINDEM103corph_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
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
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Couldn't find a way to add a config file to the lm-s=
ensors wiki, so am posting it here.<o:p></o:p></p>
<p class=3D"MsoNormal">Apologies if this isn't the right place.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This config file has been exercised only on debian s=
queeze, using Guenter Roeck's<o:p></o:p></p>
<p class=3D"MsoNormal">NCT677* driver update:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp; <a href=3D"https://github.com/groeck/nct6775/=
archive/master.tar.gz">
https://github.com/groeck/nct6775/archive/master.tar.gz</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">or<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp; <a href=3D"http://roeck-us.net/linux/drivers/=
">http://roeck-us.net/linux/drivers/</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Seems to work fine, across three x9sra systems.<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">regards, Eric Wedel<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">########################<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># Supermicro X9SRA motherboard lm-sensors configurat=
ion.<o:p></o:p></p>
<p class=3D"MsoNormal"># Voltage inputs &amp; scaling per Supermicro suppor=
t.&nbsp; Other<o:p></o:p></p>
<p class=3D"MsoNormal"># inputs from BIOS screen and observation.<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">chip &quot;nct6776-*&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">### Voltages<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label in0 &quot;Vcore&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label in1 &quot;&#43;12V&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">compute in1 @ * (66.2/10), @ / (66.2/10)<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label in2 &quot;AVcc&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label in3 &quot;&#43;3.3V&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label in4 &quot;Vdimm&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label in5 &quot;&#43;5V&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">compute in5 @ * 4, @ / 4<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label in6 &quot;Vtt&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label in7 &quot;&#43;3.3Vsb&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label in8 &quot;Vbatt&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">### Temperatures<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># not sure about temp1 / temp2 assignments<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label temp1 &quot;System temperature&quot;<o:p></o:p=
></p>
<p class=3D"MsoNormal">label temp2 &quot;Peripheral temperature&quot;<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">ignore temp3<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># PECI agent 0:<o:p></o:p></p>
<p class=3D"MsoNormal">label temp7 &quot;CPU temperature&quot;<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label temp8 &quot;PCH temperature&quot;<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">ignore temp9<o:p></o:p></p>
<p class=3D"MsoNormal">ignore temp10<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">## fans: gratuitous renumbering between Supermicro &=
amp; lm-sensors.<o:p></o:p></p>
<p class=3D"MsoNormal">## Use display labels which match X9SRA fan connecto=
r labels.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">label fan1&nbsp; &quot;fanA&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">label fan2&nbsp; &quot;fan1&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">label fan3&nbsp; &quot;CPU Fan&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">label fan4&nbsp; &quot;fan3&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">label fan5&nbsp; &quot;Exhaust Fan&quot;<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">########################<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_D1E63D527AC16D449D27AECBBF9F72920B23287DUSINDEM103corph_--


--===============1016382082051722815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1016382082051722815==--
