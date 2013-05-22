From: Robert Coulson <rob.coulson@gmail.com>
Date: Wed, 22 May 2013 15:37:47 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon (ds1621): Remove detection function
Message-Id: <CAEZKy8LmD9HCmb=6f0fxHzzfkMyg803L+9UH5iQN8w67LFgiuA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1387930298860343391=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1369096169-29321-1-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1369096169-29321-1-git-send-email-rob.coulson@gmail.com>
To: lm-sensors@vger.kernel.org

--===============1387930298860343391==
Content-Type: multipart/alternative; boundary=f46d043be27a08d42f04dd5059d3

--f46d043be27a08d42f04dd5059d3
Content-Type: text/plain; charset=ISO-8859-1

On Mon, May 20, 2013 at 11:26 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Robert,
>

Good morning Jean,


>
> On Mon, 20 May 2013 17:29:29 -0700, Robert Coulson wrote:
> > v2:
> > - removed detect function references in ds1621 documentation
> > - replaced deprecated with removed and fixed a spelling error
>
> Note: the patch changes history should go below, between the "---" and
> the diffstat, so that it doesn't make it to git.


Thank you for the info, I appreciate it and will do so in the future.


>


> Almost there, see my comments inline.
>
> >
> > Due to a lack of device and vendor identification registers, the
> > Dallas/Maxim DS16xx devices cannot be uniquely detected, sometimes
> > resulting in false positives. Therefore, the detection function is
> > being removed in favor of explicit device instantiation.
> >
> > These changes are based on the 3.9 source base and intended for
> > hwmon-next.
> >
> > Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
> > ---
> >  Documentation/hwmon/ds1621 |   13 ++++---------
> >  drivers/hwmon/ds1621.c     |   43
> -------------------------------------------
> >  2 files changed, 4 insertions(+), 52 deletions(-)
> >
> > diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
> > index 140eab5..009aabb 100644
> > --- a/Documentation/hwmon/ds1621
> > +++ b/Documentation/hwmon/ds1621
> > @@ -8,9 +8,7 @@ Supported chips:
> >      Datasheet: Publicly available from www.maximintegrated.com
> >
> >    * Dallas Semiconductor DS1625
> > -    Prefix:
> > -     'ds1621' - if binding via _detect function
> > -     'ds1625' - explicit instantiation
> > +    Prefix: 'ds1625'
> >      Addresses scanned: I2C 0x48 - 0x4f
>
> You much change these lists to "none", as the driver will no longer
> scan any address.
>

agreed.


