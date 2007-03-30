From: "brady" <bchang@atipa.com>
Date: Fri, 30 Mar 2007 19:39:24 +0000
Subject: [lm-sensors] FW: nforce2 mcp55
Message-Id: <MAIL3wBzpkCHhhBIYsO000074d4@mail.atipa.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7595125774292097016=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============7595125774292097016==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0033_01C772D9.36943220"

This is a multi-part message in MIME format.

------=_NextPart_000_0033_01C772D9.36943220
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

I try to get sensors working for this.

 

thanks in advance for your help

-Brady

 

 

w83793( backported from winbond )to the running kernel.

 

modprobe i2c_nforce2

 

identify the pci_vendor_id and 

echo "10de:0368 "> /sys/bus/pci/drivers/nForce2_smbus/new_id

error in the log:

[root@compute-0-0 ~]# tail -30 /var/log/messages

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB2

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:01.2: Error
probing SMB2.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB2

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:04.0: Error
probing SMB2.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB1

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:06.0: Error
probing SMB1.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB2

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:06.0: Error
probing SMB2.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB2

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:0a.0: Error
probing SMB2.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 6004 .. 600B
for SMB1

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:0b.0: Error
probing SMB1.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB2

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:0b.0: Error
probing SMB2.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 6004 .. 600B
for SMB1

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:0c.0: Error
probing SMB1.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB2

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:0c.0: Error
probing SMB2.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 6004 .. 600B
for SMB1

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:0d.0: Error
probing SMB1.

Mar 29 10:44:20 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB2

Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus 0000:00:0d.0: Error
probing SMB2.

Mar 29 10:44:21 compute-0-0 kernel:  : Error requesting region 6004 .. 600B
for SMB1

Mar 29 10:44:21 compute-0-0 kernel: nForce2_smbus 0000:00:0e.0: Error
probing SMB1.

Mar 29 10:44:21 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB2

Mar 29 10:44:21 compute-0-0 kernel: nForce2_smbus 0000:00:0e.0: Error
probing SMB2.

Mar 29 10:44:21 compute-0-0 kernel:  : Error requesting region 6004 .. 600B
for SMB1

Mar 29 10:44:21 compute-0-0 kernel: nForce2_smbus 0000:00:0f.0: Error
probing SMB1.

Mar 29 10:44:21 compute-0-0 kernel:  : Error requesting region 00 .. 07 for
SMB2

Mar 29 10:44:21 compute-0-0 kernel: nForce2_smbus 0000:00:0f.0: Error
probing SMB2.

[root@compute-0-0 ~]# lspci -n       

00:00.0 Class 0500: 10de:0369 (rev a2)

00:01.0 Class 0601: 10de:0364 (rev a3)

00:01.1 Class 0c05: 10de:0368 (rev a3)

00:01.2 Class 0500: 10de:036a (rev a3)

00:02.0 Class 0c03: 10de:036c (rev a1)

00:02.1 Class 0c03: 10de:036d (rev a2)

00:04.0 Class 0101: 10de:036e (rev a1)

00:05.0 Class 0101: 10de:037f (rev a3)

00:05.1 Class 0101: 10de:037f (rev a3)

00:05.2 Class 0101: 10de:037f (rev a3)

00:06.0 Class 0604: 10de:0370 (rev a2)

00:08.0 Class 0200: 10de:0373 (rev a3)

00:09.0 Class 0200: 10de:0373 (rev a3)

00:0a.0 Class 0604: 10de:0376 (rev a3)

00:0b.0 Class 0604: 10de:0374 (rev a3)

00:0c.0 Class 0604: 10de:0374 (rev a3)

00:0d.0 Class 0604: 10de:0378 (rev a3)

00:0e.0 Class 0604: 10de:0375 (rev a3)

00:0f.0 Class 0604: 10de:0377 (rev a3)

00:18.0 Class 0600: 1022:1100

00:18.1 Class 0600: 1022:1101

00:18.2 Class 0600: 1022:1102

00:18.3 Class 0600: 1022:1103

00:19.0 Class 0600: 1022:1100

00:19.1 Class 0600: 1022:1101

00:19.2 Class 0600: 1022:1102

00:19.3 Class 0600: 1022:1103

01:06.0 Class 0300: 1002:515e (rev 02)

02:00.0 Class 0604: 1033:0125 (rev 07)

02:00.1 Class 0604: 1033:0125 (rev 07)

[root@compute-0-0 ~]# lspci 

00:00.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)

00:01.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a3)

00:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev a3)

00:01.2 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a3)

00:02.0 USB Controller: nVidia Corporation MCP55 USB Controller (rev a1)

00:02.1 USB Controller: nVidia Corporation MCP55 USB Controller (rev a2)

00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)

00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)

00:05.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)

00:05.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)

00:06.0 PCI bridge: nVidia Corporation MCP55 PCI bridge (rev a2)

00:08.0 Ethernet controller: nVidia Corporation MCP55 Ethernet (rev a3)

00:09.0 Ethernet controller: nVidia Corporation MCP55 Ethernet (rev a3)

00:0a.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)

00:0b.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)

00:0c.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)

00:0d.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)

00:0e.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)

00:0f.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control

01:06.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)

02:00.0 PCI bridge: NEC Corporation uPD720400 PCI Express - PCI/PCI-X Bridge
(rev 07)

02:00.1 PCI bridge: NEC Corporation uPD720400 PCI Express - PCI/PCI-X Bridge
(rev 07)

[root@compute-0-0 ~]# uname -r 

2.6.9-42.0.10.ELsmp


