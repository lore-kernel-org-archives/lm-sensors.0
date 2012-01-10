From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 10 Jan 2012 18:50:14 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm80) fixed checkpatch errors
Message-Id: <CACW_hTYvPTsEYpCY1pwpu-MYE5NpiZoRYy8qqryTcv2fNWerRg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4401596151077528038=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1326206976-7846-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326206976-7846-1-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============4401596151077528038==
Content-Type: multipart/alternative; boundary=14dae9cc96885029ba04b630fcb1

--14dae9cc96885029ba04b630fcb1
Content-Type: text/plain; charset=ISO-8859-1

2012/1/10 Guenter Roeck <guenter.roeck@ericsson.com>

> Hi Frans,
>
> On Tue, 2012-01-10 at 09:49 -0500, Frans Meulenbroeks wrote:
> > fixed:
> > WARNING: simple_strtol is obsolete, use kstrtol instead
> > WARNING: simple_strtoul is obsolete, use kstrtoul instead
> >
> > Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> > ---
> >  drivers/hwmon/lm80.c |   20 ++++++++++++++++----
> >  1 files changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> > index 616f470..18e5ea4 100644
> > --- a/drivers/hwmon/lm80.c
> > +++ b/drivers/hwmon/lm80.c
> > @@ -185,7 +185,10 @@ static ssize_t set_in_##suffix(struct device *dev, \
> >       int nr = to_sensor_dev_attr(attr)->index; \
> >       struct i2c_client *client = to_i2c_client(dev); \
> >       struct lm80_data *data = i2c_get_clientdata(client); \
> > -     long val = simple_strtol(buf, NULL, 10); \
> > +     long val; \
> > +     int err = kstrtol(buf, 10, &val); \
> > +     if (err < 0) \
> > +             return err; \
> >  \
> >       mutex_lock(&data->update_lock);\
> >       data->value[nr] = IN_TO_REG(val); \
> > @@ -226,7 +229,10 @@ static ssize_t set_fan_min(struct device *dev,
> struct device_attribute *attr,
> >       int nr = to_sensor_dev_attr(attr)->index;
> >       struct i2c_client *client = to_i2c_client(dev);
> >       struct lm80_data *data = i2c_get_clientdata(client);
> > -     long val = simple_strtoul(buf, NULL, 10);
> > +     long val;
> > +     int err = kstrtol(buf, 10, &val);
> > +     if (err < 0)
> > +             return err;
> >
> You replaced simple_strtoul() with kstrtol(). Should have been unsigned
> long and kstrtoul(). No need to resubmit, I fixed that. Queued for -rc2.
>
> Thanks,
> Guenter
>

Hi  Guenter,

The change was on two places and intentional.

The original code reads:
long val = simple_strtoul(buf, NULL, 10);
I feel this is a flaw and that simple_strtol should have been used here
(and eventually kstrtol.
(or alternately the variable should have been an unsigned long)

(and yes, I agree that this should have been made explicit in the commit
message).

Can you revert your fix on both places (and probably add a line or two to
the commit message)

Thanks. Frans.

--14dae9cc96885029ba04b630fcb1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/10 Guenter Roeck <span dir=3D"ltr=
">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.=
com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Frans,<br>
<div><div class=3D"h5"><br>
On Tue, 2012-01-10 at 09:49 -0500, Frans Meulenbroeks wrote:<br>
&gt; fixed:<br>
&gt; WARNING: simple_strtol is obsolete, use kstrtol instead<br>
&gt; WARNING: simple_strtoul is obsolete, use kstrtoul instead<br>
&gt;<br>
&gt; Signed-off-by: Frans Meulenbroeks &lt;<a href=3D"mailto:fransmeulenbro=
eks@gmail.com">fransmeulenbroeks@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/hwmon/lm80.c | =A0 20 ++++++++++++++++----<br>
&gt; =A01 files changed, 16 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c<br>
&gt; index 616f470..18e5ea4 100644<br>
&gt; --- a/drivers/hwmon/lm80.c<br>
&gt; +++ b/drivers/hwmon/lm80.c<br>
&gt; @@ -185,7 +185,10 @@ static ssize_t set_in_##suffix(struct device *dev=
, \<br>
&gt; =A0 =A0 =A0 int nr =3D to_sensor_dev_attr(attr)-&gt;index; \<br>
&gt; =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev); \<br>
&gt; =A0 =A0 =A0 struct lm80_data *data =3D i2c_get_clientdata(client); \<b=
r>
&gt; - =A0 =A0 long val =3D simple_strtol(buf, NULL, 10); \<br>
&gt; + =A0 =A0 long val; \<br>
&gt; + =A0 =A0 int err =3D kstrtol(buf, 10, &amp;val); \<br>
&gt; + =A0 =A0 if (err &lt; 0) \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return err; \<br>
&gt; =A0\<br>
&gt; =A0 =A0 =A0 mutex_lock(&amp;data-&gt;update_lock);\<br>
&gt; =A0 =A0 =A0 data-&gt;value[nr] =3D IN_TO_REG(val); \<br>
&gt; @@ -226,7 +229,10 @@ static ssize_t set_fan_min(struct device *dev, st=
ruct device_attribute *attr,<br>
&gt; =A0 =A0 =A0 int nr =3D to_sensor_dev_attr(attr)-&gt;index;<br>
&gt; =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);<br>
&gt; =A0 =A0 =A0 struct lm80_data *data =3D i2c_get_clientdata(client);<br>
&gt; - =A0 =A0 long val =3D simple_strtoul(buf, NULL, 10);<br>
&gt; + =A0 =A0 long val;<br>
&gt; + =A0 =A0 int err =3D kstrtol(buf, 10, &amp;val);<br>
&gt; + =A0 =A0 if (err &lt; 0)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return err;<br>
&gt;<br>
</div></div>You replaced simple_strtoul() with kstrtol(). Should have been =
unsigned<br>
long and kstrtoul(). No need to resubmit, I fixed that. Queued for -rc2.<br=
>
<br>
Thanks,<br>
Guenter<br></blockquote><div><br>Hi=A0 Guenter, <br><br>The change was on t=
wo places and intentional.<br><br>The original code reads:<br>long val =3D =
simple_strtoul(buf, NULL, 10);<br>I feel this is a flaw and that simple_str=
tol should have been used here (and eventually kstrtol.<br>
(or alternately the variable should have been an unsigned long)<br><br>(and=
 yes, I agree that this should have been made explicit in the commit messag=
e).<br><br>Can you revert your fix on both places (and probably add a line =
or two to the commit message)<br>
<br>Thanks. Frans.<br><br></div></div><br>

--14dae9cc96885029ba04b630fcb1--


--===============4401596151077528038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4401596151077528038==--
