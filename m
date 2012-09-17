From: Paul Thomas <pthomas8589@gmail.com>
Date: Mon, 17 Sep 2012 20:52:21 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (ads7871) Add 'name' sysfs attribute
Message-Id: <CAD56B7d40PS6PTTYaik41bH8ds9gfLex2PFzo_FhCQUebdnzNw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6173024930701004436=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1347396773-32108-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347396773-32108-3-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org

--===============6173024930701004436==
Content-Type: multipart/alternative; boundary=00151747bd823525b204c9ebf32b

--00151747bd823525b204c9ebf32b
Content-Type: text/plain; charset=ISO-8859-1

Acked-by: Paul Thomas <pthomas8589@gmail.com>

On Tue, Sep 11, 2012 at 1:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> The 'name' sysfs attribute is mandatory for hwmon devices, but was missing
> in this driver.
>
> Cc: Paul Thomas <pthomas8589@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Candidate for -stable
>
>  drivers/hwmon/ads7871.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
> index e837707..1b53aa4 100644
> --- a/drivers/hwmon/ads7871.c
> +++ b/drivers/hwmon/ads7871.c
> @@ -139,6 +139,12 @@ static ssize_t show_voltage(struct device *dev,
>         }
>  }
>
> +static ssize_t ads7871_show_name(struct device *dev,
> +                                struct device_attribute *devattr, char
> *buf)
> +{
> +       return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
> +}
> +
>  static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_voltage, NULL, 0);
>  static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_voltage, NULL, 1);
>  static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_voltage, NULL, 2);
> @@ -148,6 +154,8 @@ static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO,
> show_voltage, NULL, 5);
>  static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_voltage, NULL, 6);
>  static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_voltage, NULL, 7);
>
> +static DEVICE_ATTR(name, S_IRUGO, ads7871_show_name, NULL);
> +
>  static struct attribute *ads7871_attributes[] = {
>         &sensor_dev_attr_in0_input.dev_attr.attr,
>         &sensor_dev_attr_in1_input.dev_attr.attr,
> @@ -157,6 +165,7 @@ static struct attribute *ads7871_attributes[] = {
>         &sensor_dev_attr_in5_input.dev_attr.attr,
>         &sensor_dev_attr_in6_input.dev_attr.attr,
>         &sensor_dev_attr_in7_input.dev_attr.attr,
> +       &dev_attr_name.attr,
>         NULL
>  };
>
> --
> 1.7.9.7
>
>

--00151747bd823525b204c9ebf32b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Acked-by: Paul Thomas &lt;<a href=3D"mailto:pthomas8589@gmail.com">pthomas8=
589@gmail.com</a>&gt;<br><br><div class=3D"gmail_quote">On Tue, Sep 11, 201=
2 at 1:52 PM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@r=
oeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">The &#39;name&#39; sysfs attribute is mandat=
ory for hwmon devices, but was missing<br>
in this driver.<br>
<br>
Cc: Paul Thomas &lt;<a href=3D"mailto:pthomas8589@gmail.com">pthomas8589@gm=
ail.com</a>&gt;<br>
Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net">linu=
x@roeck-us.net</a>&gt;<br>
---<br>
Candidate for -stable<br>
<br>
=A0drivers/hwmon/ads7871.c | =A0 =A09 +++++++++<br>
=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c<br>
index e837707..1b53aa4 100644<br>
--- a/drivers/hwmon/ads7871.c<br>
+++ b/drivers/hwmon/ads7871.c<br>
@@ -139,6 +139,12 @@ static ssize_t show_voltage(struct device *dev,<br>
=A0 =A0 =A0 =A0 }<br>
=A0}<br>
<br>
+static ssize_t ads7871_show_name(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct dev=
ice_attribute *devattr, char *buf)<br>
+{<br>
+ =A0 =A0 =A0 return sprintf(buf, &quot;%s\n&quot;, to_spi_device(dev)-&gt;=
modalias);<br>
+}<br>
+<br>
=A0static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_voltage, NULL, 0);<br=
>
=A0static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_voltage, NULL, 1);<br=
>
=A0static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_voltage, NULL, 2);<br=
>
@@ -148,6 +154,8 @@ static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_volt=
age, NULL, 5);<br>
=A0static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_voltage, NULL, 6);<br=
>
=A0static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_voltage, NULL, 7);<br=
>
<br>
+static DEVICE_ATTR(name, S_IRUGO, ads7871_show_name, NULL);<br>
+<br>
=A0static struct attribute *ads7871_attributes[] =3D {<br>
=A0 =A0 =A0 =A0 &amp;sensor_dev_attr_in0_input.dev_attr.attr,<br>
=A0 =A0 =A0 =A0 &amp;sensor_dev_attr_in1_input.dev_attr.attr,<br>
@@ -157,6 +165,7 @@ static struct attribute *ads7871_attributes[] =3D {<br>
=A0 =A0 =A0 =A0 &amp;sensor_dev_attr_in5_input.dev_attr.attr,<br>
=A0 =A0 =A0 =A0 &amp;sensor_dev_attr_in6_input.dev_attr.attr,<br>
=A0 =A0 =A0 =A0 &amp;sensor_dev_attr_in7_input.dev_attr.attr,<br>
+ =A0 =A0 =A0 &amp;dev_attr_name.attr,<br>
=A0 =A0 =A0 =A0 NULL<br>
=A0};<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.9.7<br>
<br>
</font></span></blockquote></div><br>

--00151747bd823525b204c9ebf32b--


--===============6173024930701004436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6173024930701004436==--
