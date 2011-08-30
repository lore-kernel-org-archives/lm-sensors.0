From: Robert Casanova <robertcasanova@nanometrics.ca>
Date: Tue, 30 Aug 2011 20:25:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm73) Make detection less
Message-Id: <CAOYRzauXOM23gx1myR4ibP3H4dhxUxwFJP-2_cjU_=dnuMKJhw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8423441708790275706=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20110830220517.381f6b4e@endymion.delvare>
In-Reply-To: <20110830220517.381f6b4e@endymion.delvare>
To: lm-sensors@vger.kernel.org

--===============8423441708790275706==
Content-Type: multipart/alternative; boundary=20cf303bff46ba328804abbecf2d

--20cf303bff46ba328804abbecf2d
Content-Type: text/plain; charset=ISO-8859-1

I can confirm that we have also observed the same behavior as this patch
solves. Some devices do not behave properly when requested by word reads.

This patch also solves the problems discussed in a different thread [1].

Thanks Jean and Guenter.

References:
[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2011-August/033621.html

On 30 August 2011 16:05, Jean Delvare <khali@linux-fr.org> wrote:

> Word reads can cause trouble with some I2C devices, so do as much
> detection as we can using only byte reads, and only use a word read in
> the end to confirm the positive match. Also properly handle read
> errors.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Robert Casanova <robertcasanova@nanometrics.ca>
> ---
>  drivers/hwmon/lm73.c |   22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> --- linux-3.1-rc4.orig/drivers/hwmon/lm73.c     2011-07-22
> 04:17:23.000000000 +0200
> +++ linux-3.1-rc4/drivers/hwmon/lm73.c  2011-08-30 21:13:46.000000000 +0200
> @@ -150,17 +150,31 @@ static int lm73_detect(struct i2c_client
>                        struct i2c_board_info *info)
>  {
>        struct i2c_adapter *adapter = new_client->adapter;
> -       u16 id;
> -       u8 ctrl;
> +       int id, ctrl, conf;
>
>        if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>                                        I2C_FUNC_SMBUS_WORD_DATA))
>                return -ENODEV;
>
> +       /*
> +        * Do as much detection as possible with byte reads first, as word
> +        * reads can confuse other devices.
> +        */
> +       ctrl = i2c_smbus_read_byte_data(new_client, LM73_REG_CTRL);
> +       if (ctrl < 0 || (ctrl & 0x10))
> +               return -ENODEV;
> +
> +       conf = i2c_smbus_read_byte_data(new_client, LM73_REG_CONF);
> +       if (conf < 0 || (conf & 0x0c))
> +               return -ENODEV;
> +
> +       id = i2c_smbus_read_byte_data(new_client, LM73_REG_ID);
> +       if (id < 0 || id != (LM73_ID & 0xff))
> +               return -ENODEV;
> +
>        /* Check device ID */
>        id = i2c_smbus_read_word_data(new_client, LM73_REG_ID);
> -       ctrl = i2c_smbus_read_byte_data(new_client, LM73_REG_CTRL);
> -       if ((id != LM73_ID) || (ctrl & 0x10))
> +       if (id < 0 || id != LM73_ID)
>                return -ENODEV;
>
>        strlcpy(info->type, "lm73", I2C_NAME_SIZE);
>
>
> --
> Jean Delvare
>

--20cf303bff46ba328804abbecf2d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I can confirm that we have also=A0observed=A0the same=A0behavior as this pa=
tch solves. Some devices do not behave properly when requested by word read=
s.<div><br><div>This patch also solves the problems discussed in a differen=
t thread [1].</div>
<div><br></div><div>Thanks Jean and Guenter.<br>
<br></div><div>References:</div><div>[1]=A0<a href=3D"http://lists.lm-senso=
rs.org/pipermail/lm-sensors/2011-August/033621.html" target=3D"_blank">http=
://lists.lm-sensors.org/pipermail/lm-sensors/2011-August/033621.html</a></d=
iv>
<div><br><div class=3D"gmail_quote">
On 30 August 2011 16:05, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"mail=
to:khali@linux-fr.org" target=3D"_blank">khali@linux-fr.org</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">

