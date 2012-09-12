From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Wed, 12 Sep 2012 03:47:08 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/5] hwmon: (twl4030-madc-hwmon) Initialize uninitialized structure eleme
Message-Id: <CAJ6a13atSV+TtcjakoHs9Q8sgi6Ta69ubOxWtcqtwp5p0_MP5A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6480059661928410753=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1347381259-14585-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347381259-14585-2-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org

--===============6480059661928410753==
Content-Type: multipart/alternative; boundary=14dae9cfc700977fd004c978e038

--14dae9cfc700977fd004c978e038
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Sep 12, 2012 at 2:28 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Tue, 11 Sep 2012 09:34:15 -0700, Guenter Roeck wrote:
> > twl4030_madc_conversion uses do_avg and type structure elements of
> > twl4030_madc_request. Initialize structure to avoid random operation.
> >
> > Cc: Keerthy <j-keerthy@ti.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
>
Acked-by: Jean Delvare <khali@linux-fr.org>
>
> Acked-by: Keerthy <j-keerthy@ti.com>

> > ---
> > v2: review feedback - initialize twl4030_madc_request structure in
> declaration.
> >     With this change, I think this patch is a candidate for 3.6 and
> -stable.
> >
> >  drivers/hwmon/twl4030-madc-hwmon.c |    9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hwmon/twl4030-madc-hwmon.c
> b/drivers/hwmon/twl4030-madc-hwmon.c
> > index 0018c7d..1a174f0 100644
> > --- a/drivers/hwmon/twl4030-madc-hwmon.c
> > +++ b/drivers/hwmon/twl4030-madc-hwmon.c
> > @@ -44,12 +44,13 @@ static ssize_t madc_read(struct device *dev,
> >                        struct device_attribute *devattr, char *buf)
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > -     struct twl4030_madc_request req;
> > +     struct twl4030_madc_request req = {
> > +             .channels = 1 << attr->index,
> > +             .method = TWL4030_MADC_SW2,
> > +             .type = TWL4030_MADC_WAIT,
> > +     };
> >       long val;
> >
> > -     req.channels = (1 << attr->index);
> > -     req.method = TWL4030_MADC_SW2;
> > -     req.func_cb = NULL;
> >       val = twl4030_madc_conversion(&req);
> >       if (val < 0)
> >               return val;
>
>
> --
> Jean Delvare
>



-- 
Regards and Thanks,
Keerthy

--14dae9cfc700977fd004c978e038
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Sep 12, 2012 at 2:28 AM, Jean De=
lvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=3D=
"_blank">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<div>On Tue, 11 Sep 2012 09:34:15 -0700, Guenter Roeck wrote:<br>
&gt; twl4030_madc_conversion uses do_avg and type structure elements of<br>
&gt; twl4030_madc_request. Initialize structure to avoid random operation.<=
br>
&gt;<br>
&gt; Cc: Keerthy &lt;<a href=3D"mailto:j-keerthy@ti.com">j-keerthy@ti.com</=
a>&gt;<br>
&gt; Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net"=
>linux@roeck-us.net</a>&gt;<br>=A0
<br></div></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im">
</div>Acked-by: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khal=
i@linux-fr.org</a>&gt;<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote><div>A=
cked-by:=A0Keerthy &lt;<a href=3D"mailto:j-keerthy@ti.com">j-keerthy@ti.com=
</a>&gt;<br> </div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">
&gt; ---<br>
&gt; v2: review feedback - initialize twl4030_madc_request structure in dec=
laration.<br>
&gt; =A0 =A0 With this change, I think this patch is a candidate for 3.6 an=
d -stable.<br>
&gt;<br>
&gt; =A0drivers/hwmon/twl4030-madc-hwmon.c | =A0 =A09 +++++----<br>
&gt; =A01 file changed, 5 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl403=
0-madc-hwmon.c<br>
&gt; index 0018c7d..1a174f0 100644<br>
&gt; --- a/drivers/hwmon/twl4030-madc-hwmon.c<br>
&gt; +++ b/drivers/hwmon/twl4030-madc-hwmon.c<br>
&gt; @@ -44,12 +44,13 @@ static ssize_t madc_read(struct device *dev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute=
 *devattr, char *buf)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct sensor_device_attribute *attr =3D to_sensor_dev_att=
r(devattr);<br>
&gt; - =A0 =A0 struct twl4030_madc_request req;<br>
&gt; + =A0 =A0 struct twl4030_madc_request req =3D {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channels =3D 1 &lt;&lt; attr-&gt;index,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .method =3D TWL4030_MADC_SW2,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .type =3D TWL4030_MADC_WAIT,<br>
&gt; + =A0 =A0 };<br>
&gt; =A0 =A0 =A0 long val;<br>
&gt;<br>
&gt; - =A0 =A0 req.channels =3D (1 &lt;&lt; attr-&gt;index);<br>
&gt; - =A0 =A0 req.method =3D TWL4030_MADC_SW2;<br>
&gt; - =A0 =A0 req.func_cb =3D NULL;<br>
&gt; =A0 =A0 =A0 val =3D twl4030_madc_conversion(&amp;req);<br>
&gt; =A0 =A0 =A0 if (val &lt; 0)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return val;<br>
<br>
<br>
--<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">Jean Delvare<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards a=
nd Thanks,<br>Keerthy<br>

--14dae9cfc700977fd004c978e038--


--===============6480059661928410753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6480059661928410753==--
