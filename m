From: Justin Chudgar <justin@justinzane.com>
Date: Mon, 08 Sep 2008 00:25:57 +0000
Subject: Re: [lm-sensors] Fwd: Re: Fwd: Re: c7temp module for lm-sensors
Message-Id: <200809071725.58231.justin@justinzane.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_WEHxIHFO70ZSKJY"
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0809062210i10fa6f47nb8fa43f2a6cda2e0@mail.gmail.com>
In-Reply-To: <191fb4ca0809062210i10fa6f47nb8fa43f2a6cda2e0@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--Boundary-00=_WEHxIHFO70ZSKJY
Content-Type: multipart/alternative; boundary="Boundary-00=_WEHxIollPm6c1RS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_WEHxIollPm6c1RS
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sorry about that. I downloaded it, but forgot to extract and used the Hardy=
=20
version. I have attached the proper output as VIA-C7_cpuid.=20
=2D-=20


Justin Chudgar
IT Consultant
5040 Saddlehorn Rd, Weed, CA 96094



=09
On Saturday, September 06, 2008 22:10:33 you wrote:
> Justin,
>
> Please use the cpuid from the link that I provided. Your output must
> be from an old version and doesn't show all the interesting
> information.
>
> ...juerg
>
> On Sat, Sep 6, 2008 at 9:14 PM, Justin Chudgar <justin@justinzane.com>=20
wrote:
> > Here is the output from "cpuid -r":
> >
> > eax in eax ebx ecx edx
> >
> > 00000000 00000001 746e6543 736c7561 48727561
> >
> > 00000001 000006d0 00000800 00004181 a7c9bbff
> >
> > 80000000 80000006 00000000 00000000 00000000
> >
> > 80000001 00000000 00000000 00000000 00100000
> >
> > 80000002 20202020 20202020 20202020 20202020
> >
> > 80000003 20202020 41495620 2d374320 7250204d
> >
> > 80000004 7365636f 20726f73 30303231 007a484d
> >
> > 80000005 00000000 08800880 40040140 40040140
> >
> > 80000006 00000000 00000000 0080a140 00000000
> >
> > Vendor ID: "CentaurHauls"; CPUID level 1
> >
> > Unknown vendor
> >
> > and here is from "cpuid":
> >
> > eax in eax ebx ecx edx
> >
> > 00000000 00000001 746e6543 736c7561 48727561
> >
> > 00000001 000006d0 00000800 00004181 a7c9bbff
> >
> > 80000000 80000006 00000000 00000000 00000000
> >
> > 80000001 00000000 00000000 00000000 00100000
> >
> > 80000002 20202020 20202020 20202020 20202020
> >
> > 80000003 20202020 41495620 2d374320 7250204d
> >
> > 80000004 7365636f 20726f73 30303231 007a484d
> >
> > 80000005 00000000 08800880 40040140 40040140
> >
> > 80000006 00000000 00000000 0080a140 00000000
> >
> > Vendor ID: "CentaurHauls"; CPUID level 1
> >
> > Unknown vendor
> >
> > This is from an HP Mini-note 2133 running Kubuntu Hardy with 2.6.24; an=
d,
> > following is the output from "sensors":
> >
> > c7temp-isa-0000
> >
> > Adapter: ISA adapter
> >
> > in0: +0.84 V
> >
> > temp1: +0.0=C2=B0C
> >
> > I've loaded the c7temp module; but, no temperature is shown. I can get a
> > temp from ACPI, however. Please let me know how I can help you get this
> > working. Thanks!
> >
> > ________________________________
> >
> > Justin Chudgar
> >
> > IT Consultant
> >
> > 5040 Saddlehorn Rd, Weed, CA 96094
> >
> > ________________________________
> >
> >
> > ---------- Forwarded message ----------
> > From: "Juerg Haefliger" <juergh@gmail.com>
> > To: "Justin Chudgar" <justin@justinzane.com>
> > Date: Fri, 5 Sep 2008 13:29:49 -0700
> > Subject: Re: [lm-sensors] Fwd: Re: c7temp module for lm-sensors
> > Justin,
> >
> > Can you compile and run cpuid from http://www.etallen.com/cpuid.html?
> > Please run it with and without the '-r' option and send the output to t=
he
> > list.
> >
> > Thanks
> > ...juerg
> >
> >
> > On Sat, Aug 30, 2008 at 5:03 PM, Justin Chudgar <justin@justinzane.com>
> >
> > wrote:
> >> --
> >>
> >> ________________________________
> >>
> >> Justin Chudgar
> >>
> >> IT Consultant
> >>
> >> 5040 Saddlehorn Rd, Weed, CA 96094
> >>
> >> ________________________________
> >>
> >> ---------- Forwarded message ----------
> >> From: Hans de Goede <j.w.r.degoede@hhs.nl>
> >> To: Justin Chudgar <justin@justinzane.com>
> >> Date: Sat, 30 Aug 2008 08:11:47 +0200
> >> Subject: Re: c7temp module for lm-sensors
> >>
> >> Justin Chudgar wrote:
> >>> Dear Hans:
> >>>
> >>> I am using this module on an HP Mini-note 2133 running Kubuntu 8.04.1
> >>> w/ 2.6.24.19. I get a voltage reading but no temperature. I would like
> >>> to help
> >>> determine what is not working; but, I am unable to do so without
> >>> assistance.
> >>>
> >>> Could you kindly direct me to the right resources. Thanks.
> >>>
> >>> Justin Chudgar
> >>
> >> Dear Justin,
> >>
> >> I'm not the maintainer of the c7temp driver, please send a mail to the
> >> lm_sensors list.
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >> _______________________________________________
> >> lm-sensors mailing list
> >> lm-sensors@lm-sensors.org
> >> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