Word reads can cause trouble with some I2C devices, so do as much<br>
detection as we can using only byte reads, and only use a word read in<br>
the end to confirm the positive match. Also properly handle read<br>
errors.<br>
<br>
Signed-off-by: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org" targe=
t=3D"_blank">khali@linux-fr.org</a>&gt;<br>
Cc: Guenter Roeck &lt;<a href=3D"mailto:guenter.roeck@ericsson.com" target=
=3D"_blank">guenter.roeck@ericsson.com</a>&gt;<br>
Cc: Robert Casanova &lt;<a href=3D"mailto:robertcasanova@nanometrics.ca" ta=
rget=3D"_blank">robertcasanova@nanometrics.ca</a>&gt;<br>
---<br>
=A0drivers/hwmon/lm73.c | =A0 22 ++++++++++++++++++----<br>
=A01 file changed, 18 insertions(+), 4 deletions(-)<br>
<br>
--- linux-3.1-rc4.orig/drivers/hwmon/lm73.c =A0 =A0 2011-07-22 04:17:23.000=
000000 +0200<br>
+++ linux-3.1-rc4/drivers/hwmon/lm73.c =A02011-08-30 21:13:46.000000000 +02=
00<br>
@@ -150,17 +150,31 @@ static int lm73_detect(struct i2c_client<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct i2c_board_info *info=
)<br>
=A0{<br>
 =A0 =A0 =A0 =A0struct i2c_adapter *adapter =3D new_client-&gt;adapter;<br>
- =A0 =A0 =A0 u16 id;<br>
- =A0 =A0 =A0 u8 ctrl;<br>
+ =A0 =A0 =A0 int id, ctrl, conf;<br>
<br>
 =A0 =A0 =A0 =A0if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_D=
ATA |<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0I2C_FUNC_SMBUS_WORD_DATA))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;<br>
<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* Do as much detection as possible with byte reads first, =
as word<br>
+ =A0 =A0 =A0 =A0* reads can confuse other devices.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 ctrl =3D i2c_smbus_read_byte_data(new_client, LM73_REG_CTRL);=
<br>
+ =A0 =A0 =A0 if (ctrl &lt; 0 || (ctrl &amp; 0x10))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
+<br>
+ =A0 =A0 =A0 conf =3D i2c_smbus_read_byte_data(new_client, LM73_REG_CONF);=
<br>
+ =A0 =A0 =A0 if (conf &lt; 0 || (conf &amp; 0x0c))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
+<br>
+ =A0 =A0 =A0 id =3D i2c_smbus_read_byte_data(new_client, LM73_REG_ID);<br>
+ =A0 =A0 =A0 if (id &lt; 0 || id !=3D (LM73_ID &amp; 0xff))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
+<br>
 =A0 =A0 =A0 =A0/* Check device ID */<br>
 =A0 =A0 =A0 =A0id =3D i2c_smbus_read_word_data(new_client, LM73_REG_ID);<b=
r>
- =A0 =A0 =A0 ctrl =3D i2c_smbus_read_byte_data(new_client, LM73_REG_CTRL);=
<br>
- =A0 =A0 =A0 if ((id !=3D LM73_ID) || (ctrl &amp; 0x10))<br>
+ =A0 =A0 =A0 if (id &lt; 0 || id !=3D LM73_ID)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;<br>
<br>
 =A0 =A0 =A0 =A0strlcpy(info-&gt;type, &quot;lm73&quot;, I2C_NAME_SIZE);<br=
>
<br>
<br>
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br></div></div>

--20cf303bff46ba328804abbecf2d--


--===============8423441708790275706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8423441708790275706==--
