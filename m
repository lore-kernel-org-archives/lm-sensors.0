From: "Zafar, Khurram" <Khurram.Zafar@kla-tencor.com>
Date: Mon, 25 May 2009 15:20:07 +0000
Subject: Re: [lm-sensors] Where to download drivers?
Message-Id: <47E375F28A0EFE4F8E3BE9D8818AA50D010B9622@CA1EXCLV05.adcorp.kla-tencor.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9DD4C.98778F2C"
List-Id: <lm-sensors.vger.kernel.org>
References: <47E375F28A0EFE4F8E3BE9D8818AA50D01FF5F07@CA1EXCLV05.adcorp.kla-tencor.com>
In-Reply-To: <47E375F28A0EFE4F8E3BE9D8818AA50D01FF5F07@CA1EXCLV05.adcorp.kla-tencor.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============0193504372594691402==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9DD4C.98778F2C"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9DD4C.98778F2C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Madhu,

Thank you for your help. I am on holiday now for 1 week, but I want to =
resolve this problem so I'll reply as best I can.

We are using SuSE Linux Enterprise Server, SP2.

I will use VPN to log onto our network later in the day and get you the =
specific information you requested.

When I run "sensors" I get an error message indicating that no drivers =
were found. I'll get you the exact output later as well.

Regards,
KZ



-----Original Message-----
From: madhu [mailto:madhu.chinakonda@gmail.com]
Sent: Sat 5/23/2009 1:50 AM
To: Zafar, Khurram
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Where to download drivers?
=20
Can I know which distribution you are using, are you using any custom
kernel (compiled by you),

Generally, most distribution kernels will come with these drivers
(coretemp, etc) enabled as modules.

So, lm-sensor tries to load these modules, if there is no such modules,
I think it assumes that you have compiled statically,

Also it would be useful if you send the output of the following,

1. uname -a
2. sensors

Regards,
Madhu,

On Fri, 2009-05-22 at 16:26 -0700, Zafar, Khurram wrote:
> Hi,
>=20
> =20
>=20
> I have just downloaded and compiled the latest lm_sensors package and
> run "sensors-detect," whose output is shown down below. My question is
> very simple:
>=20
> =20
>=20
> Where can I obtain the following  3 drivers:
>=20
> =20
>=20
> 1.      coretemp
>=20
> 2.      ipmisensors
>=20
> 3.      i5k_amb
>=20
> =20
>=20
> Thanks,
>=20
> KZ
>=20
> =20
>=20
> ---------------- output from sensors-detect ------------------
>=20
> =20
>=20
> Now follows a summary of the probes I have just done.
>=20
> Just press ENTER to continue:
>=20
> =20
>=20
> Driver `coretemp':
>=20
>   * Chip `Intel Core family thermal sensor' (confidence: 9)
>=20
> =20
>=20
> Driver `ipmisensors':
>=20
>   * ISA bus, address 0xca0 (Busdriver `i2c-isa')
>=20
>     Chip `IPMI BMC KCS' (confidence: 4)
>=20
> =20
>=20
> Driver `i5k_amb':
>=20
>   * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
>=20
> =20
>=20
> Warning: the required module coretemp is not currently installed
>=20
> on your system. If it is built into the kernel then it's OK.
>=20
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
>=20
> driver availability.
>=20
> =20
>=20
> Warning: the required module ipmisensors is not currently installed
>=20
> on your system. If it is built into the kernel then it's OK.
>=20
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
>=20
> driver availability.
>=20
> =20
>=20
> Warning: the required module i5k_amb is not currently installed
>=20
> on your system. If it is built into the kernel then it's OK.
>=20
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
>=20
> driver availability.
>=20
> =20
>=20
> No modules to load, skipping modules configuration.
>=20
> =20
>=20
> Unloading i2c-dev... OK
>=20
> =20
>=20
> =20
>=20
> KLA-TENCOR CONFIDENTIAL
>=20
> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they
> are addressed. If you have received this email in error, do not use or
> review the message or any information transmitted with it, and notify
> the sender.
>=20
> =20
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



