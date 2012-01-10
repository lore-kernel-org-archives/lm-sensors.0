From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 10 Jan 2012 14:33:25 +0000
Subject: Re: [lm-sensors] [PATCH 17/17] drivers/hwmon/i5k_amb.c: fix
Message-Id: <CACW_hTb2gmV0yVJu2kQ_L+kcORCvmH6KFso5tc9OB9ELhU6h1w@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5204249249976620316=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1326039820-11147-17-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326039820-11147-17-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============5204249249976620316==
Content-Type: multipart/alternative; boundary=20cf30780d1ad6336a04b62d6597

--20cf30780d1ad6336a04b62d6597
Content-Type: text/plain; charset=ISO-8859-1

2012/1/8 Guenter Roeck <guenter.roeck@ericsson.com>

> Hi Frans,
>
> On Sun, Jan 08, 2012 at 12:48:17PM -0500, Frans Meulenbroeks wrote:
> >
> >
> > 2012/1/8 Guenter Roeck <guenter.roeck@ericsson.com>
> >
> >     Hi Frans,
> >
> >     On Sun, Jan 08, 2012 at 11:23:40AM -0500, Frans Meulenbroeks wrote:
> >     > Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> >     > ---
> >     >  drivers/hwmon/i5k_amb.c |   15 ++++++++++++---
> >     >  1 files changed, 12 insertions(+), 3 deletions(-)
> >     >
> >     > diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> >     > index d22f241..c516bdc 100644
> >     > --- a/drivers/hwmon/i5k_amb.c
> >     > +++ b/drivers/hwmon/i5k_amb.c
> >     > @@ -159,7 +159,10 @@ static ssize_t store_amb_min(struct device
> *dev,
> >     >  {
> >     >       struct sensor_device_attribute *attr =
> to_sensor_dev_attr(devattr);
> >     >       struct i5k_amb_data *data = dev_get_drvdata(dev);
> >     > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> >     > +     unsigned long temp;
> >     > +     int ret = kstrtoul(buf, 10, &temp) / 500;
> >
> >     This divides the error code by 500, not temp.
> >
> >     > +     if (ret < 0)
> >     > +             return ret;
> >     >
> >     >       if (temp > 255)
> >     >               temp = 255;
> >     > @@ -175,7 +178,10 @@ static ssize_t store_amb_mid(struct device
> *dev,
> >     >  {
> >     >       struct sensor_device_attribute *attr =
> to_sensor_dev_attr(devattr);
> >     >       struct i5k_amb_data *data = dev_get_drvdata(dev);
> >     > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> >     > +     unsigned long temp;
> >     > +     int ret = kstrtoul(buf, 10, &temp) / 500;
> >
> >     Same here.
> >
> >     > +     if (ret < 0)
> >     > +             return ret;
> >     >
> >     >       if (temp > 255)
> >     >               temp = 255;
> >     > @@ -191,7 +197,10 @@ static ssize_t store_amb_max(struct device
> *dev,
> >     >  {
> >     >       struct sensor_device_attribute *attr =
> to_sensor_dev_attr(devattr);
> >     >       struct i5k_amb_data *data = dev_get_drvdata(dev);
> >     > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> >     > +     unsigned long temp;
> >     > +     int ret = kstrtoul(buf, 10, &temp) / 500;
> >
> >     and here.
> >
> >     Guenter
> >
> >
> > Yes of course!
> > That is one of the risks of these edits. At some point too much autopilot
> > creeps in.
> > I'll send an update. There are not otehr places that hae this issue.
> >
> > BTW, there is one other thing with this code that might be questionalble
> and
> > that is the fact that temp is an unsigned long.
> > Is it not possible with this sensor to have a temp < 0 (I'm assuming
> temp is
> > degrees C or maybe F).
>
> Usually that is reflected by the variable type and the conversion function.
> With unsigned long and kstrtoul(), negative values are not accepted,
> so that is commonly used if the sensor only supports non-negative
> temperatures.
> Which is exactly what happens here.
>
> Am I missing something ?
>
> > This might also be an issue on other places. (actually I seem to recall
> having
> > seen a place where the var was signed and the conversion function was
> unsigned
> > (or the other way around))
> >
> Usually both should match. If you notice a mismatch, please let us know.
>
>
> One other related thing, not really a mismatch but could also be changed:

static ssize_t set_fan_min(struct device *dev, struct device_attribute
*attr,
    const char *buf, size_t count)
{
    int nr = to_sensor_dev_attr(attr)->index;
    struct i2c_client *client = to_i2c_client(dev);
    struct lm80_data *data = i2c_get_clientdata(client);
    long val = simple_strtoul(buf, NULL, 10);

val is a long, but fan_min is quite likely not going to be negative ;-)
This might happen in other places too, but don't really have a simple way
to find these.

Best regards, Frans.

--20cf30780d1ad6336a04b62d6597
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/8 Guenter Roeck <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:guenter.roeck@ericsson.com" target=3D"_blank">guente=
r.roeck@ericsson.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

Hi Frans,<br>
<div><div><br>
On Sun, Jan 08, 2012 at 12:48:17PM -0500, Frans Meulenbroeks wrote:<br>
&gt;<br>
&gt;<br>
&gt; 2012/1/8 Guenter Roeck &lt;<a href=3D"mailto:guenter.roeck@ericsson.co=
m" target=3D"_blank">guenter.roeck@ericsson.com</a>&gt;<br>
&gt;<br>
&gt; =A0 =A0 Hi Frans,<br>
&gt;<br>
&gt; =A0 =A0 On Sun, Jan 08, 2012 at 11:23:40AM -0500, Frans Meulenbroeks w=
rote:<br>
&gt; =A0 =A0 &gt; Signed-off-by: Frans Meulenbroeks &lt;<a href=3D"mailto:f=
ransmeulenbroeks@gmail.com" target=3D"_blank">fransmeulenbroeks@gmail.com</=
a>&gt;<br>
&gt; =A0 =A0 &gt; ---<br>
&gt; =A0 =A0 &gt; =A0drivers/hwmon/i5k_amb.c | =A0 15 ++++++++++++---<br>
&gt; =A0 =A0 &gt; =A01 files changed, 12 insertions(+), 3 deletions(-)<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_=
amb.c<br>
&gt; =A0 =A0 &gt; index d22f241..c516bdc 100644<br>
&gt; =A0 =A0 &gt; --- a/drivers/hwmon/i5k_amb.c<br>
&gt; =A0 =A0 &gt; +++ b/drivers/hwmon/i5k_amb.c<br>
&gt; =A0 =A0 &gt; @@ -159,7 +159,10 @@ static ssize_t store_amb_min(struct =
device *dev,<br>
&gt; =A0 =A0 &gt; =A0{<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct sensor_device_attribute *attr =3D to_s=
ensor_dev_attr(devattr);<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct i5k_amb_data *data =3D dev_get_drvdata=
(dev);<br>
&gt; =A0 =A0 &gt; - =A0 =A0 unsigned long temp =3D simple_strtoul(buf, NULL=
, 10) / 500;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 unsigned long temp;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 int ret =3D kstrtoul(buf, 10, &amp;temp) / 500;=
<br>
&gt;<br>
&gt; =A0 =A0 This divides the error code by 500, not temp.<br>
&gt;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 if (ret &lt; 0)<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 if (temp &gt; 255)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D 255;<br>
&gt; =A0 =A0 &gt; @@ -175,7 +178,10 @@ static ssize_t store_amb_mid(struct =
device *dev,<br>
&gt; =A0 =A0 &gt; =A0{<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct sensor_device_attribute *attr =3D to_s=
ensor_dev_attr(devattr);<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct i5k_amb_data *data =3D dev_get_drvdata=
(dev);<br>
&gt; =A0 =A0 &gt; - =A0 =A0 unsigned long temp =3D simple_strtoul(buf, NULL=
, 10) / 500;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 unsigned long temp;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 int ret =3D kstrtoul(buf, 10, &amp;temp) / 500;=
<br>
&gt;<br>
&gt; =A0 =A0 Same here.<br>
&gt;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 if (ret &lt; 0)<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 if (temp &gt; 255)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D 255;<br>
&gt; =A0 =A0 &gt; @@ -191,7 +197,10 @@ static ssize_t store_amb_max(struct =
device *dev,<br>
&gt; =A0 =A0 &gt; =A0{<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct sensor_device_attribute *attr =3D to_s=
ensor_dev_attr(devattr);<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct i5k_amb_data *data =3D dev_get_drvdata=
(dev);<br>
&gt; =A0 =A0 &gt; - =A0 =A0 unsigned long temp =3D simple_strtoul(buf, NULL=
, 10) / 500;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 unsigned long temp;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 int ret =3D kstrtoul(buf, 10, &amp;temp) / 500;=
<br>
&gt;<br>
&gt; =A0 =A0 and here.<br>
&gt;<br>
&gt; =A0 =A0 Guenter<br>
&gt;<br>
&gt;<br>
&gt; Yes of course!<br>
&gt; That is one of the risks of these edits. At some point too much autopi=
lot<br>
&gt; creeps in.<br>
&gt; I&#39;ll send an update. There are not otehr places that hae this issu=
e.<br>
&gt;<br>
&gt; BTW, there is one other thing with this code that might be questionalb=
le and<br>
&gt; that is the fact that temp is an unsigned long.<br>
&gt; Is it not possible with this sensor to have a temp &lt; 0 (I&#39;m ass=
uming temp is<br>
&gt; degrees C or maybe F).<br>
<br>
</div></div>Usually that is reflected by the variable type and the conversi=
on function.<br>
With unsigned long and kstrtoul(), negative values are not accepted,<br>
so that is commonly used if the sensor only supports non-negative temperatu=
res.<br>
Which is exactly what happens here.<br>
<br>
Am I missing something ?<br>
<div><br>
&gt; This might also be an issue on other places. (actually I seem to recal=
l having<br>
&gt; seen a place where the var was signed and the conversion function was =
unsigned<br>
&gt; (or the other way around))<br>
&gt;<br>
</div>Usually both should match. If you notice a mismatch, please let us kn=
ow.<br>
<br>
<br></blockquote><div>One other related thing, not really a mismatch but co=
uld also be changed:<br><br>static ssize_t set_fan_min(struct device *dev, =
struct device_attribute *attr,<br>=A0=A0=A0 const char *buf, size_t count)<=
br>

{<br>=A0=A0=A0 int nr =3D to_sensor_dev_attr(attr)-&gt;index;<br>=A0=A0=A0 =
struct i2c_client *client =3D to_i2c_client(dev);<br>=A0=A0=A0 struct lm80_=
data *data =3D i2c_get_clientdata(client);<br>=A0=A0=A0 long val =3D simple=
_strtoul(buf, NULL, 10);<br>

<br>val is a long, but fan_min is quite likely not going to be negative ;-)=
<br>This might happen in other places too, but don&#39;t really have a simp=
le way to find these.<br><br>Best regards, Frans.<br>=A0<br></div></div>
<br>

--20cf30780d1ad6336a04b62d6597--


--===============5204249249976620316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5204249249976620316==--
