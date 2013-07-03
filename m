From: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Date: Wed, 03 Jul 2013 12:35:50 +0000
Subject: [lm-sensors] 3.10: Intel HWMON/NIC temperature sensor question
Message-Id: <002401ce77e9$da6524b0$8f2f6e10$@lucidpixels.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8071307702207588083=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multipart message in MIME format.

--===============8071307702207588083==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0025_01CE77C8.53546F10"
Content-language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_0025_01CE77C8.53546F10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I saw this in the device drive section and was curious which Intel-based
NICs contain temperature sensors?

 

Intel(R) 10GbE PCI Express adapters HWMON support

Intel(R) PCI-Express Gigabit adapters HWMON support

 

I checked the boards below and none appear to expose a hwmon interface:

08:00.0 Ethernet controller: Intel Corporation 82580 Gigabit Network
Connection (rev 01)

08:00.1 Ethernet controller: Intel Corporation 82580 Gigabit Network
Connection (rev 01)

08:00.2 Ethernet controller: Intel Corporation 82580 Gigabit Network
Connection (rev 01)

08:00.3 Ethernet controller: Intel Corporation 82580 Gigabit Network
Connection (rev 01)

09:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
Connection

0a:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
Connection

01:00.0 Ethernet controller: Intel Corporation 82598EB 10-Gigabit AT2 Server
Adapter (rev 01)

 

# find /sys/|grep hwmon

 

Radeon:

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/name

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/power

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/power/control

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/power/runtime
_active_time

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/power/autosus
pend_delay_ms

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/power/runtime
_status

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/power/runtime
_suspended_time

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/device

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/subsystem

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/uevent

/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon/hwmon0/temp1_input

 

Onboard chipset:

/sys/devices/platform/nct6775.2608/hwmon

/sys/devices/platform/nct6775.2608/hwmon/hwmon2

/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power

/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/control

/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/runtime_active_time

/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/autosuspend_delay_ms

/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/runtime_status

/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/runtime_suspended_time

/sys/devices/platform/nct6775.2608/hwmon/hwmon2/device

/sys/devices/platform/nct6775.2608/hwmon/hwmon2/subsystem

/sys/devices/platform/nct6775.2608/hwmon/hwmon2/uevent

 

CPU:

/sys/devices/platform/coretemp.0/hwmon

/sys/devices/platform/coretemp.0/hwmon/hwmon1

/sys/devices/platform/coretemp.0/hwmon/hwmon1/power

/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/control

/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/runtime_active_time

/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/autosuspend_delay_ms

/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/runtime_status

/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/runtime_suspended_time

/sys/devices/platform/coretemp.0/hwmon/hwmon1/device

/sys/devices/platform/coretemp.0/hwmon/hwmon1/subsystem

/sys/devices/platform/coretemp.0/hwmon/hwmon1/uevent

 

Justin.

 


------=_NextPart_000_0025_01CE77C8.53546F10
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
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
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72"><div class=3DWordSection1><p =
class=3DMsoNormal>Hi,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I saw this =
in the device drive section and was curious which Intel-based NICs =
contain temperature sensors?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Intel(R) =
10GbE PCI Express adapters HWMON support<o:p></o:p></p><p =
class=3DMsoNormal>Intel(R) PCI-Express Gigabit adapters HWMON =
support<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I checked the boards below and none appear to expose a =
hwmon interface:<o:p></o:p></p><p class=3DMsoNormal>08:00.0 Ethernet =
controller: Intel Corporation 82580 Gigabit Network Connection (rev =
01)<o:p></o:p></p><p class=3DMsoNormal>08:00.1 Ethernet controller: =
Intel Corporation 82580 Gigabit Network Connection (rev =
01)<o:p></o:p></p><p class=3DMsoNormal>08:00.2 Ethernet controller: =
Intel Corporation 82580 Gigabit Network Connection (rev =
01)<o:p></o:p></p><p class=3DMsoNormal>08:00.3 Ethernet controller: =
Intel Corporation 82580 Gigabit Network Connection (rev =
01)<o:p></o:p></p><p class=3DMsoNormal>09:00.0 Ethernet controller: =
Intel Corporation 82574L Gigabit Network Connection<o:p></o:p></p><p =
class=3DMsoNormal>0a:00.0 Ethernet controller: Intel Corporation 82574L =
Gigabit Network Connection<o:p></o:p></p><p class=3DMsoNormal>01:00.0 =
Ethernet controller: Intel Corporation 82598EB 10-Gigabit AT2 Server =
Adapter (rev 01)<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal># find =
/sys/|grep hwmon<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Radeon:<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/name<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/power<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/power/control<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/power/runtime_active_time<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/power/autosuspend_delay_ms<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/power/runtime_status<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/power/runtime_suspended_time<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/device<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/subsystem<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/uevent<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/pci0000:00/0000:00:03.1/0000:05:00.0/hwmon=
/hwmon0/temp1_input<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Onboard =
chipset:<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon<o:p></o:p></p>=
<p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2<o:p></o=
:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power<o=
:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/c=
ontrol<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/r=
untime_active_time<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/a=
utosuspend_delay_ms<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/r=
untime_status<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2/power/r=
untime_suspended_time<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2/device<=
o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2/subsyst=
em<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/nct6775.2608/hwmon/hwmon2/uevent<=
o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>CPU:<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon<o:p></o:p></p><p=
 =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1<o:p></o:p=
></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1/power<o:p=
></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/con=
trol<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/run=
time_active_time<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/aut=
osuspend_delay_ms<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/run=
time_status<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1/power/run=
time_suspended_time<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1/device<o:=
p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1/subsystem=
<o:p></o:p></p><p =
class=3DMsoNormal>/sys/devices/platform/coretemp.0/hwmon/hwmon1/uevent<o:=
p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Justin.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_0025_01CE77C8.53546F10--



--===============8071307702207588083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8071307702207588083==--

