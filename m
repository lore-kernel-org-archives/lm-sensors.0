From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Thu, 01 Nov 2012 21:18:53 +0000
Subject: Re: [lm-sensors] [PATCH 9/9] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <CAAek22FsqNHLRoKW5T_ONoTgc7_SxaLQCWWKXeaviGN7T5zPRQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8955506765063408495=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org

--===============8955506765063408495==
Content-Type: multipart/alternative; boundary=bcaec54c4f2cf5126f04cd75904c

--bcaec54c4f2cf5126f04cd75904c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 1, 2012 at 1:54 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Nov 01, 2012 at 07:12:08PM +0100, Jean Delvare wrote:
> > On Thu, 1 Nov 2012 10:17:07 -0700, Guenter Roeck wrote:
> > > On Thu, Nov 01, 2012 at 05:37:57PM +0100, Jean Delvare wrote:
> > > > On an IT8720F chip with temp3 configured for PECI:
> > > >
> > > > temp1_offset: 0
> > > > temp2_offset: 0
> > > > temp3_offset: -128000
> > > >
> > > > I'm unsure how to interpret this -128000... This value is definitel=
y
> > > > not neutral, doesn't sound very realistic. I would expect a positiv=
e
> > > > number for PECI. Maybe the offset register should be treated as
> > > > unsigned in PECI mode? Or maybe its value is irrelevant for the
> IT8720F
> > > > in PECI mode.
> > > >
> > > > # grep . /sys/class/hwmon/hwmon2/device/temp3*
> > > > /sys/class/hwmon/hwmon2/device/temp3_alarm:0
> > > > /sys/class/hwmon/hwmon2/device/temp3_beep:1
> > > > /sys/class/hwmon/hwmon2/device/temp3_input:25000
> > > > /sys/class/hwmon/hwmon2/device/temp3_max:70000
> > > > /sys/class/hwmon/hwmon2/device/temp3_min:127000
> > > > /sys/class/hwmon/hwmon2/device/temp3_offset:-128000
> > > > /sys/class/hwmon/hwmon2/device/temp3_type:6
> > > >
> > > > This is with an it87 driver including all your recent patches. It y=
ou
> > > > have ideas or theories, I'm interested.
> > > >
> > > Hi Jean,
> > >
> > > I agree. The alternative (+128 degrees C) sounds a bit high, though.
> > > Maybe there is another register on IT8720F to store Tjmax ? Did you
> check
> > > in the register map if there is a register value that happens to matc=
h
> it ?
> >
> > How would I know which value I am looking for? k10temp says this:
> > high =3D +70.0=B0C, crit =3D +90.0=B0C, hyst =3D +87.0=B0C
> > but the monitored value doesn't match it87's temp3.
>


> I don't know what AMD uses as equivalent of Tjmax - maybe they
> use a fixed value of 128=B0C.
>

Wouldn't it be 70 degC?  That's the "Tcontrol" value they always
reference.  Anything over 70deg C on the "Tcontrol" scale is "HOT"

Phil P.

--bcaec54c4f2cf5126f04cd75904c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Nov 1, 2012 at 1:54 PM, Guenter Roeck <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank"=
>linux@roeck-us.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
On Thu, Nov 01, 2012 at 07:12:08PM +0100, Jean Delvare wrote:<br>
&gt; On Thu, 1 Nov 2012 10:17:07 -0700, Guenter Roeck wrote:<br>
&gt; &gt; On Thu, Nov 01, 2012 at 05:37:57PM +0100, Jean Delvare wrote:<br>
&gt; &gt; &gt; On an IT8720F chip with temp3 configured for PECI:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; temp1_offset: 0<br>
&gt; &gt; &gt; temp2_offset: 0<br>
&gt; &gt; &gt; temp3_offset: -128000<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;m unsure how to interpret this -128000... This value i=
s definitely<br>
&gt; &gt; &gt; not neutral, doesn&#39;t sound very realistic. I would expec=
t a positive<br>
&gt; &gt; &gt; number for PECI. Maybe the offset register should be treated=
 as<br>
&gt; &gt; &gt; unsigned in PECI mode? Or maybe its value is irrelevant for =
the IT8720F<br>
&gt; &gt; &gt; in PECI mode.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; # grep . /sys/class/hwmon/hwmon2/device/temp3*<br>
&gt; &gt; &gt; /sys/class/hwmon/hwmon2/device/temp3_alarm:0<br>
&gt; &gt; &gt; /sys/class/hwmon/hwmon2/device/temp3_beep:1<br>
&gt; &gt; &gt; /sys/class/hwmon/hwmon2/device/temp3_input:25000<br>
&gt; &gt; &gt; /sys/class/hwmon/hwmon2/device/temp3_max:70000<br>
&gt; &gt; &gt; /sys/class/hwmon/hwmon2/device/temp3_min:127000<br>
&gt; &gt; &gt; /sys/class/hwmon/hwmon2/device/temp3_offset:-128000<br>
&gt; &gt; &gt; /sys/class/hwmon/hwmon2/device/temp3_type:6<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This is with an it87 driver including all your recent patche=
s. It you<br>
&gt; &gt; &gt; have ideas or theories, I&#39;m interested.<br>
&gt; &gt; &gt;<br>
&gt; &gt; Hi Jean,<br>
&gt; &gt;<br>
&gt; &gt; I agree. The alternative (+128 degrees C) sounds a bit high, thou=
gh.<br>
&gt; &gt; Maybe there is another register on IT8720F to store Tjmax ? Did y=
ou check<br>
&gt; &gt; in the register map if there is a register value that happens to =
match it ?<br>
&gt;<br>
&gt; How would I know which value I am looking for? k10temp says this:<br>
&gt; high =3D +70.0=B0C, crit =3D +90.0=B0C, hyst =3D +87.0=B0C<br>
&gt; but the monitored value doesn&#39;t match it87&#39;s temp3.<br>
</blockquote><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">I don&#39;t know what AMD uses as equivalent of Tjmax - maybe they<br>
use a fixed value of 128=B0C.<br></blockquote><div><br>Wouldn&#39;t it be 7=
0 degC?=A0 That&#39;s the &quot;Tcontrol&quot; value they always reference.=
=A0 Anything over 70deg C on the &quot;Tcontrol&quot; scale is &quot;HOT&qu=
ot;<br>
<br>Phil P.<br></div></div>

--bcaec54c4f2cf5126f04cd75904c--


--===============8955506765063408495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8955506765063408495==--
