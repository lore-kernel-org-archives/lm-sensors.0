From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 10 Jan 2012 19:43:56 +0000
Subject: [lm-sensors]  [PATCH 1/2] hwmon: (lm80) fixed checkpatch errors
Message-Id: <CACW_hTb9YRbLs-7vfqyVJChogExsR1jW8oPsya16pE_kNLuh9Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3845381053897536293=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1326206976-7846-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326206976-7846-1-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============3845381053897536293==
Content-Type: multipart/alternative; boundary=20cf30780d1a62408404b631bcc9

--20cf30780d1a62408404b631bcc9
Content-Type: text/plain; charset=ISO-8859-1

Oops, forgot to cc the list.

---------- Forwarded message ----------
From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: 2012/1/10
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm80) fixed checkpatch errors
To: guenter.roeck@ericsson.com




2012/1/10 Guenter Roeck <guenter.roeck@ericsson.com>

> On Tue, 2012-01-10 at 13:50 -0500, Frans Meulenbroeks wrote:
> >
> >
> > 2012/1/10 Guenter Roeck <guenter.roeck@ericsson.com>
> >         Hi Frans,
> >
> >         On Tue, 2012-01-10 at 09:49 -0500, Frans Meulenbroeks wrote:
> >         > fixed:
> >         > WARNING: simple_strtol is obsolete, use kstrtol instead
> >         > WARNING: simple_strtoul is obsolete, use kstrtoul instead
> >         >
> >         > Signed-off-by: Frans Meulenbroeks
> >         <fransmeulenbroeks@gmail.com>
> >         > ---
> >         >  drivers/hwmon/lm80.c |   20 ++++++++++++++++----
> >         >  1 files changed, 16 insertions(+), 4 deletions(-)
> >         >
> >         > diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> >         > index 616f470..18e5ea4 100644
> >         > --- a/drivers/hwmon/lm80.c
> >         > +++ b/drivers/hwmon/lm80.c
> >         > @@ -185,7 +185,10 @@ static ssize_t set_in_##suffix(struct
> >         device *dev, \
> >         >       int nr = to_sensor_dev_attr(attr)->index; \
> >         >       struct i2c_client *client = to_i2c_client(dev); \
> >         >       struct lm80_data *data = i2c_get_clientdata(client); \
> >         > -     long val = simple_strtol(buf, NULL, 10); \
> >         > +     long val; \
> >         > +     int err = kstrtol(buf, 10, &val); \
> >         > +     if (err < 0) \
> >         > +             return err; \
> >         >  \
> >         >       mutex_lock(&data->update_lock);\
> >         >       data->value[nr] = IN_TO_REG(val); \
> >         > @@ -226,7 +229,10 @@ static ssize_t set_fan_min(struct
> >         device *dev, struct device_attribute *attr,
> >         >       int nr = to_sensor_dev_attr(attr)->index;
> >         >       struct i2c_client *client = to_i2c_client(dev);
> >         >       struct lm80_data *data = i2c_get_clientdata(client);
> >         > -     long val = simple_strtoul(buf, NULL, 10);
> >         > +     long val;
> >         > +     int err = kstrtol(buf, 10, &val);
> >         > +     if (err < 0)
> >         > +             return err;
> >         >
> >
> >         You replaced simple_strtoul() with kstrtol(). Should have been
> >         unsigned
> >         long and kstrtoul(). No need to resubmit, I fixed that. Queued
> >         for -rc2.
> >
> >         Thanks,
> >         Guenter
> >
> > Hi  Guenter,
> >
> > The change was on two places and intentional.
> >
> > The original code reads:
> > long val = simple_strtoul(buf, NULL, 10);
> > I feel this is a flaw and that simple_strtol should have been used
> > here (and eventually kstrtol.
> > (or alternately the variable should have been an unsigned long)
> >
> Frans,
>
> I am lost. Why, and what do you think is the flaw ? You said yourself in
> the other thread that negative values don't make sense here. Why do you
> want to successfully parse negative values if they are not supported.?
>
> I'll drop the two patches for now until that is resolved.
>
>
> Hi Guenter,

Actually I misread your original email.

You wrote:
>
>         You replaced simple_strtoul() with kstrtol(). Should have been
>         unsigned
>         long and kstrtoul(). No need to resubmit, I fixed that. Queued

Actually I overlooked that you changed long to unsigned long too.
That is also why I wrote:

> (or alternately the variable should have been an unsigned long)

I just had the impression that you only changed simple_strol into kstrtoul
without changing the var.

Your change to kstrtoul and changing val to unsigned long at the same time
is of course ok.

Apologies for the confusion caused.
Please apply with your fixes.

As penitentiary I'll resolve the checkpatch errors in a drivers/hwmon file
of your choice :-)

Best regards, Frans

--20cf30780d1a62408404b631bcc9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Oops, forgot to cc the list.<br><br><div class=3D"gmail_quote">---------- F=
orwarded message ----------<br>From: <b class=3D"gmail_sendername">Frans Me=
ulenbroeks</b> <span dir=3D"ltr">&lt;<a href=3D"mailto:fransmeulenbroeks@gm=
ail.com">fransmeulenbroeks@gmail.com</a>&gt;</span><br>
Date: 2012/1/10<br>Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm80) fixe=
d checkpatch errors<br>To: <a href=3D"mailto:guenter.roeck@ericsson.com">gu=
enter.roeck@ericsson.com</a><br><br><br><br><br><div class=3D"gmail_quote">
<div><div class=3D"h5">2012/1/10 Guenter Roeck <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:guenter.roeck@ericsson.com" target=3D"_blank">guenter.roeck@eri=
csson.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div><div>On Tue, 2012-01-10 at 13:50 -0500, Frans Meulenbroeks wrote:<br>
&gt;<br>
&gt;<br>
&gt; 2012/1/10 Guenter Roeck &lt;<a href=3D"mailto:guenter.roeck@ericsson.c=
om" target=3D"_blank">guenter.roeck@ericsson.com</a>&gt;<br>
&gt; =A0 =A0 =A0 =A0 Hi Frans,<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 On Tue, 2012-01-10 at 09:49 -0500, Frans Meulenbroeks =
wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; fixed:<br>
&gt; =A0 =A0 =A0 =A0 &gt; WARNING: simple_strtol is obsolete, use kstrtol i=
nstead<br>
&gt; =A0 =A0 =A0 =A0 &gt; WARNING: simple_strtoul is obsolete, use kstrtoul=
 instead<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Signed-off-by: Frans Meulenbroeks<br>
