From: Kushal Koolwal <kushalkoolwal@hotmail.com>
Date: Fri, 24 Aug 2007 02:23:25 +0000
Subject: Re: [lm-sensors] AMD Geode LX(CS5536) - SMSC SCH3114 Temperature
Message-Id: <BAY107-W8A57FDFA8FC937925926FBAD70@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2272548563697181212=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY107-W421FB9A83ADA7ED4C6D32BAD60@phx.gbl>
In-Reply-To: <BAY107-W421FB9A83ADA7ED4C6D32BAD60@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============2272548563697181212==
Content-Type: multipart/alternative;
	boundary="_3b5c956b-b9d6-447a-9178-c930478087f4_"

--_3b5c956b-b9d6-447a-9178-c930478087f4_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> > Err no, you need 2.6.23. The dme1737 is not in 2.6.22.=20

Thanks. I tried applying those patches to 2.6.23-rc3 but got errors.

Ok, here is what I did. I first downloaded the stable kernel source 2.6.22 =
and then I applied the patch         2.6.23-rc3 to get the kernel up to 2.6=
.23. After that I downloaded the 3 patches, which were in bin format and op=
en it in a text editor and saved them text file with extension ".patch".

I started applying patches and I got errors. Following is the output of wha=
t I did:

***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
**********************************************
debian:/usr/src/patches/geode_lx_hwmon# ls
hwmon-dme1737-add-sch311x-support.patch
hwmon-dme1737-cleanups.patch
hwmon-dme1737-group-functions-logically.patch

debian:/usr/src/linux-2.6.22# patch -p1 <../patches/patch-2.6.23-rc3
..................................................
..................................................
patching file sound/usb/usbquirks.h
patching file sound/usb/usx2y/usbusx2yaudio.c
patching file usr/.gitignore
patching file usr/gen_init_cpio.c
debian:/usr/src/linux-2.6.22# cd ..

debian:/usr/src# mv linux-2.6.22 linux-2.6.23
debian:/usr/src# cd linux-2.6.23

debian:/usr/src/linux-2.6.23# patch -p1 <../patches/geode_lx_hwmon/hwmon-dm=
e1737-cleanups.patch
patching file drivers/hwmon/dme1737.c
Hunk #17 FAILED at 1257.
Hunk #33 FAILED at 1748.
2 out of 43 hunks FAILED -- saving rejects to file drivers/hwmon/dme1737.c.=
rej

debian:/usr/src/linux-2.6.23# patch -p1 <../patches/geode_lx_hwmon/hwmon-dm=
e1737-group-functions-logically.patch=20
patching file drivers/hwmon/dme1737.c
Hunk #1 FAILED at 1697.
Hunk #2 succeeded at 1831 (offset -89 lines).
Hunk #3 succeeded at 2007 (offset -89 lines).
1 out of 3 hunks FAILED -- saving rejects to file drivers/hwmon/dme1737.c.r=
ej

debian:/usr/src/linux-2.6.23# patch -p1 <../patches/geode_lx_hwmon/hwmon-dm=
e1737-add-sch311x-support.patch=20
patching file drivers/hwmon/dme1737.c
Hunk #8 succeeded at 1790 with fuzz 1 (offset 49 lines).
Hunk #9 succeeded at 1841 (offset -42 lines).
Hunk #10 succeeded at 1889 (offset -42 lines).
Hunk #11 succeeded at 2113 (offset -42 lines).
patching file Documentation/hwmon/dme1737
patching file drivers/hwmon/Kconfig
Hunk #1 succeeded at 466 (offset 23 lines).
debian:/usr/src/linux-2.6.23#=20
***************************************************************************=
*****************

Can you please tell me the exact version of the kernel from kernel.org that=
 I should use to apply those patches successfully?

Thanks a lot once again.

Kushal




_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=3D7+wonders+world&mkt=3Den-US&form=3DQ=
BRE=

