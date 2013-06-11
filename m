From: Robert Coulson <rob.coulson@gmail.com>
Date: Tue, 11 Jun 2013 01:58:27 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ds1621) Add ds1721 update interval sysfs attribute
Message-Id: <CAEZKy8Jw4sn6x8+Fub+eCCtEEmD7YEJ3tMSF8j0DCdq-JTAbKA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3865882577799777282=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1370897417-28903-1-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1370897417-28903-1-git-send-email-rob.coulson@gmail.com>
To: lm-sensors@vger.kernel.org

--===============3865882577799777282==
Content-Type: multipart/alternative; boundary=089e0116007ab5484204ded73b9c

--089e0116007ab5484204ded73b9c
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jun 10, 2013 at 6:48 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Mon, Jun 10, 2013 at 01:50:17PM -0700, Robert Coulson wrote:
> > The ds1721 device can be configured for 9..12 bit resolutions;
> > add a sysfs attribute for userspace to configure this attribute.
> > The definition, description, details, and usage are shown in the
> > documentation and were crafted from an LM73 driver patch done by
> > Chris Verges & Guenter Roeck).
> >
> > Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
> > ---
> >
> Appled.
>
> Thanks,
> Guenter
>

s/Appled/Applied ;-)

thank you Guenter, I appreciate it.

Rob.


>
> > v2 - removes unused devattr variable reported by Jean Delvare.
> >
> >  Documentation/hwmon/ds1621 |   65
> ++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/hwmon/ds1621.c     |   56 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 121 insertions(+)
> >
> > diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
> > index ee7bc01..ae29036 100644
> > --- a/Documentation/hwmon/ds1621
> > +++ b/Documentation/hwmon/ds1621
> > @@ -75,3 +75,68 @@ The DS1721 is pin compatible with the DS1621, has an
> accuracy of +/- 1.0
> >  degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
> >  default setting of 75 and 80 degrees respectifully, and a maximum
> conversion
> >  time of 750ms.
> > +
> > +In addition, the DS1721 supports four resolution settings from 9 to 12
> bits
> > +(defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625,
> respectifully),
> > +that are set at device power on to the highest resolution: 12-bits
> (0.0625 degree C).
> > +
> > +Changing the DS1721 resolution mode affects the conversion time and can
> be
> > +done from userspace, via the device 'update_interval' sysfs attribute.
> This
> > +attribute will normalize range of input values to the device maximum
> resolution
> > +values defined in the datasheet as such:
> > +
> > +Resolution    Conversion Time    Input Range
> > + (C/LSB)       (msec)             (msec)
> > +--------------------------------------------
> > +0.5             93.75              0....94
> > +0.25            187.5              95...187
> > +0.125           375                188..375
> > +0.0625          750                376..infinity
> > +--------------------------------------
> > +
> > +The following examples show how the 'update_interval' attribute can be
> > +used to change the conversion time:
> > +
> > +$ cat update_interval
> > +750
> > +$ cat temp1_input
> > +22062
> > +$
> > +$ echo 300 > update_interval
> > +$ cat update_interval
> > +375
> > +$ cat temp1_input
> > +22125
> > +$
> > +$ echo 150 > update_interval
> > +$ cat update_interval
> > +188
> > +$ cat temp1_input
> > +22250
> > +$
> > +$ echo 1 > update_interval
> > +$ cat update_interval
> > +94
> > +$ cat temp1_input
> > +22000
> > +$
> > +$ echo 1000 > update_interval
> > +$ cat update_interval
> > +750
> > +$ cat temp1_input
> > +22062
> > +$
> > +
> > +As shown, the ds1621 driver automatically adjusts the 'update_interval'
> > +user input, via a step function. Reading back the 'update_interval'
> value
> > +after a write operation provides the conversion time used by the device.
> > +
> > +Mathematically, the resolution can be derived from the conversion time
> > +via the following function:
> > +
> > +   g(x) = 0.5 * [minimum_conversion_time/x]
> > +
> > +where:
> > + -> 'x' = the output from 'update_interval'
> > + -> 'g(x)' = the resolution in degrees C per LSB.
> > + -> 93.75ms = minimum conversion time
> > diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
> > index 04a3b12..763de4c 100644
> > --- a/drivers/hwmon/ds1621.c
> > +++ b/drivers/hwmon/ds1621.c
> > @@ -274,7 +274,47 @@ static ssize_t show_alarm(struct device *dev,
> struct device_attribute *da,
> >       return sprintf(buf, "%d\n", !!(data->conf & attr->index));
> >  }
> >
> > +static ssize_t show_convrate(struct device *dev, struct
> device_attribute *da,
> > +                       char *buf)
> > +{
> > +     struct i2c_client *client = to_i2c_client(dev);
> > +     struct ds1621_data *data = i2c_get_clientdata(client);
> > +     return scnprintf(buf, PAGE_SIZE, "%hu\n", data->update_interval);
> > +}
> > +
> > +static ssize_t set_convrate(struct device *dev, struct device_attribute
> *da,
> > +                         const char *buf, size_t count)
> > +{
> > +     struct i2c_client *client = to_i2c_client(dev);
> > +     struct ds1621_data *data = i2c_get_clientdata(client);
> > +     unsigned long convrate;
> > +     s32 err;
> > +     int resol = 0;
> > +
> > +     err = kstrtoul(buf, 10, &convrate);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Convert rate into resolution bits */
> > +     while (resol < (ARRAY_SIZE(ds1721_convrates) - 1) &&
> > +            convrate > ds1721_convrates[resol])
> > +             resol++;
> > +
> > +     mutex_lock(&data->update_lock);
> > +     data->conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
> > +     data->conf &= ~DS1621_REG_CONFIG_RESOL;
> > +     data->conf |= (resol << DS1621_REG_CONFIG_RESOL_SHIFT);
> > +     i2c_smbus_write_byte_data(client, DS1621_REG_CONF, data->conf);
> > +     data->update_interval = ds1721_convrates[resol];
> > +     mutex_unlock(&data->update_lock);
> > +
> > +     return count;
> > +}
> > +
> >  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> > +static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_convrate,
> > +                set_convrate);
> > +
> >  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> >  static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp,
> set_temp, 1);
> >  static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp,
> set_temp, 2);
> > @@ -290,11 +330,27 @@ static struct attribute *ds1621_attributes[] = {
> >       &sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> >       &sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> >       &dev_attr_alarms.attr,
> > +     &dev_attr_update_interval.attr,
> >       NULL
> >  };
> >
> > +static umode_t ds1621_attribute_visible(struct kobject *kobj,
> > +                                     struct attribute *attr, int index)
> > +{
> > +     struct device *dev = container_of(kobj, struct device, kobj);
> > +     struct i2c_client *client = to_i2c_client(dev);
> > +     struct ds1621_data *data = i2c_get_clientdata(client);
> > +
> > +     if (attr == &dev_attr_update_interval.attr)
> > +             if (data->kind != ds1721)
> > +                     /* shhh, we're hiding update_interval */
> > +                     return 0;
> > +     return attr->mode;
> > +}
> > +
> >  static const struct attribute_group ds1621_group = {
> >       .attrs = ds1621_attributes,
> > +     .is_visible = ds1621_attribute_visible
> >  };
> >
> >
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

