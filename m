From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Wed, 01 Dec 2010 02:50:58 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div (2nd try)
Message-Id: <AANLkTikQu_K6G9siitaoE__6U+ckwDKgV87NwHpzNJub@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8245578309876356034=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101201005717.GE30973@penguintown.net>
In-Reply-To: <20101201005717.GE30973@penguintown.net>
To: lm-sensors@vger.kernel.org

--===============8245578309876356034==
Content-Type: multipart/alternative; boundary=90e6ba6e819cffc29c0496505fa5

--90e6ba6e819cffc29c0496505fa5
Content-Type: text/plain; charset=ISO-8859-1

ACK

On Tue, Nov 30, 2010 at 4:57 PM, Gabriele Gorla <gorlik@penguintown.net>wrote:

> Prevent setting fan_div from stomping on other fans that share the same i2c
> register.
>
> Signed-off-by: Gabriele Gorla <gorlik at penguintown.net>
> ---
>
> diff -r -U 5 linux-source-2.6.26_orig/drivers/hwmon/adm1026.c
> linux-source-2.6.26/drivers/hwmon/adm1026.c
> --- linux-source-2.6.26_orig/drivers/hwmon/adm1026.c    2008-07-13
> 14:51:29.000000000 -0700
> +++ linux-source-2.6.26/drivers/hwmon/adm1026.c 2010-11-30
> 16:35:27.000000000 -0800
> @@ -918,34 +918,36 @@
>  {
>        struct sensor_device_attribute *sensor_attr =
> to_sensor_dev_attr(attr);
>        int nr = sensor_attr->index;
>        struct i2c_client *client = to_i2c_client(dev);
>        struct adm1026_data *data = i2c_get_clientdata(client);
> -       int val, orig_div, new_div, shift;
> +       int val, orig_div, new_div;
>
>        val = simple_strtol(buf, NULL, 10);
>        new_div = DIV_TO_REG(val);
>        if (new_div == 0) {
>                return -EINVAL;
>        }
>        mutex_lock(&data->update_lock);
>        orig_div = data->fan_div[nr];
> -       data->fan_div[nr] = DIV_FROM_REG(new_div);
> +       if (orig_div != DIV_FROM_REG(new_div)) {
> +               data->fan_div[nr] = DIV_FROM_REG(new_div);
>
> -       if (nr < 4) { /* 0 <= nr < 4 */
> -               shift = 2 * nr;
> -               adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
> -                       ((DIV_TO_REG(orig_div) & (~(0x03 << shift))) |
> -                       (new_div << shift)));
> -       } else { /* 3 < nr < 8 */
> -               shift = 2 * (nr - 4);
> -               adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
> -                       ((DIV_TO_REG(orig_div) & (~(0x03 << (2 * shift))))
> |
> -                       (new_div << shift)));
> -       }
> +               if (nr < 4) { /* 0 <= nr < 4 */
> +                       adm1026_write_value(client,
> ADM1026_REG_FAN_DIV_0_3,
> +                                   (DIV_TO_REG(data->fan_div[0]) << 0) |
> +                                   (DIV_TO_REG(data->fan_div[1]) << 2) |
> +                                   (DIV_TO_REG(data->fan_div[2]) << 4) |
> +                                   (DIV_TO_REG(data->fan_div[3]) << 6));
> +               } else { /* 3 < nr < 8 */
> +                       adm1026_write_value(client,
> ADM1026_REG_FAN_DIV_4_7,
> +                                   (DIV_TO_REG(data->fan_div[4]) << 0) |
> +                                   (DIV_TO_REG(data->fan_div[5]) << 2) |
> +                                   (DIV_TO_REG(data->fan_div[6]) << 4) |
> +                                   (DIV_TO_REG(data->fan_div[7]) << 6));
> +               }
>
> -       if (data->fan_div[nr] != orig_div) {
>                fixup_fan_min(dev, nr, orig_div);
>        }
>        mutex_unlock(&data->update_lock);
>        return count;
>  }
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

--90e6ba6e819cffc29c0496505fa5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">ACK<br><br>On Tue, Nov 30, 2010 at 4:57 PM, Gabr=
iele Gorla <span dir=3D"ltr">&lt;<a href=3D"mailto:gorlik@penguintown.net">=
gorlik@penguintown.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, =
204, 204); padding-left: 1ex;">
Prevent setting fan_div from stomping on other fans that share the same i2c=
 register.<br>
