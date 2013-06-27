From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 27 Jun 2013 22:33:03 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 v2] hwmon (ds1621): Add DS1731 chip support to ds1621 driver
Message-Id: <CAEZKy8JROjTQCCdi+QAai9ZqSHxNsxeGLLO23qVxUofGZEDJDQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8921634969687447977=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1370915163-30293-2-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1370915163-30293-2-git-send-email-rob.coulson@gmail.com>
To: lm-sensors@vger.kernel.org

--===============8921634969687447977==
Content-Type: multipart/alternative; boundary=001a11c2917c71cafa04e02a58ba

--001a11c2917c71cafa04e02a58ba
Content-Type: text/plain; charset=ISO-8859-1

Thanks for checking Jean, I appreciate it.
My apologies for the mis-spelling and mixing the use of '&' in plain
English.
And, thank you Guenter for fixing my mistakes.
Next time, I will try not to suffer from the same blindness before
submitting patches. (-;

Rob.


On Thu, Jun 27, 2013 at 10:35 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Jun 27, 2013 at 10:29:24AM +0200, Jean Delvare wrote:
> > Sorry for joining late in the game again...
> >
> > On Mon, 10 Jun 2013 18:46:02 -0700, Robert Coulson wrote:
> > > These changes add DS1731 chip support to the ds1621 driver,
> > > Kconfig, and documentation.
> >
> > Just two minor things I noticed while testing the ds1621 patches:
> >
> > > --- a/Documentation/hwmon/ds1621
> > > +++ b/Documentation/hwmon/ds1621
> > > (...)
> > > @@ -72,7 +77,7 @@ Temperature conversion of the DS1621 takes up to
> 1000ms; internal access to
> > >  non-volatile registers may last for 10ms or below.
> > >
> > >  The DS1625 is pin compatible and functionally equivalent with the
> DS1621,
> > > -but the DS1621 is meant to replace it. The DS1631 and DS1721 are also
> > > +but the DS1621 is meant to replace it. The DS1631, DS1721, & DS1731
> are also
> >
> > Please don't use "&" for "and" in plain English sentences, it hurts
> readability.
> >
> > > @@ -84,26 +89,27 @@ explicitly instantiated, one device per address,
> in this address
> > >  range: 0x48..0x4f.
> > >
> > >  The DS1721 is pin compatible with the DS1621, has an accuracy of +/-
> 1.0
> > > -degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
> > > -default setting of 75 and 80 degrees respectifully, and a maximum
> conversion
> > > -time of 750ms.
> > > +degree Celius (from -10 to +85 degrees), a minimum/maximum alarm
> default
> >
> > Typo: Celsius. The typo was already present before, it's not added by
> > this patch, but you have the opportunity to fix it.
> >
> I must be blind to have overlooked this one ;)
>
> I patched both up in my tree, no need to re-send (the Celius error was
> introduced with an earlier patch submitted by Rob, and it was spreading
> through later patches as well; I fixed all those as well).
>
> Guenter
>

--001a11c2917c71cafa04e02a58ba
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for checking Jean, I appreciate it.<div>My apologie=
s for the mis-spelling and mixing the use of &#39;&amp;&#39; in plain Engli=
sh.</div><div>And, thank you Guenter for fixing my mistakes.</div><div styl=
e>
Next time, I will try not to suffer from the same blindness before submitti=
ng patches. (-;</div><div style><br></div><div style>Rob.</div></div><div c=
lass=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu, Jun 27, 201=
3 at 10:35 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@=
roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, Jun 27, 2013 at 10:29:24AM +0200, Jean Delvare wrote:<br>
&gt; Sorry for joining late in the game again...<br>
&gt;<br>
&gt; On Mon, 10 Jun 2013 18:46:02 -0700, Robert Coulson wrote:<br>
&gt; &gt; These changes add DS1731 chip support to the ds1621 driver,<br>
&gt; &gt; Kconfig, and documentation.<br>
&gt;<br>
&gt; Just two minor things I noticed while testing the ds1621 patches:<br>
&gt;<br>
&gt; &gt; --- a/Documentation/hwmon/ds1621<br>
&gt; &gt; +++ b/Documentation/hwmon/ds1621<br>
&gt; &gt; (...)<br>
&gt; &gt; @@ -72,7 +77,7 @@ Temperature conversion of the DS1621 takes up t=
o 1000ms; internal access to<br>
&gt; &gt; =A0non-volatile registers may last for 10ms or below.<br>
&gt; &gt;<br>
&gt; &gt; =A0The DS1625 is pin compatible and functionally equivalent with =
the DS1621,<br>
&gt; &gt; -but the DS1621 is meant to replace it. The DS1631 and DS1721 are=
 also<br>
&gt; &gt; +but the DS1621 is meant to replace it. The DS1631, DS1721, &amp;=
 DS1731 are also<br>
&gt;<br>
&gt; Please don&#39;t use &quot;&amp;&quot; for &quot;and&quot; in plain En=
glish sentences, it hurts readability.<br>
&gt;<br>
&gt; &gt; @@ -84,26 +89,27 @@ explicitly instantiated, one device per addre=
ss, in this address<br>
&gt; &gt; =A0range: 0x48..0x4f.<br>
&gt; &gt;<br>
&gt; &gt; =A0The DS1721 is pin compatible with the DS1621, has an accuracy =
of +/- 1.0<br>
&gt; &gt; -degree Celius over a -10 to +85 degree range, a minimum/maximum =
alarm<br>
&gt; &gt; -default setting of 75 and 80 degrees respectifully, and a maximu=
m conversion<br>
&gt; &gt; -time of 750ms.<br>
&gt; &gt; +degree Celius (from -10 to +85 degrees), a minimum/maximum alarm=
 default<br>
&gt;<br>
&gt; Typo: Celsius. The typo was already present before, it&#39;s not added=
 by<br>
&gt; this patch, but you have the opportunity to fix it.<br>
&gt;<br>
</div></div>I must be blind to have overlooked this one ;)<br>
<br>
I patched both up in my tree, no need to re-send (the Celius error was<br>
introduced with an earlier patch submitted by Rob, and it was spreading<br>
through later patches as well; I fixed all those as well).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div><br></div>

--001a11c2917c71cafa04e02a58ba--


--===============8921634969687447977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8921634969687447977==--
