From: Vahid Keykhaey <vahid.keykhaey@gmail.com>
Date: Tue, 11 Dec 2012 09:29:51 +0000
Subject: [lm-sensors] Fwd:  Fwd: Driver for Bulldozer
Message-Id: <CAMcsHH1KFnR-0kKjbQU52CWhJ-=g+=K+wP8mOGahodmYjcymjQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5955146195594850677=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5955146195594850677==
Content-Type: multipart/alternative; boundary=20cf3079b7eae7774d04d090522c

--20cf3079b7eae7774d04d090522c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Mr Delvare,
Hi,
My problem is, when I try to read per-core temperatures, there is not any
information there. In my Core i7 processor, I can access per-core
temperatures.
My question is, is there any way to do this on this processor? My processor
is Bulldozer 8120.

Thank you in advance for your help and supporyt.
Regards,
Vahid



On Tue, Dec 11, 2012 at 4:26 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Vahid,
>
> On Tue, 11 Dec 2012 04:19:17 -0500, Vahid Keykhaey wrote:
> > When I try to install cpufreqmodules, I get a fail on "loading cpufreq
> > kernel modules".
>
> I don't know what your distribution is doing and I don't know if your
> CPU supports frequency scaling. Without detailed error messages, we
> can't help. Plus this is unrelated to lm-sensors anyway.
>
> > and the result of my sensors-detect command is enclosed.
> >
> > thank you for your help. I do not need power monitoring modules but
> thermal
> > monitoring modules.
> > (...)
> > fam15h_power-pci-00c4
> > Adapter: PCI adapter
> > power1:      119.40 W  (crit =3D 124.95 W)
> >
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > temp1:        +26.0=B0C  (high =3D +70.0=B0C)
> >
> > w83627dhg-isa-0290
> > Adapter: ISA adapter
> > Vcore:        +1.30 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:          +0.38 V  (min =3D  +0.98 V, max =3D  +1.94 V)  ALARM
> > AVCC:         +3.36 V  (min =3D  +3.25 V, max =3D  +1.26 V)  ALARM
> > +3.3V:        +3.36 V  (min =3D  +2.53 V, max =3D  +0.18 V)  ALARM
> > in4:          +1.68 V  (min =3D  +0.03 V, max =3D  +1.82 V)
> > in5:          +1.74 V  (min =3D  +1.68 V, max =3D  +1.21 V)  ALARM
> > in6:          +1.88 V  (min =3D  +1.96 V, max =3D  +1.38 V)  ALARM
> > 3VSB:         +3.47 V  (min =3D  +1.31 V, max =3D  +3.63 V)
> > Vbat:         +3.42 V  (min =3D  +2.82 V, max =3D  +2.86 V)  ALARM
> > fan1:           0 RPM  (min =3D 6026 RPM, div =3D 16)  ALARM
> > fan2:           0 RPM  (min =3D 1757 RPM, div =3D 16)  ALARM
> > fan3:        3375 RPM  (min =3D  700 RPM, div =3D 8)
> > fan5:           0 RPM  (min =3D 12053 RPM, div =3D 16)  ALARM
> > temp1:        +34.0=B0C  (high =3D  -6.0=B0C, hyst =3D +15.0=B0C)  ALAR=
M  sensor =3D
> thermistor
> > temp2:        +46.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D
> thermistor
> > temp3:        +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D
> thermistor
> > intrusion0:  ALARM
>
> So, everything works just fine. What are you complaining about exactly,
> please?
>
> --
> Jean Delvare
>

--20cf3079b7eae7774d04d090522c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Dear Mr Delvare,<br>Hi,<br>My problem is, when I=
 try to read per-core temperatures, there is not any information there. In =
my Core i7 processor, I can access per-core temperatures.<br>My question is=
, is there any way to do this on this processor? My processor is Bulldozer =
8120.<br>

<br>Thank you in advance for your help and supporyt.<br>Regards,<br>Vahid<d=
iv class=3D"HOEnZb"><div class=3D"h5"><br><div class=3D"gmail_extra"><br><b=
r><div class=3D"gmail_quote">On Tue, Dec 11, 2012 at 4:26 AM, Jean Delvare =
<span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=3D"_blan=
k">khali@linux-fr.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Vahid,<br>
<div><br>
On Tue, 11 Dec 2012 04:19:17 -0500, Vahid Keykhaey wrote:<br>
&gt; When I try to install cpufreqmodules, I get a fail on &quot;loading cp=
ufreq<br>
&gt; kernel modules&quot;.<br>
<br>
</div>I don&#39;t know what your distribution is doing and I don&#39;t know=
 if your<br>
