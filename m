From: anish singh <anish198519851985@gmail.com>
Date: Sat, 04 Jun 2011 13:42:30 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for the Philips SA56004
Message-Id: <BANLkTimKB8PtFF72rOeDAmkbM_oq=ZMRgg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1834655804911198524=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1305814253-12528-1-git-send-email-sdevrien@cisco.com>
In-Reply-To: <1305814253-12528-1-git-send-email-sdevrien@cisco.com>
To: lm-sensors@vger.kernel.org

--===============1834655804911198524==
Content-Type: multipart/alternative; boundary=001485f1a094c9662b04a4e2dfb7

--001485f1a094c9662b04a4e2dfb7
Content-Type: text/plain; charset=UTF-8

I am no expert on HWMON but just want to
add some points.

On Sat, Jun 4, 2011 at 4:07 PM, Stijn Devriendt <sdevrien@cisco.com> wrote:

> Add support for the Philips SA56004, an LM86
> compatible temperature sensor.
>
> Changes since v1:
> - Updated documentation
> - Trace replaced by BUG_ON
> - style updates
>
> Signed-off-by: Stijn Devriendt <sdevrien@cisco.com>
> ---
>  Documentation/hwmon/lm90 |    9 ++++++++-
>  drivers/hwmon/Kconfig    |    2 +-
>  drivers/hwmon/lm90.c     |   39 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
> index f3efd18..9cd14cfe 100644
> --- a/Documentation/hwmon/lm90
> +++ b/Documentation/hwmon/lm90
> @@ -113,7 +113,11 @@ Supported chips:
>     Prefix: 'w83l771'
>     Addresses scanned: I2C 0x4c
>     Datasheet: Not publicly available, can be requested from Nuvoton
> -
> +  * Philips/NXP SA56004X
> +    Prefix: 'sa56004'
> +    Addresses scanned: I2C 0x48 through 0x4F
> +    Datasheet: Publicly available at NXP website
> +
> http://ics.nxp.com/products/interface/datasheet/sa56004x.pdf
>
>  Author: Jean Delvare <khali@linux-fr.org>
>
> @@ -193,6 +197,9 @@ W83L771AWG/ASG
>   * The AWG and ASG variants only differ in package format.
>   * Diode ideality factor configuration (remote sensor) at 0xE3
>
> +SA56004X:
> +  * Better local resolution
> +
>  All temperature values are given in degrees Celsius. Resolution
>  is 1.0 degree for the local temperature, 0.125 degree for the remote
>  temperature, except for the MAX6657, MAX6658 and MAX6659 which have a
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 50e40db..11c9339 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -620,7 +620,7 @@ config SENSORS_LM90
>          LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, and
> ADT7461A,
>          Maxim MAX6646, MAX6647, MAX6648, MAX6649, MAX6657, MAX6658,
> MAX6659,
>          MAX6680, MAX6681, MAX6692, MAX6695, MAX6696, ON Semiconductor
> NCT1008,
> -         and Winbond/Nuvoton W83L771W/G/AWG/ASG sensor chips.
> +         Winbond/Nuvoton W83L771W/G/AWG/ASG and Philips SA56004 sensor
> chips.
>
>          This driver can also be built as a module.  If so, the module
>          will be called lm90.
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 2f94f95..01b38a0 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -54,6 +54,9 @@
>  * and extended mode. They are mostly compatible with LM90 except for a
> data
>  * format difference for the temperature value registers.
>  *
> + * This driver also supports the SA56004 from Philips. This device is
> + * pin-compatible with the LM86, the ED/EDP parts are also
> address-compatible.
> + *
>  * Since the LM90 was the first chipset supported by this driver, most
>  * comments will refer to this chipset, but are actually general and
>  * concern all supported chipsets, unless mentioned otherwise.
> @@ -96,13 +99,15 @@
>  * MAX6659 can have address 0x4c, 0x4d or 0x4e.
>  * MAX6680 and MAX6681 can have address 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b,
>  * 0x4c, 0x4d or 0x4e.
> + * SA56004 can have address 0x48 through 0x4F.
>  */
>
>  static const unsigned short normal_i2c[] = {
> -       0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e,
> I2C_CLIENT_END };
> +       0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
> +       0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
>
>  enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461,
> max6680,
> -       max6646, w83l771, max6696 };
> +       max6646, w83l771, max6696, sa56004 };
>
>  /*
>  * The LM90 registers
> @@ -152,6 +157,10 @@ enum chips { lm90, adm1032, lm99, lm86, max6657,
> max6659, adt7461, max6680,
>  #define MAX6659_REG_R_LOCAL_EMERG      0x17
>  #define MAX6659_REG_W_LOCAL_EMERG      0x17
>
> +/*  SA56004 registers */
> +
> +#define SA56004_REG_R_LOCAL_TEMPL 0x22
> +
>  #define LM90_DEF_CONVRATE_RVAL 6       /* Def conversion rate register
> value */
>  #define LM90_MAX_CONVRATE_MS   16000   /* Maximum conversion rate in ms */
>
> @@ -192,6 +201,7 @@ static const struct i2c_device_id lm90_id[] = {
>        { "max6696", max6696 },
>        { "nct1008", adt7461 },
>        { "w83l771", w83l771 },
> +       { "sa56004", sa56004 },
>        { }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm90_id);
> @@ -204,6 +214,8 @@ struct lm90_params {
>        u16 alert_alarms;       /* Which alarm bits trigger ALERT# */
>                                /* Upper 8 bits for max6695/96 */
>        u8 max_convrate;        /* Maximum conversion rate register value */
> +       u8 reg_local_ext;       /* Local extension register if
> +                                  LM90_HAVE_LOCAL_EXT is set*/
>  };
>
>  static const struct lm90_params lm90_params[] = {
> @@ -238,6 +250,7 @@ static const struct lm90_params lm90_params[] = {
>                .flags = LM90_HAVE_LOCAL_EXT,
>                .alert_alarms = 0x7c,
>                .max_convrate = 6,
> +               .reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
>        },
>        [max6657] = {
>                .flags = LM90_HAVE_LOCAL_EXT,
> @@ -248,6 +261,7 @@ static const struct lm90_params lm90_params[] = {
>                .flags = LM90_HAVE_LOCAL_EXT | LM90_HAVE_EMERGENCY,
>                .alert_alarms = 0x7c,
>                .max_convrate = 8,
> +               .reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
>        },
>        [max6680] = {
>                .flags = LM90_HAVE_OFFSET,
> @@ -259,12 +273,20 @@ static const struct lm90_params lm90_params[] = {
>                  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3,
>                .alert_alarms = 0x187c,
>                .max_convrate = 6,
> +               .reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
>        },
>        [w83l771] = {
>                .flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
>                .alert_alarms = 0x7c,
>                .max_convrate = 8,
>        },
> +       [sa56004] = {
> +               .flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
> +                 | LM90_HAVE_LOCAL_EXT,
> +               .alert_alarms = 0x7b,
> +               .max_convrate = 9,
> +               .reg_local_ext = SA56004_REG_R_LOCAL_TEMPL,
> +       },
>  };
>
>  /*
> @@ -286,6 +308,7 @@ struct lm90_data {
>        u16 alert_alarms;       /* Which alarm bits trigger ALERT# */
>                                /* Upper 8 bits for max6695/96 */
>        u8 max_convrate;        /* Maximum conversion rate */
> +       u8 reg_local_ext;       /* local extension register offset */
>
>        /* registers values */
>        s8 temp8[8];    /* 0: local low limit
> @@ -454,7 +477,7 @@ static struct lm90_data *lm90_update_device(struct
> device *dev)
>
>                if (data->flags & LM90_HAVE_LOCAL_EXT) {
>                        lm90_read16(client, LM90_REG_R_LOCAL_TEMP,
> -                                   MAX6657_REG_R_LOCAL_TEMPL,
> +                                   data->reg_local_ext,
>                                    &data->temp11[4]);
>
I don't think this variable reg_local_ext should exist as
register address should be "# defined" and should not be
part of lm90_data but i do see a case here where we are
assuming MAX6657 is only having this LM90_HAVE_LOCAL_EXT
flag set.So i think we should have some more branching here
to detect the device and pass the corresponding register but as
i said i am no expert.


>                } else {
>                        if (lm90_read_reg(client, LM90_REG_R_LOCAL_TEMP,
> @@ -1263,6 +1286,11 @@ static int lm90_detect(struct i2c_client
> *new_client,
>                                name = "w83l771";
>                        }
>                }
> +       } else
> +       if (man_id == 0xA1) { /*  NXP Semiconductor/Philips */
> +               if (chip_id == 0x00 && address >= 0x48 && address <= 0x4F)
> {
> +                       name = "sa56004";
> +               }
>        }
>
>        if (!name) { /* identification failed */
> @@ -1372,6 +1400,11 @@ static int lm90_probe(struct i2c_client *new_client,
>        /* Set maximum conversion rate */
>        data->max_convrate = lm90_params[data->kind].max_convrate;
>
> +       if (data->flags & LM90_HAVE_LOCAL_EXT) {
> +               data->reg_local_ext =
> lm90_params[data->kind].reg_local_ext;
> +               BUG_ON(data->reg_local_ext == 0);
> +       }
> +
>
I think this BUG_ON is too harsh in probe.We generally use pr_err
to print if something which is supposed to be set is not set.As BUG_ON
will call kernel panic,right?

>        /* Initialize the LM90 chip */
>        lm90_init_client(new_client);
>
> --
> 1.7.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--001485f1a094c9662b04a4e2dfb7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>I am no expert on HWMON but just want to </div>
<div>add some points.<br><br></div>
<div class=3D"gmail_quote">On Sat, Jun 4, 2011 at 4:07 PM, Stijn Devriendt =
<span dir=3D"ltr">&lt;<a href=3D"mailto:sdevrien@cisco.com">sdevrien@cisco.=
com</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">Add support for the Philips SA56=
004, an LM86<br>compatible temperature sensor.<br><br>Changes since v1:<br>
- Updated documentation<br>- Trace replaced by BUG_ON<br>- style updates<br=
><br>Signed-off-by: Stijn Devriendt &lt;<a href=3D"mailto:sdevrien@cisco.co=
m">sdevrien@cisco.com</a>&gt;<br>---<br>=C2=A0Documentation/hwmon/lm90 | =
=C2=A0 =C2=A09 ++++++++-<br>
=C2=A0drivers/hwmon/Kconfig =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-<br>=C2=A0drive=
rs/hwmon/lm90.c =C2=A0 =C2=A0 | =C2=A0 39 +++++++++++++++++++++++++++++++++=
+++---<br>=C2=A03 files changed, 45 insertions(+), 5 deletions(-)<br><br>di=
ff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90<br>
index f3efd18..9cd14cfe 100644<br>--- a/Documentation/hwmon/lm90<br>+++ b/D=
ocumentation/hwmon/lm90<br>@@ -113,7 +113,11 @@ Supported chips:<br>=C2=A0 =
=C2=A0 Prefix: &#39;w83l771&#39;<br>=C2=A0 =C2=A0 Addresses scanned: I2C 0x=
4c<br>=C2=A0 =C2=A0 Datasheet: Not publicly available, can be requested fro=
m Nuvoton<br>
-<br>+ =C2=A0* Philips/NXP SA56004X<br>+ =C2=A0 =C2=A0Prefix: &#39;sa56004&=
#39;<br>+ =C2=A0 =C2=A0Addresses scanned: I2C 0x48 through 0x4F<br>+ =C2=A0=
 =C2=A0Datasheet: Publicly available at NXP website<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://ics.nxp.com/products/inte=
rface/datasheet/sa56004x.pdf" target=3D"_blank">http://ics.nxp.com/products=
/interface/datasheet/sa56004x.pdf</a><br>
<br>=C2=A0Author: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">kh=
ali@linux-fr.org</a>&gt;<br><br>@@ -193,6 +197,9 @@ W83L771AWG/ASG<br>=C2=
=A0 * The AWG and ASG variants only differ in package format.<br>=C2=A0 * D=
iode ideality factor configuration (remote sensor) at 0xE3<br>
<br>+SA56004X:<br>+ =C2=A0* Better local resolution<br>+<br>=C2=A0All tempe=
rature values are given in degrees Celsius. Resolution<br>=C2=A0is 1.0 degr=
ee for the local temperature, 0.125 degree for the remote<br>=C2=A0temperat=
ure, except for the MAX6657, MAX6658 and MAX6659 which have a<br>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig<br>index 50e40db=
..11c9339 100644<br>--- a/drivers/hwmon/Kconfig<br>+++ b/drivers/hwmon/Kcon=
fig<br>@@ -620,7 +620,7 @@ config SENSORS_LM90<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, and ADT7461=
A,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Maxim MAX6646, MAX6647, MAX6648, MAX6649,=
 MAX6657, MAX6658, MAX6659,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX6680, M=
AX6681, MAX6692, MAX6695, MAX6696, ON Semiconductor NCT1008,<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 and Winbond/Nuvoton W83L771W/G/AWG/ASG sensor chips.<b=
r>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 Winbond/Nuvoton W83L771W/G/AWG/ASG and Philip=
s SA56004 sensor chips.<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This drive=
r can also be built as a module. =C2=A0If so, the module<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0will be called lm90.<br>diff --git a/drivers/hwmon/lm90=
.c b/drivers/hwmon/lm90.c<br>
index 2f94f95..01b38a0 100644<br>--- a/drivers/hwmon/lm90.c<br>+++ b/driver=
s/hwmon/lm90.c<br>@@ -54,6 +54,9 @@<br>=C2=A0* and extended mode. They are =
mostly compatible with LM90 except for a data<br>=C2=A0* format difference =
for the temperature value registers.<br>
=C2=A0*<br>+ * This driver also supports the SA56004 from Philips. This dev=
ice is<br>+ * pin-compatible with the LM86, the ED/EDP parts are also addre=
ss-compatible.<br>+ *<br>=C2=A0* Since the LM90 was the first chipset suppo=
rted by this driver, most<br>
=C2=A0* comments will refer to this chipset, but are actually general and<b=
r>=C2=A0* concern all supported chipsets, unless mentioned otherwise.<br>@@=
 -96,13 +99,15 @@<br>=C2=A0* MAX6659 can have address 0x4c, 0x4d or 0x4e.<b=
r>=C2=A0* MAX6680 and MAX6681 can have address 0x18, 0x19, 0x1a, 0x29, 0x2a=
, 0x2b,<br>
=C2=A0* 0x4c, 0x4d or 0x4e.<br>+ * SA56004 can have address 0x48 through 0x=
4F.<br>=C2=A0*/<br><br>=C2=A0static const unsigned short normal_i2c[] =3D {=
<br>- =C2=A0 =C2=A0 =C2=A0 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, =
0x4e, I2C_CLIENT_END };<br>+ =C2=A0 =C2=A0 =C2=A0 0x18, 0x19, 0x1a, 0x29, 0=
x2a, 0x2b, 0x48, 0x49, 0x4a, 0x4b, 0x4c,<br>
+ =C2=A0 =C2=A0 =C2=A0 0x4d, 0x4e, 0x4f, I2C_CLIENT_END };<br><br>=C2=A0enu=
m chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,<br=
>- =C2=A0 =C2=A0 =C2=A0 max6646, w83l771, max6696 };<br>+ =C2=A0 =C2=A0 =C2=
=A0 max6646, w83l771, max6696, sa56004 };<br><br>
=C2=A0/*<br>=C2=A0* The LM90 registers<br>@@ -152,6 +157,10 @@ enum chips {=
 lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,<br>=C2=A0#d=
efine MAX6659_REG_R_LOCAL_EMERG =C2=A0 =C2=A0 =C2=A00x17<br>=C2=A0#define M=
AX6659_REG_W_LOCAL_EMERG =C2=A0 =C2=A0 =C2=A00x17<br>
<br>+/* =C2=A0SA56004 registers */<br>+<br>+#define SA56004_REG_R_LOCAL_TEM=
PL 0x22<br>+<br>=C2=A0#define LM90_DEF_CONVRATE_RVAL 6 =C2=A0 =C2=A0 =C2=A0=
 /* Def conversion rate register value */<br>=C2=A0#define LM90_MAX_CONVRAT=