&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:fransmeulenbroeks@gmail.com" tar=
get=3D"_blank">fransmeulenbroeks@gmail.com</a>&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; ---<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0drivers/hwmon/lm80.c | =A0 20 ++++++++++++++++=
----<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A01 files changed, 16 insertions(+), 4 deletions=
(-)<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon=
/lm80.c<br>
&gt; =A0 =A0 =A0 =A0 &gt; index 616f470..18e5ea4 100644<br>
&gt; =A0 =A0 =A0 =A0 &gt; --- a/drivers/hwmon/lm80.c<br>
&gt; =A0 =A0 =A0 =A0 &gt; +++ b/drivers/hwmon/lm80.c<br>
&gt; =A0 =A0 =A0 =A0 &gt; @@ -185,7 +185,10 @@ static ssize_t set_in_##suff=
ix(struct<br>
&gt; =A0 =A0 =A0 =A0 device *dev, \<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 int nr =3D to_sensor_dev_attr(attr)-&=
gt;index; \<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_=
client(dev); \<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 struct lm80_data *data =3D i2c_get_cl=
ientdata(client); \<br>
&gt; =A0 =A0 =A0 =A0 &gt; - =A0 =A0 long val =3D simple_strtol(buf, NULL, 1=
0); \<br>
&gt; =A0 =A0 =A0 =A0 &gt; + =A0 =A0 long val; \<br>
&gt; =A0 =A0 =A0 =A0 &gt; + =A0 =A0 int err =3D kstrtol(buf, 10, &amp;val);=
 \<br>
&gt; =A0 =A0 =A0 =A0 &gt; + =A0 =A0 if (err &lt; 0) \<br>
&gt; =A0 =A0 =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 return err; \<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0\<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 mutex_lock(&amp;data-&gt;update_lock)=
;\<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 data-&gt;value[nr] =3D IN_TO_REG(val)=
; \<br>
&gt; =A0 =A0 =A0 =A0 &gt; @@ -226,7 +229,10 @@ static ssize_t set_fan_min(s=
truct<br>
&gt; =A0 =A0 =A0 =A0 device *dev, struct device_attribute *attr,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 int nr =3D to_sensor_dev_attr(attr)-&=
gt;index;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_=
client(dev);<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 struct lm80_data *data =3D i2c_get_cl=
ientdata(client);<br>
&gt; =A0 =A0 =A0 =A0 &gt; - =A0 =A0 long val =3D simple_strtoul(buf, NULL, =
10);<br>
&gt; =A0 =A0 =A0 =A0 &gt; + =A0 =A0 long val;<br>
&gt; =A0 =A0 =A0 =A0 &gt; + =A0 =A0 int err =3D kstrtol(buf, 10, &amp;val);=
<br>
&gt; =A0 =A0 =A0 =A0 &gt; + =A0 =A0 if (err &lt; 0)<br>
&gt; =A0 =A0 =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 return err;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 You replaced simple_strtoul() with kstrtol(). Should h=
ave been<br>
&gt; =A0 =A0 =A0 =A0 unsigned<br>
&gt; =A0 =A0 =A0 =A0 long and kstrtoul(). No need to resubmit, I fixed that=
. Queued<br>
&gt; =A0 =A0 =A0 =A0 for -rc2.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Thanks,<br>
&gt; =A0 =A0 =A0 =A0 Guenter<br>
&gt;<br>
&gt; Hi =A0Guenter,<br>
&gt;<br>
&gt; The change was on two places and intentional.<br>
&gt;<br>
&gt; The original code reads:<br>
&gt; long val =3D simple_strtoul(buf, NULL, 10);<br>
&gt; I feel this is a flaw and that simple_strtol should have been used<br>
&gt; here (and eventually kstrtol.<br>
&gt; (or alternately the variable should have been an unsigned long)<br>
&gt;<br>
</div></div>Frans,<br>
<br>
I am lost. Why, and what do you think is the flaw ? You said yourself in<br=
>
the other thread that negative values don&#39;t make sense here. Why do you=
<br>
want to successfully parse negative values if they are not supported.?<br>
<br>
I&#39;ll drop the two patches for now until that is resolved.<br>
<span><font color=3D"#888888"><br>
<br></font></span></blockquote></div></div><div>Hi Guenter,<br><br>Actually=
 I misread your original email.<div class=3D"im"><br>You wrote:<br>&gt;<br>
&gt; =A0 =A0 =A0 =A0 You replaced simple_strtoul() with kstrtol(). Should h=
ave been<br>
&gt; =A0 =A0 =A0 =A0 unsigned<br>
&gt; =A0 =A0 =A0 =A0 long and kstrtoul(). No need to resubmit, I fixed that=
. Queued<br><br></div>Actually I overlooked that you changed long to unsign=
ed long too. <br><div class=3D"im">That is also why I wrote:<br><br>
&gt; (or alternately the variable should have been an unsigned long)<br><br=
></div>I just had the impression that you only changed simple_strol into ks=
trtoul without changing the var.<br><br>Your change to kstrtoul and changin=
g val to unsigned long at the same time is of course ok.<br>

<br>Apologies for the confusion caused. <br>Please apply with your fixes.<b=
r><br>As penitentiary I&#39;ll resolve the checkpatch errors in a drivers/h=
wmon file of your choice :-)<br><br>Best regards, Frans<br><br></div></div>

<br>
</div><br>

--20cf30780d1a62408404b631bcc9--


--===============3845381053897536293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3845381053897536293==--
