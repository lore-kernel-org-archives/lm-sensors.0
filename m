From: David Bartley <andareed@gmail.com>
Date: Tue, 02 Jul 2013 16:10:52 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of NCT6791D
Message-Id: <CAM9zjRNjuDH5MQegnaBWCekJSTJGiE4cn7zgSr75JLmxZjaBXA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6441297584835789478=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
To: lm-sensors@vger.kernel.org

--===============6441297584835789478==
Content-Type: multipart/alternative; boundary=047d7bf17c9c09e94704e08998e7

--047d7bf17c9c09e94704e08998e7
Content-Type: text/plain; charset=ISO-8859-1

The value of CR[20]/CR[21] on my board is 0xc8/0x03, and the physical chip
itself has "NCT6791D" printed on it.


On Tue, Jul 2, 2013 at 7:36 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Jul 02, 2013 at 10:24:22AM +0200, Jean Delvare wrote:
> > Hi Guenter,
> >
> > On Mon, 24 Jun 2013 13:19:39 -0700, Guenter Roeck wrote:
> > > New superio chip, found on recent ASUS boards.
> > >
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  CHANGES                    |    1 +
> > >  prog/detect/sensors-detect |    7 +++++++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/CHANGES b/CHANGES
> > > index 7036afe..b264f41 100644
> > > --- a/CHANGES
> > > +++ b/CHANGES
> > > @@ -6,6 +6,7 @@ SVN HEAD
> > >    sensors-detect: Report built-in drivers as such
> > >                    Use modules.builtin instead of /sys/module
> > >                    Handle built-in modules properly
> > > +                  Add detection of NCT6791D
> > >
> > >  3.3.4 (2013-05-27)
> > >    sensors.conf.5: Mention "sensors -u" to get the raw feature names
> > > diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> > > index 94645dc..9c213b6 100755
> > > --- a/prog/detect/sensors-detect
> > > +++ b/prog/detect/sensors-detect
> > > @@ -2063,6 +2063,13 @@ use constant FEAT_SMBUS      => (1 << 7);
> > >             logdev => 0x0b,
> > >             features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
> > >     }, {
> > > +           name => "Nuvoton NCT6791D Super IO Sensors",
> > > +           driver => "nct6775",
> > > +           devid => 0xC800,
> >
> > The datasheet says 0xC560. Who is right?
> >
> That would be the same as nct6779d, which seems unlikely. Driver code is
> from David Bartley, who I am sure tested it with his board.
>
> David, can you comment ?
>
> Once we know for sure I'll get in touch with Nuvoton and ask for
> clarification.
>
> Thanks,
> Guenter
>

--047d7bf17c9c09e94704e08998e7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The value of CR[20]/CR[21] on my board is 0xc8/0x03, and t=
he physical chip itself has &quot;NCT6791D&quot; printed on it.</div><div c=
lass=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, Jul 2, 2013=
 at 7:36 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@ro=
eck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Tue, Jul 02, 2013 at 10:24:22AM +0200, Je=
an Delvare wrote:<br>
&gt; Hi Guenter,<br>
&gt;<br>
&gt; On Mon, 24 Jun 2013 13:19:39 -0700, Guenter Roeck wrote:<br>
&gt; &gt; New superio chip, found on recent ASUS boards.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us=
.net">linux@roeck-us.net</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; =A0CHANGES =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +<br=
>
&gt; &gt; =A0prog/detect/sensors-detect | =A0 =A07 +++++++<br>
&gt; &gt; =A02 files changed, 8 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/CHANGES b/CHANGES<br>
&gt; &gt; index 7036afe..b264f41 100644<br>
&gt; &gt; --- a/CHANGES<br>
&gt; &gt; +++ b/CHANGES<br>
&gt; &gt; @@ -6,6 +6,7 @@ SVN HEAD<br>
&gt; &gt; =A0 =A0sensors-detect: Report built-in drivers as such<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Use modules.builtin instea=
d of /sys/module<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Handle built-in modules pr=
operly<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Add detection of NCT6791D<br=
>
&gt; &gt;<br>
&gt; &gt; =A03.3.4 (2013-05-27)<br>
&gt; &gt; =A0 =A0sensors.conf.5: Mention &quot;sensors -u&quot; to get the =
raw feature names<br>
&gt; &gt; diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-det=
ect<br>
&gt; &gt; index 94645dc..9c213b6 100755<br>
&gt; &gt; --- a/prog/detect/sensors-detect<br>
&gt; &gt; +++ b/prog/detect/sensors-detect<br>
&gt; &gt; @@ -2063,6 +2063,13 @@ use constant FEAT_SMBUS =A0 =A0 =A0=3D&gt;=
 (1 &lt;&lt; 7);<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 logdev =3D&gt; 0x0b,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 features =3D&gt; FEAT_IN | FEAT_FAN | FEA=
T_TEMP,<br>
&gt; &gt; =A0 =A0 }, {<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 name =3D&gt; &quot;Nuvoton NCT6791D Super I=
O Sensors&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 driver =3D&gt; &quot;nct6775&quot;,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 devid =3D&gt; 0xC800,<br>
&gt;<br>
&gt; The datasheet says 0xC560. Who is right?<br>
&gt;<br>
That would be the same as nct6779d, which seems unlikely. Driver code is<br=
>
from David Bartley, who I am sure tested it with his board.<br>
<br>
David, can you comment ?<br>
<br>
Once we know for sure I&#39;ll get in touch with Nuvoton and ask for clarif=
ication.<br>
<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br></div>

--047d7bf17c9c09e94704e08998e7--


--===============6441297584835789478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6441297584835789478==--
