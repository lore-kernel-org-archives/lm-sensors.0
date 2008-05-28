From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 28 May 2008 01:02:18 +0000
Subject: Re: [lm-sensors] [PATCH 05/10] hwmon: (lm85) Misc cleanups
Message-Id: <191fb4ca0805271802v59e9b9e3x46d39373a1e86945@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0935745751670722366=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0935745751670722366==
Content-Type: multipart/alternative; 
	boundary="----=_Part_2874_10885277.1211936538496"

------=_Part_2874_10885277.1211936538496
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks good.

Acked-by: Juerg Haefliger <juergh at gmail.com>


On Sat, Apr 12, 2008 at 10:57 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Misc cleanups to the lm85 hardware monitoring driver:
> * Mark constant arrays as const.
> * Remove useless masks.
> * Have lm85_write_value return void - nobody is checking the returned
>  value anyway and in some cases it was plain wrong.
> * Remove useless initializations.
> * Rename new_client to client in lm85_detect.
> * Replace cascaded if/else with a switch/case in lm85_detect.
> * Group similar loops in lm85_update_device.
> * Remove legacy comments.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm85.c |  151
> ++++++++++++++++++++++----------------------------
>  1 file changed, 67 insertions(+), 84 deletions(-)
>
> --- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c  2008-04-03
> 14:18:50.000000000 +0200
> +++ linux-2.6.25-rc8/drivers/hwmon/lm85.c       2008-04-03
> 15:27:45.000000000 +0200
> @@ -110,7 +110,7 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
>  */
>
>  /* IN are scaled acording to built-in resistors */
> -static int lm85_scaling[] = {  /* .001 Volts */
> +static const int lm85_scaling[] = {  /* .001 Volts */
>        2500, 2250, 3300, 5000, 12000,
>        3300, 1500, 1800 /*EMC6D100*/
>  };
> @@ -164,7 +164,7 @@ static inline u16 FAN_TO_REG(unsigned lo
>  */
>
>  /* These are the zone temperature range encodings in .001 degree C */
> -static int lm85_range_map[] = {
> +static const int lm85_range_map[] = {
>        2000,  2500,  3300,  4000,  5000,  6600,
>        8000, 10000, 13300, 16000, 20000, 26600,
>        32000, 40000, 53300, 80000
> @@ -191,13 +191,8 @@ static int RANGE_TO_REG(int range)
>  }
>  #define RANGE_FROM_REG(val)    lm85_range_map[(val) & 0x0f]
>
> -/* These are the Acoustic Enhancement, or Temperature smoothing encodings
> - * NOTE: The enable/disable bit is INCLUDED in these encodings as the
> - *       MSB (bit 3, value 8).  If the enable bit is 0, the encoded value
> - *       is ignored, or set to 0.
> - */
>  /* These are the PWM frequency encodings */
> -static int lm85_freq_map[] = { /* .1 Hz */
> +static const int lm85_freq_map[] = { /* .1 Hz */
>        100, 150, 230, 300, 380, 470, 620, 940
>  };
>
> @@ -210,7 +205,7 @@ static int FREQ_TO_REG(int freq)
>        for (i = 0; i < 7; ++i)
>                if (freq <= lm85_freq_map[i])
>                        break;
> -       return i & 0x07;
> +       return i;
>  }
>  #define FREQ_FROM_REG(val)     lm85_freq_map[(val) & 0x07]
>
> @@ -226,8 +221,8 @@ static int FREQ_TO_REG(int freq)
>  *     -2 -- PWM responds to manual control
>  */
>
> -static int lm85_zone_map[] = { 1, 2, 3, -1, 0, 23, 123, -2 };
> -#define ZONE_FROM_REG(val)     lm85_zone_map[((val) >> 5) & 0x07]
> +static const int lm85_zone_map[] = { 1, 2, 3, -1, 0, 23, 123, -2 };
> +#define ZONE_FROM_REG(val)     lm85_zone_map[(val) >> 5]
>
>  static int ZONE_TO_REG(int zone)
>  {
> @@ -238,7 +233,7 @@ static int ZONE_TO_REG(int zone)
>                        break;
>        if (i > 7)   /* Not found. */
>                i = 3;  /* Always 100% */
> -       return (i & 0x07) << 5;
> +       return i << 5;
>  }
>
>  #define HYST_TO_REG(val)       SENSORS_LIMIT(((val) + 500) / 1000, 0, 15)
> @@ -322,7 +317,7 @@ static int lm85_detect(struct i2c_adapte
>  static int lm85_detach_client(struct i2c_client *client);
>
>  static int lm85_read_value(struct i2c_client *client, u8 reg);
> -static int lm85_write_value(struct i2c_client *client, u8 reg, int value);
> +static void lm85_write_value(struct i2c_client *client, u8 reg, int
> value);
>  static struct lm85_data *lm85_update_device(struct device *dev);
>  static void lm85_init_client(struct i2c_client *client);
>
> @@ -1096,13 +1091,12 @@ static int lm85_detect(struct i2c_adapte
>                int kind)
>  {
>        int company, verstep;
> -       struct i2c_client *new_client = NULL;
> +       struct i2c_client *client;
>        struct lm85_data *data;
>        int err = 0;
> -       const char *type_name = "";
> +       const char *type_name;
>
> -       if (!i2c_check_functionality(adapter,
> -                                       I2C_FUNC_SMBUS_BYTE_DATA)) {
> +       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
>                /* We need to be able to do byte I/O */
>                goto ERROR0;
>        }
> @@ -1116,21 +1110,20 @@ static int lm85_detect(struct i2c_adapte
>                goto ERROR0;
>        }
>
> -       new_client = &data->client;
> -       i2c_set_clientdata(new_client, data);
> -       new_client->addr = address;
> -       new_client->adapter = adapter;
> -       new_client->driver = &lm85_driver;
> -       new_client->flags = 0;
> +       client = &data->client;
> +       i2c_set_clientdata(client, data);
> +       client->addr = address;
> +       client->adapter = adapter;
> +       client->driver = &lm85_driver;
>
>        /* Now, we do the remaining detection. */
>
> -       company = lm85_read_value(new_client, LM85_REG_COMPANY);
> -       verstep = lm85_read_value(new_client, LM85_REG_VERSTEP);
> +       company = lm85_read_value(client, LM85_REG_COMPANY);
> +       verstep = lm85_read_value(client, LM85_REG_VERSTEP);
>
>        dev_dbg(&adapter->dev, "Detecting device at %d,0x%02x with"
>                " COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
> -               i2c_adapter_id(new_client->adapter), new_client->addr,
> +               i2c_adapter_id(client->adapter), client->addr,
>                company, verstep);
>
>        /* If auto-detecting, Determine the chip type. */
> @@ -1197,56 +1190,65 @@ static int lm85_detect(struct i2c_adapte
>        }
>
>        /* Fill in the chip specific driver values */
> -       if (kind == any_chip)
> -               type_name = "lm85";
> -       else if (kind == lm85b)
> +       switch (kind) {
> +       case lm85b:
>                type_name = "lm85b";
> -       else if (kind == lm85c)
> +               break;
> +       case lm85c:
>                type_name = "lm85c";
> -       else if (kind == adm1027)
> +               break;
> +       case adm1027:
>                type_name = "adm1027";
> -       else if (kind == adt7463)
> +               break;
> +       case adt7463:
>                type_name = "adt7463";
> -       else if (kind == emc6d100)
> +               break;
> +       case emc6d100:
>                type_name = "emc6d100";
> -       else if (kind == emc6d102)
> +               break;
> +       case emc6d102:
>                type_name = "emc6d102";
> -       strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
> +               break;
> +       default:
> +               type_name = "lm85";
> +       }
> +       strlcpy(client->name, type_name, I2C_NAME_SIZE);
>
>        /* Fill in the remaining client fields */
>        data->type = kind;
> -       data->valid = 0;
>        mutex_init(&data->update_lock);
>
>        /* Tell the I2C layer a new client has arrived */
> -       if ((err = i2c_attach_client(new_client)))
> +       err = i2c_attach_client(client);
> +       if (err)
>                goto ERROR1;
>
>        /* Set the VRM version */
>        data->vrm = vid_which_vrm();
>
>        /* Initialize the LM85 chip */
> -       lm85_init_client(new_client);
> +       lm85_init_client(client);
>
>        /* Register sysfs hooks */
> -       if ((err = sysfs_create_group(&new_client->dev.kobj, &lm85_group)))
> +       err = sysfs_create_group(&client->dev.kobj, &lm85_group);
> +       if (err)
>                goto ERROR2;
>
>        /* The ADT7463 has an optional VRM 10 mode where pin 21 is used
>           as a sixth digital VID input rather than an analog input. */
> -       data->vid = lm85_read_value(new_client, LM85_REG_VID);
> +       data->vid = lm85_read_value(client, LM85_REG_VID);
>        if (!(kind == adt7463 && (data->vid & 0x80)))
> -               if ((err = sysfs_create_group(&new_client->dev.kobj,
> +               if ((err = sysfs_create_group(&client->dev.kobj,
>                                        &lm85_group_in4)))
>                        goto ERROR3;
>
>        /* The EMC6D100 has 3 additional voltage inputs */
>        if (kind == emc6d100)
> -               if ((err = sysfs_create_group(&new_client->dev.kobj,
> +               if ((err = sysfs_create_group(&client->dev.kobj,
>                                        &lm85_group_in567)))
>                        goto ERROR3;
>
> -       data->hwmon_dev = hwmon_device_register(&new_client->dev);
> +       data->hwmon_dev = hwmon_device_register(&client->dev);
>        if (IS_ERR(data->hwmon_dev)) {
>                err = PTR_ERR(data->hwmon_dev);
>                goto ERROR3;
> @@ -1256,12 +1258,12 @@ static int lm85_detect(struct i2c_adapte
>
>        /* Error out and cleanup code */
>  ERROR3:
> -       sysfs_remove_group(&new_client->dev.kobj, &lm85_group);
> -       sysfs_remove_group(&new_client->dev.kobj, &lm85_group_in4);
> +       sysfs_remove_group(&client->dev.kobj, &lm85_group);
> +       sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
>        if (kind == emc6d100)
> -               sysfs_remove_group(&new_client->dev.kobj,
> &lm85_group_in567);
> +               sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
>  ERROR2:
> -       i2c_detach_client(new_client);
> +       i2c_detach_client(client);
>  ERROR1:
>        kfree(data);
>  ERROR0:
> @@ -1308,10 +1310,8 @@ static int lm85_read_value(struct i2c_cl
>        return res;
>  }
>
> -static int lm85_write_value(struct i2c_client *client, u8 reg, int value)
> +static void lm85_write_value(struct i2c_client *client, u8 reg, int value)
>  {
> -       int res;
> -
>        switch (reg) {
>        case LM85_REG_FAN(0):  /* Write WORD data */
>        case LM85_REG_FAN(1):
> @@ -1322,16 +1322,13 @@ static int lm85_write_value(struct i2c_c
>        case LM85_REG_FAN_MIN(2):
>        case LM85_REG_FAN_MIN(3):
>        /* NOTE: ALARM is read only, so not included here */
> -               res = i2c_smbus_write_byte_data(client, reg, value & 0xff);
> -               res |= i2c_smbus_write_byte_data(client, reg + 1,
> -                                                (value >> 8) & 0xff);
> +               i2c_smbus_write_byte_data(client, reg, value & 0xff);
> +               i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
>                break;
>        default:        /* Write BYTE data */
> -               res = i2c_smbus_write_byte_data(client, reg, value);
> +               i2c_smbus_write_byte_data(client, reg, value);
>                break;
>        }
> -
> -       return res;
>  }
>
>  static void lm85_init_client(struct i2c_client *client)
> @@ -1413,6 +1410,8 @@ static struct lm85_data *lm85_update_dev
>                for (i = 0; i <= 3; ++i) {
>                        data->in[i] =
>                            lm85_read_value(client, LM85_REG_IN(i));
> +                       data->fan[i] =
> +                           lm85_read_value(client, LM85_REG_FAN(i));
>                }
>
>                if (!(data->type == adt7463 && (data->vid & 0x80))) {
> @@ -1420,17 +1419,9 @@ static struct lm85_data *lm85_update_dev
>                                      LM85_REG_IN(4));
>                }
>
> -               for (i = 0; i <= 3; ++i) {
> -                       data->fan[i] =
> -                           lm85_read_value(client, LM85_REG_FAN(i));
> -               }
> -
>                for (i = 0; i <= 2; ++i) {
>                        data->temp[i] =
>                            lm85_read_value(client, LM85_REG_TEMP(i));
> -               }
> -
> -               for (i = 0; i <= 2; ++i) {
>                        data->pwm[i] =
>                            lm85_read_value(client, LM85_REG_PWM(i));
>                }
> @@ -1461,13 +1452,13 @@ static struct lm85_data *lm85_update_dev
>
> EMC6D102_REG_EXTEND_ADC4);
>                        data->in_ext[0] = ext3 & 0x0f;
>                        data->in_ext[1] = ext4 & 0x0f;
> -                       data->in_ext[2] = (ext4 >> 4) & 0x0f;
> -                       data->in_ext[3] = (ext3 >> 4) & 0x0f;
> -                       data->in_ext[4] = (ext2 >> 4) & 0x0f;
> +                       data->in_ext[2] = ext4 >> 4;
> +                       data->in_ext[3] = ext3 >> 4;
> +                       data->in_ext[4] = ext2 >> 4;
>
>                        data->temp_ext[0] = ext1 & 0x0f;
>                        data->temp_ext[1] = ext2 & 0x0f;
> -                       data->temp_ext[2] = (ext1 >> 4) & 0x0f;
> +                       data->temp_ext[2] = ext1 >> 4;
>                }
>
>                data->last_reading = jiffies;
> @@ -1483,6 +1474,8 @@ static struct lm85_data *lm85_update_dev
>                            lm85_read_value(client, LM85_REG_IN_MIN(i));
>                        data->in_max[i] =
>                            lm85_read_value(client, LM85_REG_IN_MAX(i));
> +                       data->fan_min[i] =
> +                           lm85_read_value(client, LM85_REG_FAN_MIN(i));
>                }
>
>                if (!(data->type == adt7463 && (data->vid & 0x80))) {
> @@ -1501,25 +1494,19 @@ static struct lm85_data *lm85_update_dev
>                        }
>                }
>
> -               for (i = 0; i <= 3; ++i) {
> -                       data->fan_min[i] =
> -                           lm85_read_value(client, LM85_REG_FAN_MIN(i));
> -               }
> -
>                for (i = 0; i <= 2; ++i) {
> +                       int val;
> +
>                        data->temp_min[i] =
>                            lm85_read_value(client, LM85_REG_TEMP_MIN(i));
>                        data->temp_max[i] =
>                            lm85_read_value(client, LM85_REG_TEMP_MAX(i));
> -               }
>
> -               for (i = 0; i <= 2; ++i) {
> -                       int val;
>                        data->autofan[i].config =
>                            lm85_read_value(client,
> LM85_REG_AFAN_CONFIG(i));
>                        val = lm85_read_value(client,
> LM85_REG_AFAN_RANGE(i));
>                        data->autofan[i].freq = val & 0x07;
> -                       data->zone[i].range = (val >> 4) & 0x0f;
> +                       data->zone[i].range = val >> 4;
>                        data->autofan[i].min_pwm =
>                            lm85_read_value(client,
> LM85_REG_AFAN_MINPWM(i));
>                        data->zone[i].limit =
> @@ -1534,11 +1521,11 @@ static struct lm85_data *lm85_update_dev
>                data->autofan[2].min_off = (i & 0x80) != 0;
>
>                i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
> -               data->zone[0].hyst = (i>>4) & 0x0f;
> +               data->zone[0].hyst = i >> 4;
>                data->zone[1].hyst = i & 0x0f;
>
>                i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
> -               data->zone[2].hyst = (i>>4) & 0x0f;
> +               data->zone[2].hyst = i >> 4;
>
>                data->last_config = jiffies;
>        }  /* last_config */
> @@ -1561,14 +1548,10 @@ static void  __exit sm_lm85_exit(void)
>        i2c_del_driver(&lm85_driver);
>  }
>
> -/* Thanks to Richard Barrington for adding the LM85 to sensors-detect.
> - * Thanks to Margit Schubert-While <margitsw@t-online.de> for help with
> - *     post 2.7.0 CVS changes.
> - */
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, "
>        "Margit Schubert-While <margitsw@t-online.de>, "
> -       "Justin Thiessen <jthiessen@penguincomputing.com");
> +       "Justin Thiessen <jthiessen@penguincomputing.com>");
>  MODULE_DESCRIPTION("LM85-B, LM85-C driver");
>
>  module_init(sm_lm85_init);
>
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

------=_Part_2874_10885277.1211936538496
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks good.<br><br>Acked-by: Juerg Haefliger &lt;juergh at <a href="http://gmail.com">gmail.com</a>&gt;<br><br><br><div class="gmail_quote">On Sat, Apr 12, 2008 at 10:57 AM, Jean Delvare &lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Misc cleanups to the lm85 hardware monitoring driver:<br>
* Mark constant arrays as const.<br>
* Remove useless masks.<br>
* Have lm85_write_value return void - nobody is checking the returned<br>
 &nbsp;value anyway and in some cases it was plain wrong.<br>
* Remove useless initializations.<br>
* Rename new_client to client in lm85_detect.<br>
* Replace cascaded if/else with a switch/case in lm85_detect.<br>
* Group similar loops in lm85_update_device.<br>
* Remove legacy comments.<br>
<br>
Signed-off-by: Jean Delvare &lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;<br>
---<br>
&nbsp;drivers/hwmon/lm85.c | &nbsp;151 ++++++++++++++++++++++----------------------------<br>
&nbsp;1 file changed, 67 insertions(+), 84 deletions(-)<br>
<br>
--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c &nbsp;2008-04-03 14:18:50.000000000 +0200<br>
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c &nbsp; &nbsp; &nbsp; 2008-04-03 15:27:45.000000000 +0200<br>
@@ -110,7 +110,7 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102<br>
 &nbsp;*/<br>
<br>
&nbsp;/* IN are scaled acording to built-in resistors */<br>
-static int lm85_scaling[] = { &nbsp;/* .001 Volts */<br>
+static const int lm85_scaling[] = { &nbsp;/* .001 Volts */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;2500, 2250, 3300, 5000, 12000,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;3300, 1500, 1800 /*EMC6D100*/<br>
&nbsp;};<br>
@@ -164,7 +164,7 @@ static inline u16 FAN_TO_REG(unsigned lo<br>
 &nbsp;*/<br>
<br>
&nbsp;/* These are the zone temperature range encodings in .001 degree C */<br>
-static int lm85_range_map[] = {<br>
+static const int lm85_range_map[] = {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;2000, &nbsp;2500, &nbsp;3300, &nbsp;4000, &nbsp;5000, &nbsp;6600,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;8000, 10000, 13300, 16000, 20000, 26600,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;32000, 40000, 53300, 80000<br>
@@ -191,13 +191,8 @@ static int RANGE_TO_REG(int range)<br>
&nbsp;}<br>
&nbsp;#define RANGE_FROM_REG(val) &nbsp; &nbsp;lm85_range_map[(val) &amp; 0x0f]<br>
<br>
-/* These are the Acoustic Enhancement, or Temperature smoothing encodings<br>
- * NOTE: The enable/disable bit is INCLUDED in these encodings as the<br>
- * &nbsp; &nbsp; &nbsp; MSB (bit 3, value 8). &nbsp;If the enable bit is 0, the encoded value<br>
- * &nbsp; &nbsp; &nbsp; is ignored, or set to 0.<br>
- */<br>
&nbsp;/* These are the PWM frequency encodings */<br>
-static int lm85_freq_map[] = { /* .1 Hz */<br>
+static const int lm85_freq_map[] = { /* .1 Hz */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;100, 150, 230, 300, 380, 470, 620, 940<br>
&nbsp;};<br>
<br>
@@ -210,7 +205,7 @@ static int FREQ_TO_REG(int freq)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;for (i = 0; i &lt; 7; ++i)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (freq &lt;= lm85_freq_map[i])<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
- &nbsp; &nbsp; &nbsp; return i &amp; 0x07;<br>
+ &nbsp; &nbsp; &nbsp; return i;<br>
&nbsp;}<br>
&nbsp;#define FREQ_FROM_REG(val) &nbsp; &nbsp; lm85_freq_map[(val) &amp; 0x07]<br>
<br>
@@ -226,8 +221,8 @@ static int FREQ_TO_REG(int freq)<br>
 &nbsp;* &nbsp; &nbsp; -2 -- PWM responds to manual control<br>
 &nbsp;*/<br>
<br>
-static int lm85_zone_map[] = { 1, 2, 3, -1, 0, 23, 123, -2 };<br>
-#define ZONE_FROM_REG(val) &nbsp; &nbsp; lm85_zone_map[((val) &gt;&gt; 5) &amp; 0x07]<br>
+static const int lm85_zone_map[] = { 1, 2, 3, -1, 0, 23, 123, -2 };<br>
+#define ZONE_FROM_REG(val) &nbsp; &nbsp; lm85_zone_map[(val) &gt;&gt; 5]<br>
<br>
&nbsp;static int ZONE_TO_REG(int zone)<br>
&nbsp;{<br>
@@ -238,7 +233,7 @@ static int ZONE_TO_REG(int zone)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (i &gt; 7) &nbsp; /* Not found. */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;i = 3; &nbsp;/* Always 100% */<br>
- &nbsp; &nbsp; &nbsp; return (i &amp; 0x07) &lt;&lt; 5;<br>
+ &nbsp; &nbsp; &nbsp; return i &lt;&lt; 5;<br>
&nbsp;}<br>
<br>
&nbsp;#define HYST_TO_REG(val) &nbsp; &nbsp; &nbsp; SENSORS_LIMIT(((val) + 500) / 1000, 0, 15)<br>
@@ -322,7 +317,7 @@ static int lm85_detect(struct i2c_adapte<br>
&nbsp;static int lm85_detach_client(struct i2c_client *client);<br>
<br>
&nbsp;static int lm85_read_value(struct i2c_client *client, u8 reg);<br>
-static int lm85_write_value(struct i2c_client *client, u8 reg, int value);<br>
+static void lm85_write_value(struct i2c_client *client, u8 reg, int value);<br>
&nbsp;static struct lm85_data *lm85_update_device(struct device *dev);<br>
&nbsp;static void lm85_init_client(struct i2c_client *client);<br>
<br>
@@ -1096,13 +1091,12 @@ static int lm85_detect(struct i2c_adapte<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int kind)<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;int company, verstep;<br>
- &nbsp; &nbsp; &nbsp; struct i2c_client *new_client = NULL;<br>
+ &nbsp; &nbsp; &nbsp; struct i2c_client *client;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct lm85_data *data;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;int err = 0;<br>
- &nbsp; &nbsp; &nbsp; const char *type_name = &quot;&quot;;<br>
+ &nbsp; &nbsp; &nbsp; const char *type_name;<br>
<br>
- &nbsp; &nbsp; &nbsp; if (!i2c_check_functionality(adapter,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; I2C_FUNC_SMBUS_BYTE_DATA)) {<br>
+ &nbsp; &nbsp; &nbsp; if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* We need to be able to do byte I/O */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto ERROR0;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
@@ -1116,21 +1110,20 @@ static int lm85_detect(struct i2c_adapte<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto ERROR0;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
- &nbsp; &nbsp; &nbsp; new_client = &amp;data-&gt;client;<br>
- &nbsp; &nbsp; &nbsp; i2c_set_clientdata(new_client, data);<br>
- &nbsp; &nbsp; &nbsp; new_client-&gt;addr = address;<br>
- &nbsp; &nbsp; &nbsp; new_client-&gt;adapter = adapter;<br>
- &nbsp; &nbsp; &nbsp; new_client-&gt;driver = &amp;lm85_driver;<br>
- &nbsp; &nbsp; &nbsp; new_client-&gt;flags = 0;<br>
+ &nbsp; &nbsp; &nbsp; client = &amp;data-&gt;client;<br>
+ &nbsp; &nbsp; &nbsp; i2c_set_clientdata(client, data);<br>
+ &nbsp; &nbsp; &nbsp; client-&gt;addr = address;<br>
+ &nbsp; &nbsp; &nbsp; client-&gt;adapter = adapter;<br>
+ &nbsp; &nbsp; &nbsp; client-&gt;driver = &amp;lm85_driver;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Now, we do the remaining detection. */<br>
<br>
- &nbsp; &nbsp; &nbsp; company = lm85_read_value(new_client, LM85_REG_COMPANY);<br>
- &nbsp; &nbsp; &nbsp; verstep = lm85_read_value(new_client, LM85_REG_VERSTEP);<br>
+ &nbsp; &nbsp; &nbsp; company = lm85_read_value(client, LM85_REG_COMPANY);<br>
+ &nbsp; &nbsp; &nbsp; verstep = lm85_read_value(client, LM85_REG_VERSTEP);<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;dev_dbg(&amp;adapter-&gt;dev, &quot;Detecting device at %d,0x%02x with&quot;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot; COMPANY: 0x%02x and VERSTEP: 0x%02x\n&quot;,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i2c_adapter_id(new_client-&gt;adapter), new_client-&gt;addr,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i2c_adapter_id(client-&gt;adapter), client-&gt;addr,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;company, verstep);<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* If auto-detecting, Determine the chip type. */<br>
@@ -1197,56 +1190,65 @@ static int lm85_detect(struct i2c_adapte<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Fill in the chip specific driver values */<br>
- &nbsp; &nbsp; &nbsp; if (kind == any_chip)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; type_name = &quot;lm85&quot;;<br>
- &nbsp; &nbsp; &nbsp; else if (kind == lm85b)<br>
+ &nbsp; &nbsp; &nbsp; switch (kind) {<br>
+ &nbsp; &nbsp; &nbsp; case lm85b:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;type_name = &quot;lm85b&quot;;<br>
- &nbsp; &nbsp; &nbsp; else if (kind == lm85c)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
+ &nbsp; &nbsp; &nbsp; case lm85c:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;type_name = &quot;lm85c&quot;;<br>
- &nbsp; &nbsp; &nbsp; else if (kind == adm1027)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
+ &nbsp; &nbsp; &nbsp; case adm1027:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;type_name = &quot;adm1027&quot;;<br>
- &nbsp; &nbsp; &nbsp; else if (kind == adt7463)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
+ &nbsp; &nbsp; &nbsp; case adt7463:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;type_name = &quot;adt7463&quot;;<br>
- &nbsp; &nbsp; &nbsp; else if (kind == emc6d100)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
+ &nbsp; &nbsp; &nbsp; case emc6d100:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;type_name = &quot;emc6d100&quot;;<br>
- &nbsp; &nbsp; &nbsp; else if (kind == emc6d102)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
+ &nbsp; &nbsp; &nbsp; case emc6d102:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;type_name = &quot;emc6d102&quot;;<br>
- &nbsp; &nbsp; &nbsp; strlcpy(new_client-&gt;name, type_name, I2C_NAME_SIZE);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
+ &nbsp; &nbsp; &nbsp; default:<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; type_name = &quot;lm85&quot;;<br>
+ &nbsp; &nbsp; &nbsp; }<br>
+ &nbsp; &nbsp; &nbsp; strlcpy(client-&gt;name, type_name, I2C_NAME_SIZE);<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Fill in the remaining client fields */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;type = kind;<br>
- &nbsp; &nbsp; &nbsp; data-&gt;valid = 0;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;mutex_init(&amp;data-&gt;update_lock);<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Tell the I2C layer a new client has arrived */<br>
- &nbsp; &nbsp; &nbsp; if ((err = i2c_attach_client(new_client)))<br>
+ &nbsp; &nbsp; &nbsp; err = i2c_attach_client(client);<br>
+ &nbsp; &nbsp; &nbsp; if (err)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto ERROR1;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Set the VRM version */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;vrm = vid_which_vrm();<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Initialize the LM85 chip */<br>
- &nbsp; &nbsp; &nbsp; lm85_init_client(new_client);<br>
+ &nbsp; &nbsp; &nbsp; lm85_init_client(client);<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Register sysfs hooks */<br>
- &nbsp; &nbsp; &nbsp; if ((err = sysfs_create_group(&amp;new_client-&gt;dev.kobj, &amp;lm85_group)))<br>
+ &nbsp; &nbsp; &nbsp; err = sysfs_create_group(&amp;client-&gt;dev.kobj, &amp;lm85_group);<br>
+ &nbsp; &nbsp; &nbsp; if (err)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto ERROR2;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* The ADT7463 has an optional VRM 10 mode where pin 21 is used<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; as a sixth digital VID input rather than an analog input. */<br>
- &nbsp; &nbsp; &nbsp; data-&gt;vid = lm85_read_value(new_client, LM85_REG_VID);<br>
+ &nbsp; &nbsp; &nbsp; data-&gt;vid = lm85_read_value(client, LM85_REG_VID);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (!(kind == adt7463 &amp;&amp; (data-&gt;vid &amp; 0x80)))<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if ((err = sysfs_create_group(&amp;new_client-&gt;dev.kobj,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if ((err = sysfs_create_group(&amp;client-&gt;dev.kobj,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&amp;lm85_group_in4)))<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto ERROR3;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* The EMC6D100 has 3 additional voltage inputs */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (kind == emc6d100)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if ((err = sysfs_create_group(&amp;new_client-&gt;dev.kobj,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if ((err = sysfs_create_group(&amp;client-&gt;dev.kobj,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&amp;lm85_group_in567)))<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto ERROR3;<br>
<br>
- &nbsp; &nbsp; &nbsp; data-&gt;hwmon_dev = hwmon_device_register(&amp;new_client-&gt;dev);<br>
+ &nbsp; &nbsp; &nbsp; data-&gt;hwmon_dev = hwmon_device_register(&amp;client-&gt;dev);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (IS_ERR(data-&gt;hwmon_dev)) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;err = PTR_ERR(data-&gt;hwmon_dev);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto ERROR3;<br>
@@ -1256,12 +1258,12 @@ static int lm85_detect(struct i2c_adapte<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Error out and cleanup code */<br>
 &nbsp;ERROR3:<br>
- &nbsp; &nbsp; &nbsp; sysfs_remove_group(&amp;new_client-&gt;dev.kobj, &amp;lm85_group);<br>
- &nbsp; &nbsp; &nbsp; sysfs_remove_group(&amp;new_client-&gt;dev.kobj, &amp;lm85_group_in4);<br>
+ &nbsp; &nbsp; &nbsp; sysfs_remove_group(&amp;client-&gt;dev.kobj, &amp;lm85_group);<br>
+ &nbsp; &nbsp; &nbsp; sysfs_remove_group(&amp;client-&gt;dev.kobj, &amp;lm85_group_in4);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (kind == emc6d100)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sysfs_remove_group(&amp;new_client-&gt;dev.kobj, &amp;lm85_group_in567);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sysfs_remove_group(&amp;client-&gt;dev.kobj, &amp;lm85_group_in567);<br>
 &nbsp;ERROR2:<br>
- &nbsp; &nbsp; &nbsp; i2c_detach_client(new_client);<br>
+ &nbsp; &nbsp; &nbsp; i2c_detach_client(client);<br>
 &nbsp;ERROR1:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;kfree(data);<br>
 &nbsp;ERROR0:<br>
@@ -1308,10 +1310,8 @@ static int lm85_read_value(struct i2c_cl<br>
 &nbsp; &nbsp; &nbsp; &nbsp;return res;<br>
&nbsp;}<br>
<br>
-static int lm85_write_value(struct i2c_client *client, u8 reg, int value)<br>
+static void lm85_write_value(struct i2c_client *client, u8 reg, int value)<br>
&nbsp;{<br>
- &nbsp; &nbsp; &nbsp; int res;<br>
-<br>
 &nbsp; &nbsp; &nbsp; &nbsp;switch (reg) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;case LM85_REG_FAN(0): &nbsp;/* Write WORD data */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;case LM85_REG_FAN(1):<br>
@@ -1322,16 +1322,13 @@ static int lm85_write_value(struct i2c_c<br>
 &nbsp; &nbsp; &nbsp; &nbsp;case LM85_REG_FAN_MIN(2):<br>
 &nbsp; &nbsp; &nbsp; &nbsp;case LM85_REG_FAN_MIN(3):<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* NOTE: ALARM is read only, so not included here */<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; res = i2c_smbus_write_byte_data(client, reg, value &amp; 0xff);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; res |= i2c_smbus_write_byte_data(client, reg + 1,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(value &gt;&gt; 8) &amp; 0xff);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i2c_smbus_write_byte_data(client, reg, value &amp; 0xff);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i2c_smbus_write_byte_data(client, reg + 1, value &gt;&gt; 8);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;default: &nbsp; &nbsp; &nbsp; &nbsp;/* Write BYTE data */<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; res = i2c_smbus_write_byte_data(client, reg, value);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i2c_smbus_write_byte_data(client, reg, value);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
- &nbsp; &nbsp; &nbsp; return res;<br>
&nbsp;}<br>
<br>
&nbsp;static void lm85_init_client(struct i2c_client *client)<br>
@@ -1413,6 +1410,8 @@ static struct lm85_data *lm85_update_dev<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for (i = 0; i &lt;= 3; ++i) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;in[i] =<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lm85_read_value(client, LM85_REG_IN(i));<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;fan[i] =<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lm85_read_value(client, LM85_REG_FAN(i));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!(data-&gt;type == adt7463 &amp;&amp; (data-&gt;vid &amp; 0x80))) {<br>
@@ -1420,17 +1419,9 @@ static struct lm85_data *lm85_update_dev<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;LM85_REG_IN(4));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (i = 0; i &lt;= 3; ++i) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;fan[i] =<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lm85_read_value(client, LM85_REG_FAN(i));<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
-<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for (i = 0; i &lt;= 2; ++i) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;temp[i] =<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lm85_read_value(client, LM85_REG_TEMP(i));<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
-<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (i = 0; i &lt;= 2; ++i) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;pwm[i] =<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lm85_read_value(client, LM85_REG_PWM(i));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
@@ -1461,13 +1452,13 @@ static struct lm85_data *lm85_update_dev<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; EMC6D102_REG_EXTEND_ADC4);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;in_ext[0] = ext3 &amp; 0x0f;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;in_ext[1] = ext4 &amp; 0x0f;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;in_ext[2] = (ext4 &gt;&gt; 4) &amp; 0x0f;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;in_ext[3] = (ext3 &gt;&gt; 4) &amp; 0x0f;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;in_ext[4] = (ext2 &gt;&gt; 4) &amp; 0x0f;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;in_ext[2] = ext4 &gt;&gt; 4;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;in_ext[3] = ext3 &gt;&gt; 4;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;in_ext[4] = ext2 &gt;&gt; 4;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;temp_ext[0] = ext1 &amp; 0x0f;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;temp_ext[1] = ext2 &amp; 0x0f;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;temp_ext[2] = (ext1 &gt;&gt; 4) &amp; 0x0f;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;temp_ext[2] = ext1 &gt;&gt; 4;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;last_reading = jiffies;<br>
@@ -1483,6 +1474,8 @@ static struct lm85_data *lm85_update_dev<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lm85_read_value(client, LM85_REG_IN_MIN(i));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;in_max[i] =<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lm85_read_value(client, LM85_REG_IN_MAX(i));<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;fan_min[i] =<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lm85_read_value(client, LM85_REG_FAN_MIN(i));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!(data-&gt;type == adt7463 &amp;&amp; (data-&gt;vid &amp; 0x80))) {<br>
@@ -1501,25 +1494,19 @@ static struct lm85_data *lm85_update_dev<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (i = 0; i &lt;= 3; ++i) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;fan_min[i] =<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lm85_read_value(client, LM85_REG_FAN_MIN(i));<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
-<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for (i = 0; i &lt;= 2; ++i) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int val;<br>
+<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;temp_min[i] =<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lm85_read_value(client, LM85_REG_TEMP_MIN(i));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;temp_max[i] =<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lm85_read_value(client, LM85_REG_TEMP_MAX(i));<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (i = 0; i &lt;= 2; ++i) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int val;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;autofan[i].config =<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;autofan[i].freq = val &amp; 0x07;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;zone[i].range = (val &gt;&gt; 4) &amp; 0x0f;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;zone[i].range = val &gt;&gt; 4;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;autofan[i].min_pwm =<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;zone[i].limit =<br>
@@ -1534,11 +1521,11 @@ static struct lm85_data *lm85_update_dev<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;autofan[2].min_off = (i &amp; 0x80) != 0;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;i = lm85_read_value(client, LM85_REG_AFAN_HYST1);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;zone[0].hyst = (i&gt;&gt;4) &amp; 0x0f;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;zone[0].hyst = i &gt;&gt; 4;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;zone[1].hyst = i &amp; 0x0f;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;i = lm85_read_value(client, LM85_REG_AFAN_HYST2);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;zone[2].hyst = (i&gt;&gt;4) &amp; 0x0f;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; data-&gt;zone[2].hyst = i &gt;&gt; 4;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;data-&gt;last_config = jiffies;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;} &nbsp;/* last_config */<br>
@@ -1561,14 +1548,10 @@ static void &nbsp;__exit sm_lm85_exit(void)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;i2c_del_driver(&amp;lm85_driver);<br>
&nbsp;}<br>
<br>
-/* Thanks to Richard Barrington for adding the LM85 to sensors-detect.<br>
- * Thanks to Margit Schubert-While &lt;<a href="mailto:margitsw@t-online.de">margitsw@t-online.de</a>&gt; for help with<br>
- * &nbsp; &nbsp; post 2.7.0 CVS changes.<br>
- */<br>
&nbsp;MODULE_LICENSE(&quot;GPL&quot;);<br>
&nbsp;MODULE_AUTHOR(&quot;Philip Pokorny &lt;<a href="mailto:ppokorny@penguincomputing.com">ppokorny@penguincomputing.com</a>&gt;, &quot;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;&quot;Margit Schubert-While &lt;<a href="mailto:margitsw@t-online.de">margitsw@t-online.de</a>&gt;, &quot;<br>
- &nbsp; &nbsp; &nbsp; &quot;Justin Thiessen &lt;<a href="mailto:jthiessen@penguincomputing.com">jthiessen@penguincomputing.com</a>&quot;);<br>
+ &nbsp; &nbsp; &nbsp; &quot;Justin Thiessen &lt;<a href="mailto:jthiessen@penguincomputing.com">jthiessen@penguincomputing.com</a>&gt;&quot;);<br>
&nbsp;MODULE_DESCRIPTION(&quot;LM85-B, LM85-C driver&quot;);<br>
<br>
&nbsp;module_init(sm_lm85_init);<br>
<font color="#888888"><br>
--<br>
Jean Delvare<br>
<br>
_______________________________________________<br>
lm-sensors mailing list<br>
<a href="mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><br>
<a href="http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target="_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
</font></blockquote></div><br>

------=_Part_2874_10885277.1211936538496--


--===============0935745751670722366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0935745751670722366==--
