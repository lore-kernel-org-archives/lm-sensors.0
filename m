From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 06 Jun 2013 14:56:42 +0000
Subject: Re: [lm-sensors] [lm-sensors 2/2] hwmon: (ds1621) Add ds1721 update interval sysfs attribute
Message-Id: <CAEZKy8JbSmwNbTqgxbXfoj8hghar2U6+SF3T0Ws90SoeL4Q9Gg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4135948639500800378=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1368078354-26298-3-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1368078354-26298-3-git-send-email-rob.coulson@gmail.com>
To: lm-sensors@vger.kernel.org

--===============4135948639500800378==
Content-Type: multipart/alternative; boundary=089e0102f5bebaeaf704de7d853e

--089e0102f5bebaeaf704de7d853e
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jun 6, 2013 at 4:41 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Jun 06, 2013 at 09:48:11AM +0200, Jean Delvare wrote:
> > Hi Robert, hi Guenter,
> >
> > Sorry for joining the game a little late...
> >
> > On Wed, 8 May 2013 22:45:54 -0700, Robert Coulson wrote:
> > > +static umode_t ds1621_attribute_visible(struct kobject *kobj,
> > > +                                   struct attribute *attr, int index)
> > > +{
> > > +   struct device *dev = container_of(kobj, struct device, kobj);
> > > +   struct i2c_client *client = to_i2c_client(dev);
> > > +   struct ds1621_data *data = i2c_get_clientdata(client);
> > > +   struct device_attribute *devattr;
> > > +
> > > +   devattr = container_of(attr, struct device_attribute, attr);
> > > +   if (attr == &dev_attr_update_interval.attr)
> > > +           if (data->kind != ds1721)
> > > +                   /* shhh, we're hiding update_interval */
> > > +                   return 0;
> > > +   return attr->mode;
> > > +}
> >
> > "make W=1" complains that devattr is defined but never used. And this is
> > true, and should be fixed.
> >
> I'll take care of it.
>
> Guenter
>

Thank you for catching it Jean, I appreciate it.

My apologies for missing it Guenter; Now that I am back, I can take care of
it this morning.

Rob

--089e0102f5bebaeaf704de7d853e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Thu, Jun 6, 2013 at 4:41 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=
=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, Jun 06, 2013 at 09:48:11AM +0200, Jean Delvare wrote:<br>
&gt; Hi Robert, hi Guenter,<br>
&gt;<br>
&gt; Sorry for joining the game a little late...<br>
&gt;<br>
&gt; On Wed, 8 May 2013 22:45:54 -0700, Robert Coulson wrote:<br>
&gt; &gt; +static umode_t ds1621_attribute_visible(struct kobject *kobj,<br=
>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct attribute *attr, int index)<br>
&gt; &gt; +{<br>
&gt; &gt; + =A0 struct device *dev =3D container_of(kobj, struct device, ko=
bj);<br>
&gt; &gt; + =A0 struct i2c_client *client =3D to_i2c_client(dev);<br>
&gt; &gt; + =A0 struct ds1621_data *data =3D i2c_get_clientdata(client);<br=
>
&gt; &gt; + =A0 struct device_attribute *devattr;<br>
&gt; &gt; +<br>
&gt; &gt; + =A0 devattr =3D container_of(attr, struct device_attribute, att=
r);<br>
&gt; &gt; + =A0 if (attr =3D=3D &amp;dev_attr_update_interval.attr)<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 if (data-&gt;kind !=3D ds1721)<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* shhh, we&#39;re hiding u=
pdate_interval */<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt; &gt; + =A0 return attr-&gt;mode;<br>
&gt; &gt; +}<br>
&gt;<br>
&gt; &quot;make W=3D1&quot; complains that devattr is defined but never use=
d. And this is<br>
&gt; true, and should be fixed.<br>
&gt;<br>
</div></div>I&#39;ll take care of it.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br></font></span></blockquote><div><br></div><div style>Thank you f=
or catching it Jean, I appreciate it.</div><div style><br></div><div style>=
My apologies for missing it Guenter; Now that I am back, I can take care of=
 it this morning.</div>
<div style><br></div><div style>Rob</div></div><br></div></div>

--089e0102f5bebaeaf704de7d853e--


--===============4135948639500800378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4135948639500800378==--
