From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 17:52:39 +0000
Subject: Re: [lm-sensors] [PATCH 17/17] drivers/hwmon/i5k_amb.c: fix
Message-Id: <CACW_hTZNuK1typBeCzVhaxaFRzN19fiwr4Ei+EW0_bhhA+LAXA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1217073944385620632=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1326039820-11147-17-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326039820-11147-17-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============1217073944385620632==
Content-Type: multipart/alternative; boundary=20cf30780d1aae95b904b607f2b0

--20cf30780d1aae95b904b607f2b0
Content-Type: text/plain; charset=ISO-8859-1

2012/1/8 Guenter Roeck <guenter.roeck@ericsson.com>

> Hi Frans,
>
> On Sun, Jan 08, 2012 at 11:23:40AM -0500, Frans Meulenbroeks wrote:
> > Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> > ---
> >  drivers/hwmon/i5k_amb.c |   15 ++++++++++++---
> >  1 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> > index d22f241..c516bdc 100644
> > --- a/drivers/hwmon/i5k_amb.c
> > +++ b/drivers/hwmon/i5k_amb.c
> > @@ -159,7 +159,10 @@ static ssize_t store_amb_min(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> >       struct i5k_amb_data *data = dev_get_drvdata(dev);
> > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> > +     unsigned long temp;
> > +     int ret = kstrtoul(buf, 10, &temp) / 500;
>
> This divides the error code by 500, not temp.
>
> > +     if (ret < 0)
> > +             return ret;
> >
> >       if (temp > 255)
> >               temp = 255;
> > @@ -175,7 +178,10 @@ static ssize_t store_amb_mid(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> >       struct i5k_amb_data *data = dev_get_drvdata(dev);
> > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> > +     unsigned long temp;
> > +     int ret = kstrtoul(buf, 10, &temp) / 500;
>
> Same here.
>
> > +     if (ret < 0)
> > +             return ret;
> >
> >       if (temp > 255)
> >               temp = 255;
> > @@ -191,7 +197,10 @@ static ssize_t store_amb_max(struct device *dev,
> >  {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> >       struct i5k_amb_data *data = dev_get_drvdata(dev);
> > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> > +     unsigned long temp;
> > +     int ret = kstrtoul(buf, 10, &temp) / 500;
>
> and here.
>
> Guenter
>
Yes of course!
That is one of the risks of these edits. At some point too much autopilot
creeps in.
I'll send an update. There are not otehr places that hae this issue.

BTW, there is one other thing with this code that might be questionalble
and that is the fact that temp is an unsigned long.
Is it not possible with this sensor to have a temp < 0 (I'm assuming temp
is degrees C or maybe F).
This might also be an issue on other places. (actually I seem to recall
having seen a place where the var was signed and the conversion function
was unsigned (or the other way around))

Best regards, Frans

--20cf30780d1aae95b904b607f2b0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/8 Guenter Roeck <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.c=
om</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Frans,<br>
<div class=3D"im"><br>
On Sun, Jan 08, 2012 at 11:23:40AM -0500, Frans Meulenbroeks wrote:<br>
&gt; Signed-off-by: Frans Meulenbroeks &lt;<a href=3D"mailto:fransmeulenbro=
eks@gmail.com">fransmeulenbroeks@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/hwmon/i5k_amb.c | =A0 15 ++++++++++++---<br>
&gt; =A01 files changed, 12 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c<br>
&gt; index d22f241..c516bdc 100644<br>
&gt; --- a/drivers/hwmon/i5k_amb.c<br>
&gt; +++ b/drivers/hwmon/i5k_amb.c<br>
&gt; @@ -159,7 +159,10 @@ static ssize_t store_amb_min(struct device *dev,<=
br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct sensor_device_attribute *attr =3D to_sensor_dev_att=
r(devattr);<br>
&gt; =A0 =A0 =A0 struct i5k_amb_data *data =3D dev_get_drvdata(dev);<br>
&gt; - =A0 =A0 unsigned long temp =3D simple_strtoul(buf, NULL, 10) / 500;<=
br>
&gt; + =A0 =A0 unsigned long temp;<br>
&gt; + =A0 =A0 int ret =3D kstrtoul(buf, 10, &amp;temp) / 500;<br>
<br>
</div>This divides the error code by 500, not temp.<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 if (ret &lt; 0)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (temp &gt; 255)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D 255;<br>
&gt; @@ -175,7 +178,10 @@ static ssize_t store_amb_mid(struct device *dev,<=
br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct sensor_device_attribute *attr =3D to_sensor_dev_att=
r(devattr);<br>
&gt; =A0 =A0 =A0 struct i5k_amb_data *data =3D dev_get_drvdata(dev);<br>
&gt; - =A0 =A0 unsigned long temp =3D simple_strtoul(buf, NULL, 10) / 500;<=
br>
&gt; + =A0 =A0 unsigned long temp;<br>
&gt; + =A0 =A0 int ret =3D kstrtoul(buf, 10, &amp;temp) / 500;<br>
<br>
</div>Same here.<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 if (ret &lt; 0)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (temp &gt; 255)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D 255;<br>
&gt; @@ -191,7 +197,10 @@ static ssize_t store_amb_max(struct device *dev,<=
br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct sensor_device_attribute *attr =3D to_sensor_dev_att=
r(devattr);<br>
&gt; =A0 =A0 =A0 struct i5k_amb_data *data =3D dev_get_drvdata(dev);<br>
&gt; - =A0 =A0 unsigned long temp =3D simple_strtoul(buf, NULL, 10) / 500;<=
br>
&gt; + =A0 =A0 unsigned long temp;<br>
&gt; + =A0 =A0 int ret =3D kstrtoul(buf, 10, &amp;temp) / 500;<br>
<br>
</div>and here.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div>Yes of course!<br>That is one of the risks=
 of these edits. At some point too much autopilot creeps in.<br>I&#39;ll se=
nd an update. There are not otehr places that hae this issue.<br><br>
BTW, there is one other thing with this code that might be questionalble an=
d that is the fact that temp is an unsigned long.<br>Is it not possible wit=
h this sensor to have a temp &lt; 0 (I&#39;m assuming temp is degrees C or =
maybe F).<br>

This might also be an issue on other places. (actually I seem to recall=20
having seen a place where the var was signed and the conversion function
 was unsigned (or the other way around))<br><br>Best regards, Frans

--20cf30780d1aae95b904b607f2b0--


--===============1217073944385620632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1217073944385620632==--