E_MS =C2=A0 16000 =C2=A0 /* Maximum conversion rate in ms */<br>
<br>@@ -192,6 +201,7 @@ static const struct i2c_device_id lm90_id[] =3D {<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;max6696&quot;, max6696 },<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0{ &quot;nct1008&quot;, adt7461 },<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0{ &quot;w83l771&quot;, w83l771 },<br>+ =C2=A0 =C2=A0 =C2=A0 { &qu=
ot;sa56004&quot;, sa56004 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0{ }<br>=C2=A0};<br>=C2=A0MODULE_DEVICE_TABLE(i2c=
, lm90_id);<br>@@ -204,6 +214,8 @@ struct lm90_params {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0u16 alert_alarms; =C2=A0 =C2=A0 =C2=A0 /* Which alarm bits tri=
gger ALERT# */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Upper 8 bits for =
max6695/96 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 max_convrate; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* M=
aximum conversion rate register value */<br>+ =C2=A0 =C2=A0 =C2=A0 u8 reg_l=
ocal_ext; =C2=A0 =C2=A0 =C2=A0 /* Local extension register if<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LM90_HAVE_LOCAL_EXT is set*/<br>=C2=
=A0};<br><br>
=C2=A0static const struct lm90_params lm90_params[] =3D {<br>@@ -238,6 +250=
,7 @@ static const struct lm90_params lm90_params[] =3D {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D LM90_HAVE_LOCAL_EXT,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.alert_alarms =3D 0=
x7c,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.max_convrat=
e =3D 6,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .reg_local_ext =3D MAX66=
57_REG_R_LOCAL_TEMPL,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0[max6657] =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.flags =3D LM90_HAVE_LOCAL_EXT,<br>@@ -248,6 +261,7 @@ static con=
st struct lm90_params lm90_params[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D LM90_HAVE=
_LOCAL_EXT | LM90_HAVE_EMERGENCY,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.alert_alarms =3D 0x7c,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.max_convrate =3D 8,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .reg_local_ext =3D MAX6657_REG_R_LOCAL_TEMPL,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0[max6680] =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D LM90_HAVE_OFFSET,<br>@@ -259,12 +273,=
20 @@ static const struct lm90_params lm90_params[] =3D {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| LM90_HAVE_EMERGENCY_ALARM=
 | LM90_HAVE_TEMP3,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.alert_alarms =3D 0x187c,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.max_convrate =3D 6,=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .reg_local_ext =3D M=
AX6657_REG_R_LOCAL_TEMPL,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0[w83l771] =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.flags =3D LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.alert_alarms =3D 0x7c,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.max_convrate =3D 8,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>+ =C2=A0 =C2=A0 =C2=A0 [sa56004] =3D {=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D LM90_HAVE=
_OFFSET | LM90_HAVE_REM_LIMIT_EXT<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | LM90_HAVE_LOCAL_EXT,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .alert_alarms =3D 0x7b,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_convrate =3D 9,<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .reg_local_ext =3D SA560=
04_REG_R_LOCAL_TEMPL,<br>+ =C2=A0 =C2=A0 =C2=A0 },<br>=C2=A0};<br><br>=C2=
=A0/*<br>@@ -286,6 +308,7 @@ struct lm90_data {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0u16 alert_alarms; =C2=A0 =C2=A0 =C2=A0 /* Which alarm bits trigger ALERT=
# */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Upper 8 bits for max6695/96 */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 max_convrate; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* M=
aximum conversion rate */<br>+ =C2=A0 =C2=A0 =C2=A0 u8 reg_local_ext; =C2=
=A0 =C2=A0 =C2=A0 /* local extension register offset */<br><br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* registers values */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0s8 temp8[8]; =C2=A0 =C2=A0/* 0: local low limit<=
br>@@ -454,7 +477,7 @@ static struct lm90_data *lm90_update_device(struct d=
evice *dev)<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (data-&gt;flags &amp; LM90_HAVE_LOCAL_EXT) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lm90_read16(clie=
nt, LM90_REG_R_LOCAL_TEMP,<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAX6657_REG_R_LOCAL_TEMPL,<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;reg_local_ext,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;data-&gt;temp11[4]=
);<br></blockquote>
<div>I don&#39;t think this variable reg_local_ext should exist as </div>
<div>register address should be &quot;# defined&quot; and should not be</di=
v>
<div>part of lm90_data but i do see a case here where we are</div>
<div>assuming MAX6657 is only having this LM90_HAVE_LOCAL_EXT</div>
<div>flag set.So i think we should have some more branching here</div>
<div>to detect the device and pass the corresponding register but as</div>
<div>i said i am no expert.</div>
<div>=C2=A0</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (lm90_read_reg(client, LM90_REG_R_LOCAL_TEMP,<br>@@ -1263,6 +1286,=
11 @@ static int lm90_detect(struct i2c_client *new_client,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D &quot;w83l771&quot;;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =
=C2=A0 =C2=A0 =C2=A0 } else<br>+ =C2=A0 =C2=A0 =C2=A0 if (man_id =3D=3D 0xA=
1) { /* =C2=A0NXP Semiconductor/Philips */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 if (chip_id =3D=3D 0x00 &amp;&amp; address &gt;=3D 0x=
48 &amp;&amp; address &lt;=3D 0x4F) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 name =3D &quot;sa56004&quot;;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!name) { /* identification failed */<br>@@ -1372,6 +1400,11 @@ s=
tatic int lm90_probe(struct i2c_client *new_client,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set maximum conversion rate */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0data-&gt;max_convrate =3D lm90_params[data-&gt;kind].max_c=
onvrate;<br><br>+ =C2=A0 =C2=A0 =C2=A0 if (data-&gt;flags &amp; LM90_HAVE_L=
OCAL_EXT) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;=
reg_local_ext =3D lm90_params[data-&gt;kind].reg_local_ext;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG_ON(data-&gt;reg_loca=
l_ext =3D=3D 0);<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>+<br></blockquote>
<div>I think this BUG_ON is too harsh in probe.We generally use pr_err</div=
>
<div>to print if something which is supposed to be set is not set.As BUG_ON=
</div>
<div>will call kernel panic,right?</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0/* Initialize the LM90 chip */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0lm=
90_init_client(new_client);<br><br>--<br>1.7.3.3<br><font color=3D"#888888"=
><br>
--<br>To unsubscribe from this list: send the line &quot;unsubscribe linux-=
kernel&quot; in<br>the body of a message to <a href=3D"mailto:majordomo@vge=
r.kernel.org">majordomo@vger.kernel.org</a><br>More majordomo info at =C2=
=A0<a href=3D"http://vger.kernel.org/majordomo-info.html" target=3D"_blank"=
>http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =C2=A0<a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br></font></blockquote></div><br>

--001485f1a094c9662b04a4e2dfb7--


--===============1834655804911198524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1834655804911198524==--
