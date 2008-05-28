From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 28 May 2008 00:52:42 +0000
Subject: Re: [lm-sensors] [PATCH 04/10] hwmon: (lm85) Don't write back
Message-Id: <191fb4ca0805271752w6bede9e2w45cb311dbee1eec9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7580823008226218960=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7580823008226218960==
Content-Type: multipart/alternative; 
	boundary="----=_Part_2860_5503518.1211935962290"

------=_Part_2860_5503518.1211935962290
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks good.

Acked-by: Juerg Haefliger <juergh at gmail.com>


On Sat, Apr 12, 2008 at 10:56 AM, Jean Delvare <khali@linux-fr.org> wrote:

> In set_pwm_auto_pwm_minctl, we write cached register bits back to the
> chip. This is a bad idea as we have no guarantee that the cache is
> up-to-date. Better read a fresh register value from the chip, it's
> safer and in fact it is also more simple.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm85.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> --- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c  2008-04-03
> 09:50:16.000000000 +0200
> +++ linux-2.6.25-rc8/drivers/hwmon/lm85.c       2008-04-03
> 09:50:19.000000000 +0200
> @@ -309,10 +309,8 @@ struct lm85_data {
>        u8 pwm[3];              /* Register value */
>        u8 temp_ext[3];         /* Decoded values */
>        u8 in_ext[8];           /* Decoded values */
> -       u8 smooth[1];           /* Register encoding */
>        u8 vid;                 /* Register value */
>        u8 vrm;                 /* VRM version */
> -       u8 syncpwm3;            /* Saved PWM3 for TACH 2,3,4 config */
>        u32 alarms;             /* Register encoding, combined */
>        struct lm85_autofan autofan[3];
>        struct lm85_zone zone[3];
> @@ -757,14 +755,15 @@ static ssize_t set_pwm_auto_pwm_minctl(s
>        struct i2c_client *client = to_i2c_client(dev);
>        struct lm85_data *data = i2c_get_clientdata(client);
>        long val = simple_strtol(buf, NULL, 10);
> +       u8 tmp;
>
>        mutex_lock(&data->update_lock);
>        data->autofan[nr].min_off = val;
> -       lm85_write_value(client, LM85_REG_AFAN_SPIKE1, data->smooth[0]
> -               | data->syncpwm3
> -               | (data->autofan[0].min_off ? 0x20 : 0)
> -               | (data->autofan[1].min_off ? 0x40 : 0)
> -               | (data->autofan[2].min_off ? 0x80 : 0));
> +       tmp = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
> +       tmp &= ~(0x20 << nr);
> +       if (data->autofan[nr].min_off)
> +               tmp |= 0x20 << nr;
> +       lm85_write_value(client, LM85_REG_AFAN_SPIKE1, tmp);
>        mutex_unlock(&data->update_lock);
>        return count;
>  }
> @@ -1530,8 +1529,6 @@ static struct lm85_data *lm85_update_dev
>                }
>
>                i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
> -               data->smooth[0] = i & 0x0f;
> -               data->syncpwm3 = i & 0x10;  /* Save PWM3 config */
>                data->autofan[0].min_off = (i & 0x20) != 0;
>                data->autofan[1].min_off = (i & 0x40) != 0;
>                data->autofan[2].min_off = (i & 0x80) != 0;
>
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

------=_Part_2860_5503518.1211935962290
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks good.<br><br>Acked-by: Juerg Haefliger &lt;juergh at <a href="http://gmail.com">gmail.com</a>&gt;<br><br><br><div class="gmail_quote">On Sat, Apr 12, 2008 at 10:56 AM, Jean Delvare &lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">In set_pwm_auto_pwm_minctl, we write cached register bits back to the<br>
chip. This is a bad idea as we have no guarantee that the cache is<br>
up-to-date. Better read a fresh register value from the chip, it&#39;s<br>
safer and in fact it is also more simple.<br>
<br>
Signed-off-by: Jean Delvare &lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;<br>
---<br>
&nbsp;drivers/hwmon/lm85.c | &nbsp; 15 ++++++---------<br>
&nbsp;1 file changed, 6 insertions(+), 9 deletions(-)<br>
<br>
--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c &nbsp;2008-04-03 09:50:16.000000000 +0200<br>
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c &nbsp; &nbsp; &nbsp; 2008-04-03 09:50:19.000000000 +0200<br>
@@ -309,10 +309,8 @@ struct lm85_data {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;u8 pwm[3]; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Register value */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;u8 temp_ext[3]; &nbsp; &nbsp; &nbsp; &nbsp; /* Decoded values */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;u8 in_ext[8]; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Decoded values */<br>
- &nbsp; &nbsp; &nbsp; u8 smooth[1]; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Register encoding */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;u8 vid; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Register value */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;u8 vrm; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* VRM version */<br>
- &nbsp; &nbsp; &nbsp; u8 syncpwm3; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Saved PWM3 for TACH 2,3,4 config */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;u32 alarms; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Register encoding, combined */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct lm85_autofan autofan[3];<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct lm85_zone zone[3];<br>
@@ -757,14 +755,15 @@ static ssize_t set_pwm_auto_pwm_minctl(s<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct i2c_client *client = to_i2c_client(dev);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct lm85_data *data = i2c_get_clientdata(client);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;long val = simple_strtol(buf, NULL, 10);<br>
+ &nbsp; &nbsp; &nbsp; u8 tmp;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;mutex_lock(&amp;data-&gt;update_lock);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;autofan[nr].min_off = val;<br>
- &nbsp; &nbsp; &nbsp; lm85_write_value(client, LM85_REG_AFAN_SPIKE1, data-&gt;smooth[0]<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | data-&gt;syncpwm3<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | (data-&gt;autofan[0].min_off ? 0x20 : 0)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | (data-&gt;autofan[1].min_off ? 0x40 : 0)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | (data-&gt;autofan[2].min_off ? 0x80 : 0));<br>
+ &nbsp; &nbsp; &nbsp; tmp = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);<br>
+ &nbsp; &nbsp; &nbsp; tmp &amp;= ~(0x20 &lt;&lt; nr);<br>
+ &nbsp; &nbsp; &nbsp; if (data-&gt;autofan[nr].min_off)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tmp |= 0x20 &lt;&lt; nr;<br>
+ &nbsp; &nbsp; &nbsp; lm85_write_value(client, LM85_REG_AFAN_SPIKE1, tmp);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;mutex_unlock(&amp;data-&gt;update_lock);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;return count;<br>
&nbsp;}<br>
@@ -1530,8 +1529,6 @@ static struct lm85_data *lm85_update_dev<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;smooth[0] = i &amp; 0x0f;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;syncpwm3 = i &amp; 0x10; &nbsp;/* Save PWM3 config */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;autofan[0].min_off = (i &amp; 0x20) != 0;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;autofan[1].min_off = (i &amp; 0x40) != 0;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;autofan[2].min_off = (i &amp; 0x80) != 0;<br>
<font color="#888888"><br>
--<br>
Jean Delvare<br>
<br>
_______________________________________________<br>
lm-sensors mailing list<br>
<a href="mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><br>
<a href="http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target="_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
</font></blockquote></div><br>

------=_Part_2860_5503518.1211935962290--


--===============7580823008226218960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7580823008226218960==--