--Boundary-00=_WEHxIollPm6c1RS
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd">
<html><head><meta name=3D"qrichtext" content=3D"1" /><style type=3D"text/cs=
s">
p, li { white-space: pre-wrap; }
</style></head><body style=3D" font-family:'DejaVu Sans'; font-size:10pt; f=
ont-weight:400; font-style:normal;">
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Sorry about=
 that. I downloaded it, but forgot to extract and used the Hardy version. I=
 have attached the proper output as VIA-C7_cpuid. <br />-- <br /></p>
<hr />
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-weight:600;">Justin Chudgar</span></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">IT Consulta=
nt</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">5040 Saddle=
horn Rd, Weed, CA 96094</p>
<hr />
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br />	</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Saturday=
, September 06, 2008 22:10:33 you wrote:</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Justin=
,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Please=
 use the cpuid from the link that I provided. Your output must</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; be fro=
m an old version and doesn't show all the interesting</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; inform=
ation.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; ...jue=
rg</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; On Sat=
, Sep 6, 2008 at 9:14 PM, Justin Chudgar &lt;justin@justinzane.com&gt; wrot=
e:</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; H=
ere is the output from "cpuid -r":</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; e=
ax in eax ebx ecx edx</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 0=
0000000 00000001 746e6543 736c7561 48727561</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 0=
0000001 000006d0 00000800 00004181 a7c9bbff</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000000 80000006 00000000 00000000 00000000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000001 00000000 00000000 00000000 00100000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000002 20202020 20202020 20202020 20202020</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000003 20202020 41495620 2d374320 7250204d</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000004 7365636f 20726f73 30303231 007a484d</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000005 00000000 08800880 40040140 40040140</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000006 00000000 00000000 0080a140 00000000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; V=
endor ID: "CentaurHauls"; CPUID level 1</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; U=
nknown vendor</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; a=
nd here is from "cpuid":</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; e=
ax in eax ebx ecx edx</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 0=
0000000 00000001 746e6543 736c7561 48727561</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 0=
0000001 000006d0 00000800 00004181 a7c9bbff</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000000 80000006 00000000 00000000 00000000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000001 00000000 00000000 00000000 00100000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000002 20202020 20202020 20202020 20202020</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000003 20202020 41495620 2d374320 7250204d</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000004 7365636f 20726f73 30303231 007a484d</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000005 00000000 08800880 40040140 40040140</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 8=
0000006 00000000 00000000 0080a140 00000000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; V=
endor ID: "CentaurHauls"; CPUID level 1</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; U=
nknown vendor</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; T=
his is from an HP Mini-note 2133 running Kubuntu Hardy with 2.6.24; and,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; f=
ollowing is the output from "sensors":</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; c=
7temp-isa-0000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; A=
dapter: ISA adapter</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; i=
n0: +0.84 V</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; t=
emp1: +0.0=C2=B0C</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; I=
've loaded the c7temp module; but, no temperature is shown. I can get a</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; t=
emp from ACPI, however. Please let me know how I can help you get this</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; w=
orking. Thanks!</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; _=
_______________________________</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; J=
ustin Chudgar</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; I=
T Consultant</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 5=
040 Saddlehorn Rd, Weed, CA 96094</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; _=
_______________________________</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; -=
=2D-------- Forwarded message ----------</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; F=
rom: "Juerg Haefliger" &lt;juergh@gmail.com&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; T=
o: "Justin Chudgar" &lt;justin@justinzane.com&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; D=
ate: Fri, 5 Sep 2008 13:29:49 -0700</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; S=
ubject: Re: [lm-sensors] Fwd: Re: c7temp module for lm-sensors</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; J=
ustin,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; C=
an you compile and run cpuid from http://www.etallen.com/cpuid.html?</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; P=
lease run it with and without the '-r' option and send the output to the</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; l=
ist.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; T=
hanks</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; .=
=2E.juerg</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; O=
n Sat, Aug 30, 2008 at 5:03 PM, Justin Chudgar &lt;justin@justinzane.com&gt=
;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; w=
rote:</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; --</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; ________________________________</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; Justin Chudgar</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; IT Consultant</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; 5040 Saddlehorn Rd, Weed, CA 96094</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; ________________________________</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; ---------- Forwarded message ----------</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; From: Hans de Goede &lt;j.w.r.degoede@hhs.nl&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; To: Justin Chudgar &lt;justin@justinzane.com&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; Date: Sat, 30 Aug 2008 08:11:47 +0200</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; Subject: Re: c7temp module for lm-sensors</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; Justin Chudgar wrote:</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt; Dear Hans:</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt; I am using this module on an HP Mini-note 2133 running Kubuntu 8.04.=
1</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt; w/ 2.6.24.19. I get a voltage reading but no temperature. I would li=
ke</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt; to help</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt; determine what is not working; but, I am unable to do so without</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt; assistance.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt; Could you kindly direct me to the right resources. Thanks.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;&gt; Justin Chudgar</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; Dear Justin,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; I'm not the maintainer of the c7temp driver, please send a mail to the</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; lm_sensors list.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; Regards,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; Hans</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; _______________________________________________</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; lm-sensors mailing list</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; lm-sensors@lm-sensors.org</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&g=
t; http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; _=
______________________________________________</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; l=
m-sensors mailing list</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; l=
m-sensors@lm-sensors.org</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; h=
ttp://lists.lm-sensors.org/mailman/listinfo/lm-sensors</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p></body></html>
--Boundary-00=_WEHxIollPm6c1RS--