------_=_NextPart_001_01C9DD4C.98778F2C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE: [lm-sensors] Where to download drivers?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Madhu,<BR>
<BR>
Thank you for your help. I am on holiday now for 1 week, but I want to =
resolve this problem so I'll reply as best I can.<BR>
<BR>
We are using SuSE Linux Enterprise Server, SP2.<BR>
<BR>
I will use VPN to log onto our network later in the day and get you the =
specific information you requested.<BR>
<BR>
When I run &quot;sensors&quot; I get an error message indicating that no =
drivers were found. I'll get you the exact output later as well.<BR>
<BR>
Regards,<BR>
KZ<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: madhu [<A =
HREF=3D"mailto:madhu.chinakonda@gmail.com">mailto:madhu.chinakonda@gmail.=
com</A>]<BR>
Sent: Sat 5/23/2009 1:50 AM<BR>
To: Zafar, Khurram<BR>
Cc: lm-sensors@lm-sensors.org<BR>
Subject: Re: [lm-sensors] Where to download drivers?<BR>
<BR>
Can I know which distribution you are using, are you using any =
custom<BR>
kernel (compiled by you),<BR>
<BR>
Generally, most distribution kernels will come with these drivers<BR>
(coretemp, etc) enabled as modules.<BR>
<BR>
So, lm-sensor tries to load these modules, if there is no such =
modules,<BR>
I think it assumes that you have compiled statically,<BR>
<BR>
Also it would be useful if you send the output of the following,<BR>
<BR>
1. uname -a<BR>
2. sensors<BR>
<BR>
Regards,<BR>
Madhu,<BR>
<BR>
On Fri, 2009-05-22 at 16:26 -0700, Zafar, Khurram wrote:<BR>
&gt; Hi,<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; I have just downloaded and compiled the latest lm_sensors package =
and<BR>
&gt; run &quot;sensors-detect,&quot; whose output is shown down below. =
My question is<BR>
&gt; very simple:<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Where can I obtain the following&nbsp; 3 drivers:<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; 1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; coretemp<BR>
&gt;<BR>
&gt; 2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipmisensors<BR>
&gt;<BR>
&gt; 3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i5k_amb<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Thanks,<BR>
&gt;<BR>
&gt; KZ<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; ---------------- output from sensors-detect ------------------<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Now follows a summary of the probes I have just done.<BR>
&gt;<BR>
&gt; Just press ENTER to continue:<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Driver `coretemp':<BR>
&gt;<BR>
&gt;&nbsp;&nbsp; * Chip `Intel Core family thermal sensor' (confidence: =
9)<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Driver `ipmisensors':<BR>
&gt;<BR>
&gt;&nbsp;&nbsp; * ISA bus, address 0xca0 (Busdriver `i2c-isa')<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Chip `IPMI BMC KCS' (confidence: 4)<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Driver `i5k_amb':<BR>
&gt;<BR>
&gt;&nbsp;&nbsp; * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: =
9)<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Warning: the required module coretemp is not currently =
installed<BR>
&gt;<BR>
&gt; on your system. If it is built into the kernel then it's OK.<BR>
&gt;<BR>
&gt; Otherwise, check <A =
HREF=3D"http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org=
/wiki/Devices</A> for<BR>
&gt;<BR>
&gt; driver availability.<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Warning: the required module ipmisensors is not currently =
installed<BR>
&gt;<BR>
&gt; on your system. If it is built into the kernel then it's OK.<BR>
&gt;<BR>
&gt; Otherwise, check <A =
HREF=3D"http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org=
/wiki/Devices</A> for<BR>
&gt;<BR>
&gt; driver availability.<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Warning: the required module i5k_amb is not currently installed<BR>
&gt;<BR>
&gt; on your system. If it is built into the kernel then it's OK.<BR>
&gt;<BR>
&gt; Otherwise, check <A =
HREF=3D"http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org=
/wiki/Devices</A> for<BR>
&gt;<BR>
&gt; driver availability.<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; No modules to load, skipping modules configuration.<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Unloading i2c-dev... OK<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; KLA-TENCOR CONFIDENTIAL<BR>
&gt;<BR>
&gt; This email and any files transmitted with it are confidential =
and<BR>
&gt; intended solely for the use of the individual or entity to whom =
they<BR>
&gt; are addressed. If you have received this email in error, do not use =
or<BR>
&gt; review the message or any information transmitted with it, and =
notify<BR>
&gt; the sender.<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt;<BR>
&gt; _______________________________________________<BR>
&gt; lm-sensors mailing list<BR>
&gt; lm-sensors@lm-sensors.org<BR>
&gt; <A =
HREF=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors">http://l=
ists.lm-sensors.org/mailman/listinfo/lm-sensors</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C9DD4C.98778F2C--


--===============0193504372594691402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0193504372594691402==--