>
> >      Datasheet: Publicly available from www.datasheetarchive.com
> >
> > @@ -77,12 +75,9 @@ The DS1625 is pin compatible and functionally
> equivalent with the DS1621,
> >  but the DS1621 is meant to replace it. The DS1631 and DS1721 are also
> >  pin compatible with the DS1621, but provide multi-resolution support.
> >
> > -Since there is no version register, there is no unique identification
> > -for these devices. In addition, the DS1631 and DS1721 will emulate a
> > -DS1621 device, if not explicitly instantiated (why? because the detect
> > -function compares the temperature register values bits and checks for a
> > -9-bit resolution). Therefore, for correct device identification and
> > -functionality, explicit device instantiation is required.
> > +Since there is no version or vendor identification register, there is
> > +no unique identification for these devices. Therefore, explicit device
> > +instantiation is required for correct device identification and
> functionality.
> >
> >  The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
> >  degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
> > diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
> > index d4f02a8..124fc83 100644
> > --- a/drivers/hwmon/ds1621.c
> > +++ b/drivers/hwmon/ds1621.c
> > @@ -360,48 +360,6 @@ static const struct attribute_group ds1621_group = {
> >       .is_visible = ds1621_attribute_visible
> >  };
> >
> > -
> > -/* Return 0 if detection is successful, -ENODEV otherwise */
> > -static int ds1621_detect(struct i2c_client *client,
> > -                      struct i2c_board_info *info)
> > -{
> > -     struct i2c_adapter *adapter = client->adapter;
> > -     int conf, temp;
> > -     int i;
> > -
> > -     if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
> > -                                  | I2C_FUNC_SMBUS_WORD_DATA
> > -                                  | I2C_FUNC_SMBUS_WRITE_BYTE))
> > -             return -ENODEV;
> > -
> > -     /*
> > -      * Now, we do the remaining detection. It is lousy.
> > -      *
> > -      * The NVB bit should be low if no EEPROM write has been requested
> > -      * during the latest 10ms, which is highly improbable in our case.
> > -      */
> > -     conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
> > -     if (conf < 0 || conf & DS1621_REG_CONFIG_NVB)
> > -             return -ENODEV;
> > -     /*
> > -      * The ds1621 & ds1625 use 9-bit resolution, so the 7 lowest bits
> > -      * of the temperature should always be 0 (NOTE: The other chips
> > -      * have multi-resolution support, so if they have 9-bit resolution
> > -      * configured and the min/max temperature values set accordingly,
> > -      * then if not explicitly instantiated, they *will* appear as and
> > -      * emulate a ds1621 device).
> > -      */
> > -     for (i = 0; i < ARRAY_SIZE(DS1621_REG_TEMP); i++) {
> > -             temp = i2c_smbus_read_word_data(client,
> DS1621_REG_TEMP[i]);
> > -             if (temp < 0 || (temp & 0x7f00))
> > -                     return -ENODEV;
> > -     }
> > -
> > -     strlcpy(info->type, "ds1621", I2C_NAME_SIZE);
> > -
> > -     return 0;
> > -}
> > -
> >  static int ds1621_probe(struct i2c_client *client,
> >                       const struct i2c_device_id *id)
> >  {
> > @@ -467,7 +425,6 @@ static struct i2c_driver ds1621_driver = {
> >       .probe          = ds1621_probe,
> >       .remove         = ds1621_remove,
> >       .id_table       = ds1621_id,
> > -     .detect         = ds1621_detect,
> >       .address_list   = normal_i2c,
>
> This address list can be removed as well, as it is only used to
> determine when the detect callback should be called.
>

agreed and nice catch.


>
> >  };
> >
>
> Thanks,
> --
> Jean Delvare
>

Your welcome.

I'll send an updated patch set shortly.

Rob

--f46d043be27a08d42f04dd5059d3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, May 20, 2013 at 11:26 PM, Jean Delvare <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:khali@linux-fr.org" target=3D"_blank">khali@linux-fr.org</a=
>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Robert,<br></blockquote><div><br></div><d=
iv style>Good morning Jean,</div><div style>=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">

<div><br>
On Mon, 20 May 2013 17:29:29 -0700, Robert Coulson wrote:<br>
&gt; v2:<br>
&gt; - removed detect function references in ds1621 documentation<br>
&gt; - replaced deprecated with removed and fixed a spelling error<br>
<br>
</div>Note: the patch changes history should go below, between the &quot;--=
-&quot; and<br>
the diffstat, so that it doesn&#39;t make it to git.</blockquote><div><br><=
/div><div style>Thank you for the info, I appreciate it and will do so in t=
he future.</div><div style>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
<br>
Almost there, see my comments inline.<br>
<div><br>
&gt;<br>
&gt; Due to a lack of device and vendor identification registers, the<br>
&gt; Dallas/Maxim DS16xx devices cannot be uniquely detected, sometimes<br>
&gt; resulting in false positives. Therefore, the detection function is<br>
&gt; being removed in favor of explicit device instantiation.<br>
&gt;<br>
&gt; These changes are based on the 3.9 source base and intended for<br>
&gt; hwmon-next.<br>
&gt;<br>
&gt; Signed-off-by: Robert Coulson &lt;<a href=3D"mailto:rob.coulson@gmail.=
com" target=3D"_blank">rob.coulson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0Documentation/hwmon/ds1621 | =A0 13 ++++---------<br>
&gt; =A0drivers/hwmon/ds1621.c =A0 =A0 | =A0 43 ---------------------------=
----------------<br>
&gt; =A02 files changed, 4 insertions(+), 52 deletions(-)<br>
&gt;<br>
&gt; diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621<b=
r>
&gt; index 140eab5..009aabb 100644<br>
&gt; --- a/Documentation/hwmon/ds1621<br>
&gt; +++ b/Documentation/hwmon/ds1621<br>
&gt; @@ -8,9 +8,7 @@ Supported chips:<br>
&gt; =A0 =A0 =A0Datasheet: Publicly available from <a href=3D"http://www.ma=
ximintegrated.com" target=3D"_blank">www.maximintegrated.com</a><br>
&gt;<br>
&gt; =A0 =A0* Dallas Semiconductor DS1625<br>
&gt; - =A0 =A0Prefix:<br>
&gt; - =A0 =A0 &#39;ds1621&#39; - if binding via _detect function<br>
&gt; - =A0 =A0 &#39;ds1625&#39; - explicit instantiation<br>
&gt; + =A0 =A0Prefix: &#39;ds1625&#39;<br>
&gt; =A0 =A0 =A0Addresses scanned: I2C 0x48 - 0x4f<br>
<br>
</div>You much change these lists to &quot;none&quot;, as the driver will n=
o longer<br>
scan any address.<br></blockquote><div><br></div><div style>agreed.</div><d=
iv style>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
<div><div><br>
&gt; =A0 =A0 =A0Datasheet: Publicly available from <a href=3D"http://www.da=
tasheetarchive.com" target=3D"_blank">www.datasheetarchive.com</a><br>
&gt;<br>
&gt; @@ -77,12 +75,9 @@ The DS1625 is pin compatible and functionally equiv=
alent with the DS1621,<br>
&gt; =A0but the DS1621 is meant to replace it. The DS1631 and DS1721 are al=
so<br>
&gt; =A0pin compatible with the DS1621, but provide multi-resolution suppor=
t.<br>
&gt;<br>
&gt; -Since there is no version register, there is no unique identification=
<br>
&gt; -for these devices. In addition, the DS1631 and DS1721 will emulate a<=
br>
&gt; -DS1621 device, if not explicitly instantiated (why? because the detec=
t<br>
&gt; -function compares the temperature register values bits and checks for=
 a<br>
&gt; -9-bit resolution). Therefore, for correct device identification and<b=
r>
&gt; -functionality, explicit device instantiation is required.<br>
&gt; +Since there is no version or vendor identification register, there is=
<br>
&gt; +no unique identification for these devices. Therefore, explicit devic=
e<br>
&gt; +instantiation is required for correct device identification and funct=
ionality.<br>
&gt;<br>
&gt; =A0The DS1721 is pin compatible with the DS1621, has an accuracy of +/=
- 1.0<br>
&gt; =A0degree Celius over a -10 to +85 degree range, a minimum/maximum ala=
rm<br>
&gt; diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c<br>
&gt; index d4f02a8..124fc83 100644<br>
&gt; --- a/drivers/hwmon/ds1621.c<br>
&gt; +++ b/drivers/hwmon/ds1621.c<br>
&gt; @@ -360,48 +360,6 @@ static const struct attribute_group ds1621_group =
=3D {<br>
&gt; =A0 =A0 =A0 .is_visible =3D ds1621_attribute_visible<br>
&gt; =A0};<br>
&gt;<br>
&gt; -<br>
&gt; -/* Return 0 if detection is successful, -ENODEV otherwise */<br>
&gt; -static int ds1621_detect(struct i2c_client *client,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct i2c_board_info *in=
fo)<br>
&gt; -{<br>
&gt; - =A0 =A0 struct i2c_adapter *adapter =3D client-&gt;adapter;<br>
&gt; - =A0 =A0 int conf, temp;<br>
&gt; - =A0 =A0 int i;<br>
&gt; -<br>
&gt; - =A0 =A0 if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DA=
TA<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 I2C_FUNC_SMBUS_WORD_DATA<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 I2C_FUNC_SMBUS_WRITE_BYTE))<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt; -<br>
&gt; - =A0 =A0 /*<br>
&gt; - =A0 =A0 =A0* Now, we do the remaining detection. It is lousy.<br>
&gt; - =A0 =A0 =A0*<br>
&gt; - =A0 =A0 =A0* The NVB bit should be low if no EEPROM write has been r=
equested<br>
&gt; - =A0 =A0 =A0* during the latest 10ms, which is highly improbable in o=
ur case.<br>
&gt; - =A0 =A0 =A0*/<br>
&gt; - =A0 =A0 conf =3D i2c_smbus_read_byte_data(client, DS1621_REG_CONF);<=
br>
&gt; - =A0 =A0 if (conf &lt; 0 || conf &amp; DS1621_REG_CONFIG_NVB)<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt; - =A0 =A0 /*<br>
&gt; - =A0 =A0 =A0* The ds1621 &amp; ds1625 use 9-bit resolution, so the 7 =
lowest bits<br>
&gt; - =A0 =A0 =A0* of the temperature should always be 0 (NOTE: The other =
chips<br>
&gt; - =A0 =A0 =A0* have multi-resolution support, so if they have 9-bit re=
solution<br>
&gt; - =A0 =A0 =A0* configured and the min/max temperature values set accor=
dingly,<br>
&gt; - =A0 =A0 =A0* then if not explicitly instantiated, they *will* appear=
 as and<br>
&gt; - =A0 =A0 =A0* emulate a ds1621 device).<br>
&gt; - =A0 =A0 =A0*/<br>
&gt; - =A0 =A0 for (i =3D 0; i &lt; ARRAY_SIZE(DS1621_REG_TEMP); i++) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 temp =3D i2c_smbus_read_word_data(client, DS=
1621_REG_TEMP[i]);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 if (temp &lt; 0 || (temp &amp; 0x7f00))<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt; - =A0 =A0 }<br>
&gt; -<br>
&gt; - =A0 =A0 strlcpy(info-&gt;type, &quot;ds1621&quot;, I2C_NAME_SIZE);<b=
r>
&gt; -<br>
&gt; - =A0 =A0 return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; =A0static int ds1621_probe(struct i2c_client *client,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device_id=
 *id)<br>
&gt; =A0{<br>
&gt; @@ -467,7 +425,6 @@ static struct i2c_driver ds1621_driver =3D {<br>
&gt; =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D ds1621_probe,<br>
&gt; =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D ds1621_remove,<br>
&gt; =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D ds1621_id,<br>
&gt; - =A0 =A0 .detect =A0 =A0 =A0 =A0 =3D ds1621_detect,<br>
&gt; =A0 =A0 =A0 .address_list =A0 =3D normal_i2c,<br>
<br>
</div></div>This address list can be removed as well, as it is only used to=
<br>
determine when the detect callback should be called.<br></blockquote><div><=
br></div><div style>agreed and nice catch.</div><div style>=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">

<br>
&gt; =A0};<br>
&gt;<br>
<br>
Thanks,<br>
<span><font color=3D"#888888">--<br>
Jean Delvare<br></font></span></blockquote><div>=A0</div></div>Your welcome=
.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra" styl=
e>I&#39;ll send an updated patch set shortly.</div><div class=3D"gmail_extr=
a" style>
<br></div><div class=3D"gmail_extra" style>Rob</div></div>

--f46d043be27a08d42f04dd5059d3--


--===============1387930298860343391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1387930298860343391==--
