From: Kushal Koolwal <kushalkoolwal@hotmail.com>
Date: Mon, 27 Aug 2007 22:56:14 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <BAY107-W27E45AEE475B55D4A50EA0BAD20@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1247808611202733015=="
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============1247808611202733015==
Content-Type: multipart/alternative;
	boundary="_0c3214eb-4046-4ba1-a395-41dc985cc816_"

--_0c3214eb-4046-4ba1-a395-41dc985cc816_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,

Actually I have tried the newest version of lm-sensors on Debian sid and dm=
e1737 does not show any output for my SCH3114 Super I/O chip.

I have also opened a ticket for the same last week.

Here is the URL of the ticket:
http://www.lm-sensors.org/ticket/2243

Thanks

Kushal Koolwal

> Date: Mon, 27 Aug 2007 14:26:16 -0700
> From: juergh@gmail.com
> To: Juergen.Bausa@web.de
> CC: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] dme1737 module
>=20
> Hi Juergen,
>=20
>=20
> > Juerg Haefliger <juergh <at> gmail.com> writes:
> >
> > >
> > > > I own a barebone made by asus which needs the dme1737 module for
> > > > lm-sensors to work correctly. Since it had been included in kernel
> > > > 2.6.23 and I am running 2.6.18 (from
> > > > debian etch) I was wondering if there is a stand alone version
> > > > of the module, that I could
> > > > compile for my kernel? Is there any way to use it with 2.6.18?
> > >
> > > Copy the file dme1737.c from the 2.6.23 kernel to a temp directory an=
d
> > > create a Makefile in the same directory that contains the following
> > > lines:
> > >
> > > obj-m :=3D dme1737.o
> > > all:
> > >         make -C /lib/modules/`uname -r`/build M=3D$(PWD) modules
> > >
> > > Then run 'make' which will compile the module. You also need to have
> > > the kernel headers installed to be able to compile.
> > > Additionally, you will also need the latest 'lm-sensors' package
> > > (2.10.4 ) or the dme1737 will not be recognized.
> > >
> >
> > Thanks a lot, the module seems to work fine. I used the newest sensors-=
detect
> > and it found out the modules I have to use. However, the output of sens=
ors
> > is quite short:
> >
> > jba@lisa:~$ sensors
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:
> >               -1=B0C
> > Core0 Temp:
> >               +1=B0C
> > Core1 Temp:
> >               +6=B0C
> > Core1 Temp:
> >               +6=B0C
> >
> > dme1737-i2c-0-2e
> > Adapter: SMBus nForce2 adapter at 4c00
> >
> > k8temp values are wrong, but that is another problem. But why doent
> > dme1737 display anything? Is it because of the older lm-sensors version=
 in
> > debian (2.10.1-3). Or will it be sufficiant to update the config file?
> > If possible I would like to keep the etch version of lm-sensors.
>=20
> You need a newer lm-sensors. 2.10.1 doesn't know about the dme1737.
> Just updating the config file is not enough.
>=20
> ...juerg
>=20
>=20
> > Juergen
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx=

--_0c3214eb-4046-4ba1-a395-41dc985cc816_
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
Hello,<br><br>Actually I have tried the newest version of lm-sensors on Deb=
ian sid and dme1737 does not show any output for my SCH3114 Super I/O chip.=
<br><br>I have also opened a ticket for the same last week.<br><br>Here is =
the URL of the ticket:<br>http://www.lm-sensors.org/ticket/2243<br><br>Than=
ks<br><br>Kushal Koolwal<br><br>&gt; Date: Mon, 27 Aug 2007 14:26:16 -0700<=
br>&gt; From: juergh@gmail.com<br>&gt; To: Juergen.Bausa@web.de<br>&gt; CC:=
 lm-sensors@lm-sensors.org<br>&gt; Subject: Re: [lm-sensors] dme1737 module=