--Boundary-00=_WEHxIHFO70ZSKJY
Content-Type: text/plain;
  charset="utf-8";
  name="VIA-C7_cpuid"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="VIA-C7_cpuid"

CPU:
   vendor_id = "CentaurHauls"
   version information (1/eax):
      processor type  = primary processor (0)
      family          = Intel Pentium Pro/II/III/Celeron, AMD Athlon/Duron, Cyrix M2, VIA C3 (6)
      model           = 0xd (13)
      stepping id     = 0x0 (0)
      extended family = 0x0 (0)
      extended model  = 0x0 (0)
      (simple synth)  = VIA C3 / C3-M / C7 / C7-M / Eden ESP 7000/8000/10000 (unknown model)
   miscellaneous (1/ebx):
      process local APIC physical ID = 0x0 (0)
      cpu count                      = 0x0 (0)
      CLFLUSH line size              = 0x8 (8)
      brand index                    = 0x0 (0)
   brand id = 0x00 (0): unknown
   feature information (1/edx):
      x87 FPU on chip                        = true
      virtual-8086 mode enhancement          = true
      debugging extensions                   = true
      page size extensions                   = true
      time stamp counter                     = true
      RDMSR and WRMSR support                = true
      physical address extensions            = true
      machine check exception                = true
      CMPXCHG8B inst.                        = true
      APIC on chip                           = true
      SYSENTER and SYSEXIT                   = true
      memory type range registers            = true
      PTE global bit                         = true
      machine check architecture             = false
      conditional move/compare instruction   = true
      page attribute table                   = true
      page size extension                    = false
      processor serial number                = false
      CLFLUSH instruction                    = true
      debug store                            = false
      thermal monitor and clock ctrl         = true
      MMX Technology                         = true
      FXSAVE/FXRSTOR                         = true
      SSE extensions                         = true
      SSE2 extensions                        = true
      self snoop                             = false
      hyper-threading / multi-core supported = false
      therm. monitor                         = true
      IA64                                   = false
      pending break event                    = true
   feature information (1/ecx):
      PNI/SSE3: Prescott New Instructions    = true
      MONITOR/MWAIT                          = false
      CPL-qualified debug store              = false
      VMX: virtual machine extensions        = false
      Enhanced Intel SpeedStep Technology    = true
      thermal monitor 2                      = true
      context ID: adaptive or shared L1 data = false
      cmpxchg16b available                   = false
      xTPR disable                           = true
   extended processor signature (0x80000001/eax):
      generation     = 0x0 (0)
      model          = 0x0 (0)
      stepping       = 0x0 (0)
      (simple synth) = unknown
   extended feature flags (0x80000001/edx):
      x87 FPU on chip                       = false
      virtual-8086 mode enhancement         = false
      debugging extensions                  = false
      page size extensions                  = false
      time stamp counter                    = false
      RDMSR and WRMSR support               = false
      physical address extensions           = false
      machine check exception               = false
      CMPXCHG8B inst.                       = false
      APIC on chip                          = false
      SYSCALL and SYSRET instructions       = false
      memory type range registers           = false
      global paging extension               = false
      machine check architecture            = false
      conditional move/compare instruction  = false
      page attribute table                  = false
      page size extension                   = false
      multiprocessing capable               = false
      AMD multimedia instruction extensions = false
      MMX Technology                        = false
      extended MMX                          = false
      SSE extensions                        = false
      AA-64                                 = false
      3DNow! instruction extensions         = false
      3DNow! instructions                   = false
   brand = "                     VIA C7-M Processor 1200MHz"
   L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
      instruction # entries     = 0x0 (0)
      instruction associativity = 0x0 (0)
      data # entries            = 0x0 (0)
      data associativity        = 0x0 (0)
   L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
      instruction # entries     = 0x80 (128)
      instruction associativity = 0x8 (8)
      data # entries            = 0x80 (128)
      data associativity        = 0x8 (8)
   L1 data cache information (0x80000005/ecx):
      line size (bytes) = 0x40 (64)
      lines per tag     = 0x1 (1)
      associativity     = 0x4 (4)
      size (Kb)         = 0x40 (64)
   L1 instruction cache information (0x80000005/ecx):
      line size (bytes) = 0x40 (64)
      lines per tag     = 0x1 (1)
      associativity     = 0x4 (4)
      size (Kb)         = 0x40 (64)
   L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
      instruction # entries     = 0x0 (0)
      instruction associativity = L2 off (0)
      data # entries            = 0x0 (0)
      data associativity        = L2 off (0)
   L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
      instruction # entries     = 0x0 (0)
      instruction associativity = L2 off (0)
      data # entries            = 0x0 (0)
      data associativity        = L2 off (0)
   L2 unified cache information (0x80000006/ecx):
      line size (bytes) = 0x40 (64)
      lines per tag     = 0x1 (1)
      associativity     = 0xa (10)
      size (Kb)         = 0x80 (128)
   0xc0000001: eax=0x00000000
   extended feature flags (0xc0000001/edx):
      alternate instruction set                 = false
      alternate instruction set enabled         = false
      random number generator                   = true
      random number generator enabled           = true
      LongHaul MSR 0000_110Ah                   = false
      FEMMS                                     = false
      advanced cryptography engine (ACE)        = true
      advanced cryptography engine (ACE)enabled = true
   0xc0000002: eax=0x00000000 ebx=0x04000406 ecx=0x04060609 edx=0x41080000
   0xc0000003: eax=0xfc1deab2 ebx=0xc220bebf ecx=0xd40711db edx=0xe9cfcd6a
   (multi-processing synth): none
   (synth) = VIA C3 / C3-M / C7 / C7-M / Eden ESP 7000/8000/10000 (unknown model)