<br>
Signed-off-by: Gabriele Gorla &lt;gorlik at <a href=3D"http://penguintown.n=
et" target=3D"_blank">penguintown.net</a>&gt;<br>
---<br>
<br>
diff -r -U 5 linux-source-2.6.26_orig/drivers/hwmon/adm1026.c linux-source-=
2.6.26/drivers/hwmon/adm1026.c<br>
--- linux-source-2.6.26_orig/drivers/hwmon/adm1026.c =A0 =A02008-07-13 14:5=
1:29.000000000 -0700<br>
+++ linux-source-2.6.26/drivers/hwmon/adm1026.c 2010-11-30 16:35:27.0000000=
00 -0800<br>
@@ -918,34 +918,36 @@<br>
=A0{<br>
 =A0 =A0 =A0 =A0struct sensor_device_attribute *sensor_attr =3D to_sensor_d=
ev_attr(attr);<br>
 =A0 =A0 =A0 =A0int nr =3D sensor_attr-&gt;index;<br>
 =A0 =A0 =A0 =A0struct i2c_client *client =3D to_i2c_client(dev);<br>
 =A0 =A0 =A0 =A0struct adm1026_data *data =3D i2c_get_clientdata(client);<b=
r>
- =A0 =A0 =A0 int val, orig_div, new_div, shift;<br>
+ =A0 =A0 =A0 int val, orig_div, new_div;<br>
<br>
 =A0 =A0 =A0 =A0val =3D simple_strtol(buf, NULL, 10);<br>
 =A0 =A0 =A0 =A0new_div =3D DIV_TO_REG(val);<br>
 =A0 =A0 =A0 =A0if (new_div =3D=3D 0) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;<br>
 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0mutex_lock(&amp;data-&gt;update_lock);<br>
 =A0 =A0 =A0 =A0orig_div =3D data-&gt;fan_div[nr];<br>
- =A0 =A0 =A0 data-&gt;fan_div[nr] =3D DIV_FROM_REG(new_div);<br>
+ =A0 =A0 =A0 if (orig_div !=3D DIV_FROM_REG(new_div)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;fan_div[nr] =3D DIV_FROM_REG(new_div=
);<br>
<br>
- =A0 =A0 =A0 if (nr &lt; 4) { /* 0 &lt;=3D nr &lt; 4 */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift =3D 2 * nr;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 adm1026_write_value(client, ADM1026_REG_FAN_D=
IV_0_3,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((DIV_TO_REG(orig_div) &amp; =
(~(0x03 &lt;&lt; shift))) |<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (new_div &lt;&lt; shift)));<b=
r>
- =A0 =A0 =A0 } else { /* 3 &lt; nr &lt; 8 */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift =3D 2 * (nr - 4);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 adm1026_write_value(client, ADM1026_REG_FAN_D=
IV_4_7,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((DIV_TO_REG(orig_div) &amp; =
(~(0x03 &lt;&lt; (2 * shift)))) |<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (new_div &lt;&lt; shift)));<b=
r>
- =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr &lt; 4) { /* 0 &lt;=3D nr &lt; 4 */<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adm1026_write_value(client, A=
DM1026_REG_FAN_DIV_0_3,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV_=
TO_REG(data-&gt;fan_div[0]) &lt;&lt; 0) |<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV_=
TO_REG(data-&gt;fan_div[1]) &lt;&lt; 2) |<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV_=
TO_REG(data-&gt;fan_div[2]) &lt;&lt; 4) |<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV_=
TO_REG(data-&gt;fan_div[3]) &lt;&lt; 6));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else { /* 3 &lt; nr &lt; 8 */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adm1026_write_value(client, A=
DM1026_REG_FAN_DIV_4_7,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV_=
TO_REG(data-&gt;fan_div[4]) &lt;&lt; 0) |<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV_=
TO_REG(data-&gt;fan_div[5]) &lt;&lt; 2) |<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV_=
TO_REG(data-&gt;fan_div[6]) &lt;&lt; 4) |<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV_=
TO_REG(data-&gt;fan_div[7]) &lt;&lt; 6));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 if (data-&gt;fan_div[nr] !=3D orig_div) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fixup_fan_min(dev, nr, orig_div);<br>
 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0mutex_unlock(&amp;data-&gt;update_lock);<br>
 =A0 =A0 =A0 =A0return count;<br>
=A0}<br>
<br>
_______________________________________________<br>
lm-sensors mailing list<br>
<a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><=
br>
<a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target=
=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
</blockquote></div><br>

--90e6ba6e819cffc29c0496505fa5--


--===============8245578309876356034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8245578309876356034==--