CPU supports frequency scaling. Without detailed error messages, we<br>
can&#39;t help. Plus this is unrelated to lm-sensors anyway.<br>
<div><br>
&gt; and the result of my sensors-detect command is enclosed.<br>
&gt;<br>
&gt; thank you for your help. I do not need power monitoring modules but th=
ermal<br>
&gt; monitoring modules.<br>
</div>&gt; (...)<br>
&gt; fam15h_power-pci-00c4<br>
&gt; Adapter: PCI adapter<br>
&gt; power1: =A0 =A0 =A0119.40 W =A0(crit =3D 124.95 W)<br>
&gt;<br>
&gt; k10temp-pci-00c3<br>
&gt; Adapter: PCI adapter<br>
&gt; temp1: =A0 =A0 =A0 =A0+26.0=B0C =A0(high =3D +70.0=B0C)<br>
&gt;<br>
&gt; w83627dhg-isa-0290<br>
&gt; Adapter: ISA adapter<br>
&gt; Vcore: =A0 =A0 =A0 =A0+1.30 V =A0(min =3D =A0+0.00 V, max =3D =A0+1.74=
 V)<br>
&gt; in1: =A0 =A0 =A0 =A0 =A0+0.38 V =A0(min =3D =A0+0.98 V, max =3D =A0+1.=
94 V) =A0ALARM<br>
&gt; AVCC: =A0 =A0 =A0 =A0 +3.36 V =A0(min =3D =A0+3.25 V, max =3D =A0+1.26=
 V) =A0ALARM<br>
&gt; +3.3V: =A0 =A0 =A0 =A0+3.36 V =A0(min =3D =A0+2.53 V, max =3D =A0+0.18=
 V) =A0ALARM<br>
&gt; in4: =A0 =A0 =A0 =A0 =A0+1.68 V =A0(min =3D =A0+0.03 V, max =3D =A0+1.=
82 V)<br>
&gt; in5: =A0 =A0 =A0 =A0 =A0+1.74 V =A0(min =3D =A0+1.68 V, max =3D =A0+1.=
21 V) =A0ALARM<br>
&gt; in6: =A0 =A0 =A0 =A0 =A0+1.88 V =A0(min =3D =A0+1.96 V, max =3D =A0+1.=
38 V) =A0ALARM<br>
&gt; 3VSB: =A0 =A0 =A0 =A0 +3.47 V =A0(min =3D =A0+1.31 V, max =3D =A0+3.63=
 V)<br>
&gt; Vbat: =A0 =A0 =A0 =A0 +3.42 V =A0(min =3D =A0+2.82 V, max =3D =A0+2.86=
 V) =A0ALARM<br>
&gt; fan1: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D 6026 RPM, div =3D 16) =A0A=
LARM<br>
&gt; fan2: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D 1757 RPM, div =3D 16) =A0A=
LARM<br>
&gt; fan3: =A0 =A0 =A0 =A03375 RPM =A0(min =3D =A0700 RPM, div =3D 8)<br>
&gt; fan5: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D 12053 RPM, div =3D 16) =A0=
ALARM<br>
&gt; temp1: =A0 =A0 =A0 =A0+34.0=B0C =A0(high =3D =A0-6.0=B0C, hyst =3D +15=
.0=B0C) =A0ALARM =A0sensor =3D thermistor<br>
&gt; temp2: =A0 =A0 =A0 =A0+46.5=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=
=B0C) =A0sensor =3D thermistor<br>
&gt; temp3: =A0 =A0 =A0 =A0+36.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=
=B0C) =A0sensor =3D thermistor<br>
&gt; intrusion0: =A0ALARM<br>
<br>
So, everything works just fine. What are you complaining about exactly,<br>
please?<br>
<span><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div>
</div></div></div><br>

--20cf3079b7eae7774d04d090522c--


--===============5955146195594850677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5955146195594850677==--