<br>&gt; <br>&gt; Hi Juergen,<br>&gt; <br>&gt; <br>&gt; &gt; Juerg Haeflige=
r &lt;juergh &lt;at&gt; gmail.com&gt; writes:<br>&gt; &gt;<br>&gt; &gt; &gt=
;<br>&gt; &gt; &gt; &gt; I own a barebone made by asus which needs the dme1=
737 module for<br>&gt; &gt; &gt; &gt; lm-sensors to work correctly. Since i=
t had been included in kernel<br>&gt; &gt; &gt; &gt; 2.6.23 and I am runnin=
g 2.6.18 (from<br>&gt; &gt; &gt; &gt; debian etch) I was wondering if there=
 is a stand alone version<br>&gt; &gt; &gt; &gt; of the module, that I coul=
d<br>&gt; &gt; &gt; &gt; compile for my kernel? Is there any way to use it =
with 2.6.18?<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Copy the file dme1737.c fr=
om the 2.6.23 kernel to a temp directory and<br>&gt; &gt; &gt; create a Mak=
efile in the same directory that contains the following<br>&gt; &gt; &gt; l=
ines:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; obj-m :=3D dme1737.o<br>&gt; &gt;=
 &gt; all:<br>&gt; &gt; &gt;         make -C /lib/modules/`uname -r`/build =
M=3D$(PWD) modules<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Then run 'make' whic=
h will compile the module. You also need to have<br>&gt; &gt; &gt; the kern=
el headers installed to be able to compile.<br>&gt; &gt; &gt; Additionally,=
 you will also need the latest 'lm-sensors' package<br>&gt; &gt; &gt; (2.10=
.4 ) or the dme1737 will not be recognized.<br>&gt; &gt; &gt;<br>&gt; &gt;<=
br>&gt; &gt; Thanks a lot, the module seems to work fine. I used the newest=
 sensors-detect<br>&gt; &gt; and it found out the modules I have to use. Ho=
wever, the output of sensors<br>&gt; &gt; is quite short:<br>&gt; &gt;<br>&=
gt; &gt; jba@lisa:~$ sensors<br>&gt; &gt; k8temp-pci-00c3<br>&gt; &gt; Adap=
ter: PCI adapter<br>&gt; &gt; Core0 Temp:<br>&gt; &gt;               -1=B0C=
<br>&gt; &gt; Core0 Temp:<br>&gt; &gt;               +1=B0C<br>&gt; &gt; Co=
re1 Temp:<br>&gt; &gt;               +6=B0C<br>&gt; &gt; Core1 Temp:<br>&gt=
; &gt;               +6=B0C<br>&gt; &gt;<br>&gt; &gt; dme1737-i2c-0-2e<br>&=
gt; &gt; Adapter: SMBus nForce2 adapter at 4c00<br>&gt; &gt;<br>&gt; &gt; k=
8temp values are wrong, but that is another problem. But why doent<br>&gt; =
&gt; dme1737 display anything? Is it because of the older lm-sensors versio=
n in<br>&gt; &gt; debian (2.10.1-3). Or will it be sufficiant to update the=
 config file?<br>&gt; &gt; If possible I would like to keep the etch versio=
n of lm-sensors.<br>&gt; <br>&gt; You need a newer lm-sensors. 2.10.1 doesn=
't know about the dme1737.<br>&gt; Just updating the config file is not eno=
ugh.<br>&gt; <br>&gt; ...juerg<br>&gt; <br>&gt; <br>&gt; &gt; Juergen<br>&g=
t; &gt;<br>&gt; &gt;<br>&gt; &gt; _________________________________________=
______<br>&gt; &gt; lm-sensors mailing list<br>&gt; &gt; lm-sensors@lm-sens=
ors.org<br>&gt; &gt; http://lists.lm-sensors.org/mailman/listinfo/lm-sensor=
s<br>&gt; <br>&gt; _______________________________________________<br>&gt; =
lm-sensors mailing list<br>&gt; lm-sensors@lm-sensors.org<br>&gt; http://li=
sts.lm-sensors.org/mailman/listinfo/lm-sensors<br><br /><hr />Get news, ent=
ertainment and everything you care about at Live.com. <a href=3D'http://www=
.live.com/getstarted.aspx ' target=3D'_new'>Check it out!</a></body>
</html>=

--_0c3214eb-4046-4ba1-a395-41dc985cc816_--


--===============1247808611202733015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1247808611202733015==--