-------------------------------
CPU:
   0x00000000: eax=0x00000001 ebx=0x746e6543 ecx=0x736c7561 edx=0x48727561
   0x00000001: eax=0x000006d0 ebx=0x00000800 ecx=0x00004181 edx=0xa7c9bbff
   0x80000000: eax=0x80000006 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0x80000001: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00100000
   0x80000002: eax=0x20202020 ebx=0x20202020 ecx=0x20202020 edx=0x20202020
   0x80000003: eax=0x20202020 ebx=0x41495620 ecx=0x2d374320 edx=0x7250204d
   0x80000004: eax=0x7365636f ebx=0x20726f73 ecx=0x30303231 edx=0x007a484d
   0x80000005: eax=0x00000000 ebx=0x08800880 ecx=0x40040140 edx=0x40040140
   0x80000006: eax=0x00000000 ebx=0x00000000 ecx=0x0080a140 edx=0x00000000
   0x80860000: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0xc0000000: eax=0xc0000003 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0xc0000001: eax=0x00000000 ebx=0x00000001 ecx=0x00000000 edx=0x0000ffcc
   0xc0000002: eax=0x00000000 ebx=0x04000406 ecx=0x04060609 edx=0x41080000
   0xc0000003: eax=0xfc1deab2 ebx=0xc220bebf ecx=0xd40711db edx=0xe9cfcd6a

--Boundary-00=_WEHxIHFO70ZSKJY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_WEHxIHFO70ZSKJY--
