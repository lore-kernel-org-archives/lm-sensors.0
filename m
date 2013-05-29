From: Robert Coulson <rob.coulson@gmail.com>
Date: Wed, 29 May 2013 23:02:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon (ds1621): Add DS1731 chip support to ds1621 driver
Message-Id: <CAEZKy8+=cHoZj4ATXCcc_VybjtfTBQ2WBLBcFuVu7V6Z3O1AFQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7946169746138546927=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1369785362-19133-2-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1369785362-19133-2-git-send-email-rob.coulson@gmail.com>
To: lm-sensors@vger.kernel.org

--===============7946169746138546927==
Content-Type: multipart/alternative; boundary=001a11c231dee1b6f504dde361f6

--001a11c231dee1b6f504dde361f6
Content-Type: text/plain; charset=ISO-8859-1

On Tue, May 28, 2013 at 7:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, May 28, 2013 at 04:56:01PM -0700, Robert Coulson wrote:
> > These changes add DS1731 chip support to the ds1621 driver,
> > Kconfig, and documentation.
> >
> > Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
>
> Hi Rob,
>
> Nitpicks ...
>

Good afternoon Guenter,


>
> > ---
> >  Documentation/hwmon/ds1621 |   22 ++++++++++++++--------
> >  drivers/hwmon/Kconfig      |    1 +
> >  drivers/hwmon/ds1621.c     |   12 +++++++-----
> >  3 files changed, 22 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
> > index 2022379..64ee39f 100644
> > --- a/Documentation/hwmon/ds1621
> > +++ b/Documentation/hwmon/ds1621
> > @@ -22,6 +22,11 @@ Supported chips:
> >      Addresses scanned: none
> >      Datasheet: Publicly available from www.maximintegrated.com
> >
> > +  * Maxim Integrated DS1731
> > +    Prefix: 'ds1731'
> > +    Addresses scanned: none
> > +    Datasheet: Publicly available from www.maximintegrated.com
> > +
> >  Authors:
> >          Christian W. Zuckschwerdt <zany@triq.net>
> >          valuable contributions by Jan M. Sendler <sendler@sendler.de>
> > @@ -72,7 +77,7 @@ Temperature conversion of the DS1621 takes up to
> 1000ms; internal access to
> >  non-volatile registers may last for 10ms or below.
> >
> >  The DS1625 is pin compatible and functionally equivalent with the
> DS1621,
> > -but the DS1621 is meant to replace it. The DS1631 and DS1721 are also
> > +but the DS1621 is meant to replace it. The DS1631, DS1721, & DS1731 are
> also
> >  pin compatible with the DS1621, but provide multi-resolution support.
> >
> >  Since there is no version or vendor identification register, there is
> > @@ -96,14 +101,15 @@ One additional note about the ds1721 is that
> although the data sheet says
> >  the temperature flags (THF and TLF) are used internally, these flags do
> >  get set and cleared as the actual temperature crosses the min or max
> settings.
> >
> > -The DS1631 is also pin compatible with the DS1621 and feature
> compatible with
> > -the DS1721, however the DS1631 accuracy is +/- 0.5 degree Celius over
> the
> > -same range.
> > +The DS1631 and DS1731 are pin compatible with the DS1621 and feature
> compatible
> > +with the DS1721, however, the DS1631 accuracy is +/- 0.5 degree Celius
> over
>
>         DS1721. However, ...
>

fixed.


>
> > +the 0 to +70 degrees, while the DS1731 accuracy is +/-1 degree Celius
> over the
>
> "over the ... degrees" sounds weird. "over the range of", maybe ? Or at
> least
> add "range" after "degrees".
>

how about 'within -10 to +85 degrees'.


>
> > +-10 to +85 degree range.
> >
> > -Changing the DS1631/1721 resolution mode affects the conversion time
> and can be
> > -done from userspace, via the device 'update_interval' sysfs attribute.
> This
> > -attribute will normalize range of input values to the device maximum
> resolution
> > -values defined in the datasheet as such:
> > +Changing the DS1631, DS1721, or DS1731 resolution mode affects the
> conversion
>
> Changing the resolution mode for ... affects
>