--089e0116007ab5484204ded73b9c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Jun 10, 2013 at 6:48 PM, Guenter Roeck <span dir=3D"ltr">&l=
t;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.ne=
t</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Mon, Jun 10, 2013 at 01=
:50:17PM -0700, Robert Coulson wrote:<br>
&gt; The ds1721 device can be configured for 9..12 bit resolutions;<br>
&gt; add a sysfs attribute for userspace to configure this attribute.<br>
&gt; The definition, description, details, and usage are shown in the<br>
&gt; documentation and were crafted from an LM73 driver patch done by<br>
&gt; Chris Verges &amp; Guenter Roeck).<br>
&gt;<br>
&gt; Signed-off-by: Robert Coulson &lt;<a href=3D"mailto:rob.coulson@gmail.=
com">rob.coulson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;<br>
</div>Appled.<br>
<br>
Thanks,<br>
Guenter<br></blockquote><div><br></div><div style>s/Appled/Applied ;-)</div=
><div style><br></div><div style>thank you Guenter, I appreciate it.</div><=
div style><br></div><div style>Rob.</div><div style>=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">

<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; v2 - removes unused devattr variable reported by Jean Delvare.<br>
&gt;<br>
&gt; =A0Documentation/hwmon/ds1621 | =A0 65 +++++++++++++++++++++++++++++++=
+++++++++++++<br>
&gt; =A0drivers/hwmon/ds1621.c =A0 =A0 | =A0 56 +++++++++++++++++++++++++++=
+++++++++++<br>
&gt; =A02 files changed, 121 insertions(+)<br>
&gt;<br>
&gt; diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621<b=
r>
&gt; index ee7bc01..ae29036 100644<br>
&gt; --- a/Documentation/hwmon/ds1621<br>
&gt; +++ b/Documentation/hwmon/ds1621<br>
&gt; @@ -75,3 +75,68 @@ The DS1721 is pin compatible with the DS1621, has a=
n accuracy of +/- 1.0<br>
&gt; =A0degree Celius over a -10 to +85 degree range, a minimum/maximum ala=
rm<br>
&gt; =A0default setting of 75 and 80 degrees respectifully, and a maximum c=
onversion<br>
&gt; =A0time of 750ms.<br>
&gt; +<br>
&gt; +In addition, the DS1721 supports four resolution settings from 9 to 1=
2 bits<br>
&gt; +(defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625, respecti=
fully),<br>
&gt; +that are set at device power on to the highest resolution: 12-bits (0=
.0625 degree C).<br>
&gt; +<br>
&gt; +Changing the DS1721 resolution mode affects the conversion time and c=
an be<br>
&gt; +done from userspace, via the device &#39;update_interval&#39; sysfs a=
ttribute. This<br>
&gt; +attribute will normalize range of input values to the device maximum =
resolution<br>
&gt; +values defined in the datasheet as such:<br>
&gt; +<br>
&gt; +Resolution =A0 =A0Conversion Time =A0 =A0Input Range<br>
&gt; + (C/LSB) =A0 =A0 =A0 (msec) =A0 =A0 =A0 =A0 =A0 =A0 (msec)<br>
&gt; +--------------------------------------------<br>
&gt; +0.5 =A0 =A0 =A0 =A0 =A0 =A0 93.75 =A0 =A0 =A0 =A0 =A0 =A0 =A00....94<=
br>
&gt; +0.25 =A0 =A0 =A0 =A0 =A0 =A0187.5 =A0 =A0 =A0 =A0 =A0 =A0 =A095...187=
<br>
&gt; +0.125 =A0 =A0 =A0 =A0 =A0 375 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0188..375=
<br>
&gt; +0.0625 =A0 =A0 =A0 =A0 =A0750 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0376..inf=
inity<br>
&gt; +--------------------------------------<br>
&gt; +<br>
&gt; +The following examples show how the &#39;update_interval&#39; attribu=
te can be<br>
&gt; +used to change the conversion time:<br>
&gt; +<br>
&gt; +$ cat update_interval<br>
&gt; +750<br>
&gt; +$ cat temp1_input<br>
&gt; +22062<br>
&gt; +$<br>
&gt; +$ echo 300 &gt; update_interval<br>
&gt; +$ cat update_interval<br>
&gt; +375<br>
&gt; +$ cat temp1_input<br>
&gt; +22125<br>
&gt; +$<br>
&gt; +$ echo 150 &gt; update_interval<br>
&gt; +$ cat update_interval<br>
&gt; +188<br>
&gt; +$ cat temp1_input<br>
&gt; +22250<br>
&gt; +$<br>
&gt; +$ echo 1 &gt; update_interval<br>
&gt; +$ cat update_interval<br>
&gt; +94<br>
&gt; +$ cat temp1_input<br>
&gt; +22000<br>
&gt; +$<br>
&gt; +$ echo 1000 &gt; update_interval<br>
&gt; +$ cat update_interval<br>
&gt; +750<br>
&gt; +$ cat temp1_input<br>
&gt; +22062<br>
&gt; +$<br>
&gt; +<br>
&gt; +As shown, the ds1621 driver automatically adjusts the &#39;update_int=
erval&#39;<br>
&gt; +user input, via a step function. Reading back the &#39;update_interva=
l&#39; value<br>
&gt; +after a write operation provides the conversion time used by the devi=
ce.<br>
&gt; +<br>
&gt; +Mathematically, the resolution can be derived from the conversion tim=
e<br>
&gt; +via the following function:<br>
&gt; +<br>
&gt; + =A0 g(x) =3D 0.5 * [minimum_conversion_time/x]<br>
&gt; +<br>
&gt; +where:<br>
&gt; + -&gt; &#39;x&#39; =3D the output from &#39;update_interval&#39;<br>
&gt; + -&gt; &#39;g(x)&#39; =3D the resolution in degrees C per LSB.<br>
&gt; + -&gt; 93.75ms =3D minimum conversion time<br>
&gt; diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c<br>
&gt; index 04a3b12..763de4c 100644<br>
&gt; --- a/drivers/hwmon/ds1621.c<br>
&gt; +++ b/drivers/hwmon/ds1621.c<br>
&gt; @@ -274,7 +274,47 @@ static ssize_t show_alarm(struct device *dev, str=
uct device_attribute *da,<br>
&gt; =A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, !!(data-&gt;conf &am=
p; attr-&gt;index));<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static ssize_t show_convrate(struct device *dev, struct device_attrib=
ute *da,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);<br>
&gt; + =A0 =A0 struct ds1621_data *data =3D i2c_get_clientdata(client);<br>
&gt; + =A0 =A0 return scnprintf(buf, PAGE_SIZE, &quot;%hu\n&quot;, data-&gt=
;update_interval);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t set_convrate(struct device *dev, struct device_attribu=
te *da,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, siz=
e_t count)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);<br>
&gt; + =A0 =A0 struct ds1621_data *data =3D i2c_get_clientdata(client);<br>
&gt; + =A0 =A0 unsigned long convrate;<br>
&gt; + =A0 =A0 s32 err;<br>
&gt; + =A0 =A0 int resol =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0 err =3D kstrtoul(buf, 10, &amp;convrate);<br>
&gt; + =A0 =A0 if (err)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return err;<br>
&gt; +<br>
&gt; + =A0 =A0 /* Convert rate into resolution bits */<br>
&gt; + =A0 =A0 while (resol &lt; (ARRAY_SIZE(ds1721_convrates) - 1) &amp;&a=
mp;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0convrate &gt; ds1721_convrates[resol])<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 resol++;<br>
&gt; +<br>
&gt; + =A0 =A0 mutex_lock(&amp;data-&gt;update_lock);<br>
&gt; + =A0 =A0 data-&gt;conf =3D i2c_smbus_read_byte_data(client, DS1621_RE=
G_CONF);<br>
&gt; + =A0 =A0 data-&gt;conf &amp;=3D ~DS1621_REG_CONFIG_RESOL;<br>
&gt; + =A0 =A0 data-&gt;conf |=3D (resol &lt;&lt; DS1621_REG_CONFIG_RESOL_S=
HIFT);<br>
&gt; + =A0 =A0 i2c_smbus_write_byte_data(client, DS1621_REG_CONF, data-&gt;=
conf);<br>
&gt; + =A0 =A0 data-&gt;update_interval =3D ds1721_convrates[resol];<br>
&gt; + =A0 =A0 mutex_unlock(&amp;data-&gt;update_lock);<br>
&gt; +<br>
&gt; + =A0 =A0 return count;<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);<br>
&gt; +static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_convrate,=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_convrate);<br>
&gt; +<br>
&gt; =A0static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0)=
;<br>
&gt; =A0static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, =
set_temp, 1);<br>
&gt; =A0static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, =
set_temp, 2);<br>
&gt; @@ -290,11 +330,27 @@ static struct attribute *ds1621_attributes[] =3D=
 {<br>
&gt; =A0 =A0 =A0 &amp;sensor_dev_attr_temp1_min_alarm.dev_attr.attr,<br>
&gt; =A0 =A0 =A0 &amp;sensor_dev_attr_temp1_max_alarm.dev_attr.attr,<br>
&gt; =A0 =A0 =A0 &amp;dev_attr_alarms.attr,<br>
&gt; + =A0 =A0 &amp;dev_attr_update_interval.attr,<br>
&gt; =A0 =A0 =A0 NULL<br>
&gt; =A0};<br>
&gt;<br>
&gt; +static umode_t ds1621_attribute_visible(struct kobject *kobj,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct attribute *attr, int index)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct device *dev =3D container_of(kobj, struct device, kob=
j);<br>
&gt; + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);<br>
&gt; + =A0 =A0 struct ds1621_data *data =3D i2c_get_clientdata(client);<br>
&gt; +<br>
&gt; + =A0 =A0 if (attr =3D=3D &amp;dev_attr_update_interval.attr)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (data-&gt;kind !=3D ds1721)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* shhh, we&#39;re hiding up=
date_interval */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt; + =A0 =A0 return attr-&gt;mode;<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static const struct attribute_group ds1621_group =3D {<br>
&gt; =A0 =A0 =A0 .attrs =3D ds1621_attributes,<br>
&gt; + =A0 =A0 .is_visible =3D ds1621_attribute_visible<br>
&gt; =A0};<br>
&gt;<br>
&gt;<br>
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

--089e0116007ab5484204ded73b9c--


--===============3865882577799777282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3865882577799777282==--