------=_NextPart_000_0033_01C772D9.36943220
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I try to get sensors working for =
this.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>thanks <font color=3Dnavy><span =
style=3D'color:navy'>in advance </span></font>for
your help<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Brady<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>w83793( backported from winbond )to the running =
kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>modprobe i2c_nforce2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>identify the pci_vendor_id and =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>echo &quot;10de:0368 &quot;&gt; =
/sys/bus/pci/drivers/nForce2_smbus/new_id<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>error in the log:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[root@compute-0-0 ~]# tail -30 =
/var/log/messages<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:01.2: Error probing SMB2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:04.0: Error probing SMB2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:06.0: Error probing SMB1.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:06.0: Error probing SMB2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:0a.0: Error probing SMB2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 6004 .. 600B for SMB1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:0b.0: Error probing SMB1.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:0b.0: Error probing SMB2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 6004 .. 600B for SMB1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:0c.0: Error probing SMB1.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:0c.0: Error probing SMB2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 6004 .. 600B for SMB1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:0d.0: Error probing SMB1.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:20 compute-0-0 kernel: nForce2_smbus
0000:00:0d.0: Error probing SMB2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:21 compute-0-0 kernel:&nbsp; : Error =
requesting
region 6004 .. 600B for SMB1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:21 compute-0-0 kernel: nForce2_smbus
0000:00:0e.0: Error probing SMB1.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:21 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:21 compute-0-0 kernel: nForce2_smbus
0000:00:0e.0: Error probing SMB2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:21 compute-0-0 kernel:&nbsp; : Error =
requesting
region 6004 .. 600B for SMB1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:21 compute-0-0 kernel: nForce2_smbus
0000:00:0f.0: Error probing SMB1.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:21 compute-0-0 kernel:&nbsp; : Error =
requesting
region 00 .. 07 for SMB2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 29 10:44:21 compute-0-0 kernel: nForce2_smbus
0000:00:0f.0: Error probing SMB2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[root@compute-0-0 ~]# lspci
-n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:00.0 Class 0500: 10de:0369 (rev =
a2)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:01.0 Class 0601: 10de:0364 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:01.1 Class 0c05: 10de:0368 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:01.2 Class 0500: 10de:036a (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:02.0 Class 0c03: 10de:036c (rev =
a1)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:02.1 Class 0c03: 10de:036d (rev =
a2)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:04.0 Class 0101: 10de:036e (rev =
a1)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:05.0 Class 0101: 10de:037f (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:05.1 Class 0101: 10de:037f (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:05.2 Class 0101: 10de:037f (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:06.0 Class 0604: 10de:0370 (rev =
a2)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:08.0 Class 0200: 10de:0373 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:09.0 Class 0200: 10de:0373 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0a.0 Class 0604: 10de:0376 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0b.0 Class 0604: 10de:0374 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0c.0 Class 0604: 10de:0374 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0d.0 Class 0604: 10de:0378 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0e.0 Class 0604: 10de:0375 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0f.0 Class 0604: 10de:0377 (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:18.0 Class 0600: =
1022:1100<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:18.1 Class 0600: =
1022:1101<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:18.2 Class 0600: =
1022:1102<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:18.3 Class 0600: =
1022:1103<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:19.0 Class 0600: =
1022:1100<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:19.1 Class 0600: =
1022:1101<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:19.2 Class 0600: =
1022:1102<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:19.3 Class 0600: =
1022:1103<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>01:06.0 Class 0300: 1002:515e (rev =
02)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>02:00.0 Class 0604: 1033:0125 (rev =
07)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>02:00.1 Class 0604: 1033:0125 (rev =
07)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[root@compute-0-0 ~]# lspci =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:00.0 RAM memory: nVidia Corporation MCP55 Memory
Controller (rev a2)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:01.0 ISA bridge: nVidia Corporation MCP55 LPC =
Bridge (rev
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev =
a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:01.2 RAM memory: nVidia Corporation MCP55 Memory
Controller (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:02.0 USB Controller: nVidia Corporation MCP55 USB
Controller (rev a1)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:02.1 USB Controller: nVidia Corporation MCP55 USB
Controller (rev a2)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:04.0 IDE interface: nVidia Corporation MCP55 IDE =
(rev a1)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:05.0 IDE interface: nVidia Corporation MCP55 SATA
Controller (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:05.1 IDE interface: nVidia Corporation MCP55 SATA
Controller (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:05.2 IDE interface: nVidia Corporation MCP55 SATA
Controller (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:06.0 PCI bridge: nVidia Corporation MCP55 PCI =
bridge (rev
a2)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:08.0 Ethernet controller: nVidia Corporation MCP55
Ethernet (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:09.0 Ethernet controller: nVidia Corporation MCP55
Ethernet (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0a.0 PCI bridge: nVidia Corporation MCP55 PCI =
Express
bridge (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0b.0 PCI bridge: nVidia Corporation MCP55 PCI =
Express
bridge (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0c.0 PCI bridge: nVidia Corporation MCP55 PCI =
Express
bridge (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0d.0 PCI bridge: nVidia Corporation MCP55 PCI =
Express
bridge (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0e.0 PCI bridge: nVidia Corporation MCP55 PCI =
Express
bridge (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:0f.0 PCI bridge: nVidia Corporation MCP55 PCI =
Express
bridge (rev a3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology =
Configuration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 =
[Athlon64/Opteron]
HyperTransport Technology Configuration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>01:06.0 VGA compatible controller: ATI Technologies =
Inc
ES1000 (rev 02)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>02:00.0 PCI bridge: NEC Corporation uPD720400 PCI =
Express -
PCI/PCI-X Bridge (rev 07)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>02:00.1 PCI bridge: NEC Corporation uPD720400 PCI =
Express -
PCI/PCI-X Bridge (rev 07)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[root@compute-0-0 ~]# uname -r =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>2.6.9-42.0.10.ELsmp<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0033_01C772D9.36943220--




--===============7595125774292097016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7595125774292097016==--