agreed.


>
> > +time and can be done from userspace, via the device 'update_interval'
> sysfs
> > +attribute. This attribute will normalize range of input values to the
> device
> > +maximum resolution values defined in the datasheet as such:
> >
>         as follows ?
>

agreed.


>
> >  Resolution    Conversion Time    Input Range
> >   (C/LSB)       (msec)             (msec)
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 0f20eef..38c27b2 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -324,6 +324,7 @@ config SENSORS_DS1621
> >         - Dallas Semiconductor DS1625
> >         - Maxim Integrated DS1631
> >         - Maxim Integrated DS1721
> > +       - Maxim Integrated DS1731
> >
> >         This driver can also be built as a module.  If so, the module
> >         will be called ds1621.
> > diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
> > index 1ecfcd0..c94495e 100644
> > --- a/drivers/hwmon/ds1621.c
> > +++ b/drivers/hwmon/ds1621.c
> > @@ -10,8 +10,8 @@
> >   * resolution, a thermal alarm output (Tout), and user-defined minimum
> >   * and maximum temperature thresholds (TH & TL).
> >   *
> > - * The DS1625, DS1631, & DS1721 are pin compatible with the DS1621 and
> > - * similar in operation, with slight variations as noted in the device
> > + * The DS1625, DS1631, DS1721, & DS1731 are pin compatible with the
> DS1621
> > + * and similar in operation, with slight variations as noted in the
> device
> >   * datasheets (please refer to www.maximintegrated.com for specific
> >   * device information).
> >   *
> > @@ -47,7 +47,7 @@
> >  #include <linux/kernel.h>
> >
> >  /* Supported devices */
> > -enum chips { ds1621, ds1625, ds1631, ds1721 };
> > +enum chips { ds1621, ds1625, ds1631, ds1721, ds1731 };
> >
> >  /* Insmod parameters */
> >  static int polarity = -1;
> > @@ -65,7 +65,7 @@ MODULE_PARM_DESC(polarity, "Output's polarity: 0 =
> active high, 1 = active low")
> >   *   7    6    5    4    3    2    1    0
> >   * |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT|
> >   *
> > - * - DS1631:
> > + * - DS1631, DS1731:
> >   *   7    6    5    4    3    2    1    0
> >   * |Done|THF |TLF |NVB | R1 | R0 |POL |1SHOT|
> >   *
> > @@ -140,7 +140,7 @@ static inline int DS1621_TEMP_FROM_REG(u16 reg)
> >   * TEMP: 0.001C/bit (-55C to +125C)
> >   * REG:
> >   *  - 1621, 1625: 0.5C/bit
> > - *  - 1631, 1721: 0.0625C/bit
> > + *  - 1631, 1721, 1731: 0.0625C/bit
> >   * Assume highest resolution and let the bits fall where they may..
> >   */
> >  static inline u16 DS1621_TEMP_TO_REG(long temp)
> > @@ -176,6 +176,7 @@ static void ds1621_init_client(struct i2c_client
> *client)
> >               break;
> >       case ds1631:
> >       case ds1721:
> > +     case ds1731:
> >               resol = (new_conf & DS1621_REG_CONFIG_RESOL) >>
> >                        DS1621_REG_CONFIG_RESOL_SHIFT;
> >               data->update_interval = ds1721_convrates[resol];
> > @@ -408,6 +409,7 @@ static const struct i2c_device_id ds1621_id[] = {
> >       { "ds1625", ds1625 },
> >       { "ds1631", ds1631 },
> >       { "ds1721", ds1721 },
> > +     { "ds1731", ds1731 },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ds1621_id);
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
>

--001a11c231dee1b6f504dde361f6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, May 28, 2013 at 7:52 PM, Guenter Roeck <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a=
>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Tue, May 28, 2013 at 04=
:56:01PM -0700, Robert Coulson wrote:<br>
&gt; These changes add DS1731 chip support to the ds1621 driver,<br>
&gt; Kconfig, and documentation.<br>
&gt;<br>
&gt; Signed-off-by: Robert Coulson &lt;<a href=3D"mailto:rob.coulson@gmail.=
com">rob.coulson@gmail.com</a>&gt;<br>
<br>
</div>Hi Rob,<br>
<br>
Nitpicks ...<br></blockquote><div><br></div><div style>Good afternoon Guent=
er,</div><div style>=A0<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0Documentation/hwmon/ds1621 | =A0 22 ++++++++++++++--------<br>
&gt; =A0drivers/hwmon/Kconfig =A0 =A0 =A0| =A0 =A01 +<br>
&gt; =A0drivers/hwmon/ds1621.c =A0 =A0 | =A0 12 +++++++-----<br>
&gt; =A03 files changed, 22 insertions(+), 13 deletions(-)<br>
&gt;<br>
&gt; diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621<b=
r>
&gt; index 2022379..64ee39f 100644<br>
&gt; --- a/Documentation/hwmon/ds1621<br>
&gt; +++ b/Documentation/hwmon/ds1621<br>
&gt; @@ -22,6 +22,11 @@ Supported chips:<br>
&gt; =A0 =A0 =A0Addresses scanned: none<br>
&gt; =A0 =A0 =A0Datasheet: Publicly available from <a href=3D"http://www.ma=
ximintegrated.com" target=3D"_blank">www.maximintegrated.com</a><br>
&gt;<br>
&gt; + =A0* Maxim Integrated DS1731<br>
&gt; + =A0 =A0Prefix: &#39;ds1731&#39;<br>
&gt; + =A0 =A0Addresses scanned: none<br>
&gt; + =A0 =A0Datasheet: Publicly available from <a href=3D"http://www.maxi=
mintegrated.com" target=3D"_blank">www.maximintegrated.com</a><br>
&gt; +<br>
&gt; =A0Authors:<br>
&gt; =A0 =A0 =A0 =A0 =A0Christian W. Zuckschwerdt &lt;<a href=3D"mailto:zan=
y@triq.net">zany@triq.net</a>&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0valuable contributions by Jan M. Sendler &lt;<a hre=
f=3D"mailto:sendler@sendler.de">sendler@sendler.de</a>&gt;<br>
&gt; @@ -72,7 +77,7 @@ Temperature conversion of the DS1621 takes up to 100=
0ms; internal access to<br>
&gt; =A0non-volatile registers may last for 10ms or below.<br>
&gt;<br>
&gt; =A0The DS1625 is pin compatible and functionally equivalent with the D=
S1621,<br>
&gt; -but the DS1621 is meant to replace it. The DS1631 and DS1721 are also=
<br>
&gt; +but the DS1621 is meant to replace it. The DS1631, DS1721, &amp; DS17=
31 are also<br>
&gt; =A0pin compatible with the DS1621, but provide multi-resolution suppor=
t.<br>
&gt;<br>
&gt; =A0Since there is no version or vendor identification register, there =
is<br>
&gt; @@ -96,14 +101,15 @@ One additional note about the ds1721 is that alth=
ough the data sheet says<br>
&gt; =A0the temperature flags (THF and TLF) are used internally, these flag=
s do<br>
&gt; =A0get set and cleared as the actual temperature crosses the min or ma=
x settings.<br>
&gt;<br>
&gt; -The DS1631 is also pin compatible with the DS1621 and feature compati=
ble with<br>
&gt; -the DS1721, however the DS1631 accuracy is +/- 0.5 degree Celius over=
 the<br>
&gt; -same range.<br>
&gt; +The DS1631 and DS1731 are pin compatible with the DS1621 and feature =
compatible<br>
&gt; +with the DS1721, however, the DS1631 accuracy is +/- 0.5 degree Celiu=
s over<br>
<br>
</div></div>=A0 =A0 =A0 =A0 DS1721. However, ...<br></blockquote><div><br><=
/div><div style>fixed.</div><div style>=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<div class=3D"im"><br>
&gt; +the 0 to +70 degrees, while the DS1731 accuracy is +/-1 degree Celius=
 over the<br>
<br>
</div>&quot;over the ... degrees&quot; sounds weird. &quot;over the range o=
f&quot;, maybe ? Or at least<br>
add &quot;range&quot; after &quot;degrees&quot;.<br></blockquote><div><br><=
/div><div style>how about &#39;within -10 to +85 degrees&#39;.</div><div st=
yle>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im"><br>
&gt; +-10 to +85 degree range.<br>
&gt;<br>
&gt; -Changing the DS1631/1721 resolution mode affects the conversion time =
and can be<br>
&gt; -done from userspace, via the device &#39;update_interval&#39; sysfs a=
ttribute. This<br>
&gt; -attribute will normalize range of input values to the device maximum =
resolution<br>
&gt; -values defined in the datasheet as such:<br>
&gt; +Changing the DS1631, DS1721, or DS1731 resolution mode affects the co=
nversion<br>
<br>
</div>Changing the resolution mode for ... affects<br></blockquote><div><br=
></div><div style>agreed.</div><div style>=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">

<div class=3D"im"><br>
&gt; +time and can be done from userspace, via the device &#39;update_inter=
val&#39; sysfs<br>
&gt; +attribute. This attribute will normalize range of input values to the=
 device<br>
&gt; +maximum resolution values defined in the datasheet as such:<br>
&gt;<br>
</div>=A0 =A0 =A0 =A0 as follows ?<br></blockquote><div><br></div><div styl=
e>agreed.</div><div style>=A0<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; =A0Resolution =A0 =A0Conversion Time =A0 =A0Input Range<br>
&gt; =A0 (C/LSB) =A0 =A0 =A0 (msec) =A0 =A0 =A0 =A0 =A0 =A0 (msec)<br>
&gt; diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig<br>
&gt; index 0f20eef..38c27b2 100644<br>
&gt; --- a/drivers/hwmon/Kconfig<br>
&gt; +++ b/drivers/hwmon/Kconfig<br>
&gt; @@ -324,6 +324,7 @@ config SENSORS_DS1621<br>
&gt; =A0 =A0 =A0 =A0 - Dallas Semiconductor DS1625<br>
&gt; =A0 =A0 =A0 =A0 - Maxim Integrated DS1631<br>
&gt; =A0 =A0 =A0 =A0 - Maxim Integrated DS1721<br>
&gt; + =A0 =A0 =A0 - Maxim Integrated DS1731<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so, t=
he module<br>
&gt; =A0 =A0 =A0 =A0 will be called ds1621.<br>
&gt; diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c<br>
&gt; index 1ecfcd0..c94495e 100644<br>
&gt; --- a/drivers/hwmon/ds1621.c<br>
&gt; +++ b/drivers/hwmon/ds1621.c<br>
&gt; @@ -10,8 +10,8 @@<br>
&gt; =A0 * resolution, a thermal alarm output (Tout), and user-defined mini=
mum<br>
&gt; =A0 * and maximum temperature thresholds (TH &amp; TL).<br>
&gt; =A0 *<br>
&gt; - * The DS1625, DS1631, &amp; DS1721 are pin compatible with the DS162=
1 and<br>
&gt; - * similar in operation, with slight variations as noted in the devic=
e<br>
&gt; + * The DS1625, DS1631, DS1721, &amp; DS1731 are pin compatible with t=
he DS1621<br>
&gt; + * and similar in operation, with slight variations as noted in the d=
evice<br>
&gt; =A0 * datasheets (please refer to <a href=3D"http://www.maximintegrate=
d.com" target=3D"_blank">www.maximintegrated.com</a> for specific<br>
&gt; =A0 * device information).<br>
&gt; =A0 *<br>
&gt; @@ -47,7 +47,7 @@<br>
&gt; =A0#include &lt;linux/kernel.h&gt;<br>
&gt;<br>
&gt; =A0/* Supported devices */<br>
&gt; -enum chips { ds1621, ds1625, ds1631, ds1721 };<br>
&gt; +enum chips { ds1621, ds1625, ds1631, ds1721, ds1731 };<br>
&gt;<br>
&gt; =A0/* Insmod parameters */<br>
&gt; =A0static int polarity =3D -1;<br>
&gt; @@ -65,7 +65,7 @@ MODULE_PARM_DESC(polarity, &quot;Output&#39;s polari=
ty: 0 =3D active high, 1 =3D active low&quot;)<br>
&gt; =A0 * =A0 7 =A0 =A06 =A0 =A05 =A0 =A04 =A0 =A03 =A0 =A02 =A0 =A01 =A0 =
=A00<br>
&gt; =A0 * |Done|THF |TLF |NVB | 1 =A0| 0 =A0|POL |1SHOT|<br>
&gt; =A0 *<br>
&gt; - * - DS1631:<br>
&gt; + * - DS1631, DS1731:<br>
&gt; =A0 * =A0 7 =A0 =A06 =A0 =A05 =A0 =A04 =A0 =A03 =A0 =A02 =A0 =A01 =A0 =
=A00<br>
&gt; =A0 * |Done|THF |TLF |NVB | R1 | R0 |POL |1SHOT|<br>
&gt; =A0 *<br>
&gt; @@ -140,7 +140,7 @@ static inline int DS1621_TEMP_FROM_REG(u16 reg)<br=
>
&gt; =A0 * TEMP: 0.001C/bit (-55C to +125C)<br>
&gt; =A0 * REG:<br>
&gt; =A0 * =A0- 1621, 1625: 0.5C/bit<br>
&gt; - * =A0- 1631, 1721: 0.0625C/bit<br>
&gt; + * =A0- 1631, 1721, 1731: 0.0625C/bit<br>
&gt; =A0 * Assume highest resolution and let the bits fall where they may..=
<br>
&gt; =A0 */<br>
&gt; =A0static inline u16 DS1621_TEMP_TO_REG(long temp)<br>
&gt; @@ -176,6 +176,7 @@ static void ds1621_init_client(struct i2c_client *=
client)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; =A0 =A0 =A0 case ds1631:<br>
&gt; =A0 =A0 =A0 case ds1721:<br>
&gt; + =A0 =A0 case ds1731:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 resol =3D (new_conf &amp; DS1621_REG_CONFI=
G_RESOL) &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DS1621_REG_CONFIG_RESOL=
_SHIFT;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;update_interval =3D ds1721_convra=
tes[resol];<br>
&gt; @@ -408,6 +409,7 @@ static const struct i2c_device_id ds1621_id[] =3D =
{<br>
&gt; =A0 =A0 =A0 { &quot;ds1625&quot;, ds1625 },<br>
&gt; =A0 =A0 =A0 { &quot;ds1631&quot;, ds1631 },<br>
&gt; =A0 =A0 =A0 { &quot;ds1721&quot;, ds1721 },<br>
&gt; + =A0 =A0 { &quot;ds1731&quot;, ds1731 },<br>
&gt; =A0 =A0 =A0 { }<br>
&gt; =A0};<br>
&gt; =A0MODULE_DEVICE_TABLE(i2c, ds1621_id);<br>
&gt; --<br>
&gt; 1.7.9.5<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lm-sensors mailing list<br>
&gt; <a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org=
</a><br>
&gt; <a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" ta=
rget=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a>=
<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--001a11c231dee1b6f504dde361f6--


--===============7946169746138546927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7946169746138546927==--