--_3b5c956b-b9d6-447a-9178-c930478087f4_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
&gt; &gt; Err no, you need 2.6.23. The dme1737 is not in 2.6.22. <br><br>Th=
anks. I tried applying those patches to 2.6.23-rc3 but got errors.<br><br>O=
k, here is what I did. I first downloaded the stable kernel source 2.6.22 a=
nd then I applied the patch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 2.6.23-rc3 to get the kernel up to 2.6.23. After that I downloaded the 3 p=
atches, which were in bin format and open it in a text editor and saved the=
m text file with extension ".patch".<br><br>I started applying patches and =
I got errors. Following is the output of what I did:<br><br>***************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
*******************************<br>debian:/usr/src/patches/geode_lx_hwmon# =
ls<br>hwmon-dme1737-add-sch311x-support.patch<br>hwmon-dme1737-cleanups.pat=
ch<br>hwmon-dme1737-group-functions-logically.patch<br><br>debian:/usr/src/=
linux-2.6.22# patch -p1 &lt;../patches/patch-2.6.23-rc3<br>................=
..................................<br>.....................................=
.............<br>patching file sound/usb/usbquirks.h<br>patching file sound=
/usb/usx2y/usbusx2yaudio.c<br>patching file usr/.gitignore<br>patching file=
 usr/gen_init_cpio.c<br>debian:/usr/src/linux-2.6.22# cd ..<br><br>debian:/=
usr/src# mv linux-2.6.22 linux-2.6.23<br>debian:/usr/src# cd linux-2.6.23<b=
r><br>debian:/usr/src/linux-2.6.23# patch -p1 &lt;../patches/geode_lx_hwmon=
/hwmon-dme1737-cleanups.patch<br>patching file drivers/hwmon/dme1737.c<br>H=
unk #17 FAILED at 1257.<br>Hunk #33 FAILED at 1748.<br>2 out of 43 hunks FA=
ILED -- saving rejects to file drivers/hwmon/dme1737.c.rej<br><br>debian:/u=
sr/src/linux-2.6.23# patch -p1 &lt;../patches/geode_lx_hwmon/hwmon-dme1737-=
group-functions-logically.patch <br>patching file drivers/hwmon/dme1737.c<b=
r>Hunk #1 FAILED at 1697.<br>Hunk #2 succeeded at 1831 (offset -89 lines).<=
br>Hunk #3 succeeded at 2007 (offset -89 lines).<br>1 out of 3 hunks FAILED=
 -- saving rejects to file drivers/hwmon/dme1737.c.rej<br><br>debian:/usr/s=
rc/linux-2.6.23# patch -p1 &lt;../patches/geode_lx_hwmon/hwmon-dme1737-add-=
sch311x-support.patch <br>patching file drivers/hwmon/dme1737.c<br>Hunk #8 =
succeeded at 1790 with fuzz 1 (offset 49 lines).<br>Hunk #9 succeeded at 18=
41 (offset -42 lines).<br>Hunk #10 succeeded at 1889 (offset -42 lines).<br=
>Hunk #11 succeeded at 2113 (offset -42 lines).<br>patching file Documentat=
ion/hwmon/dme1737<br>patching file drivers/hwmon/Kconfig<br>Hunk #1 succeed=
ed at 466 (offset 23 lines).<br>debian:/usr/src/linux-2.6.23# <br>*********=
***************************************************************************=
********<br><br>Can you please tell me the exact version of the kernel from=
 kernel.org that I should use to apply those patches successfully?<br><br>T=
hanks a lot once again.<br><br>Kushal<br><br><br><br><br /><hr />Explore th=
e seven wonders of the world <a href=3D'http://search.msn.com/results.aspx?=
q=3D7+wonders+world&mkt=3Den-US&form=3DQBRE' target=3D'_new'>Learn more!</a=
></body>
</html>=

--_3b5c956b-b9d6-447a-9178-c930478087f4_--


--===============2272548563697181212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2272548563697181212==--
