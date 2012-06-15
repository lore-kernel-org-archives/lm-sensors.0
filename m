From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 15 Jun 2012 19:23:17 +0000
Subject: Re: [lm-sensors] [PATCH 66/95] hwmon: (pc87360) Convert to use devm_ functions
Message-Id: <CAJfuBxx=Z1f3QCavFLUq5gHNeiZvk4R7f61jn+Zj=gLLJk86aw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-67-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-67-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jun 15, 2012 at 9:23 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
>
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

root@voyage:~# ./sensors > after
pc87360 pc87360.26144: Data update
root@voyage:~# diff before after
8c8
< in5:          +2.50 V  (min =3D  +0.00 V, max =3D  +3.01 V)
---
> in5:          +2.49 V  (min =3D  +0.00 V, max =3D  +3.01 V)
root@voyage:~# ieee80211 phy0: wlan0: No probe response from AP
00:14:d1:e8:65:0a after 500ms, try 1/5




Tested-by: Jim Cromie <jim.cromie@gmail.com>



> ---
> =A0drivers/hwmon/pc87360.c | =A0 41 +++++++++++++------------------------=
----
> =A01 file changed, 13 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
> index 79ba48c..91d5b2a 100644
> --- a/drivers/hwmon/pc87360.c
> +++ b/drivers/hwmon/pc87360.c
> @@ -1230,7 +1230,7 @@ static int __devinit pc87360_probe(struct platform_=
device *pdev)
> =A0 =A0 =A0 =A0int use_thermistors =3D 0;
> =A0 =A0 =A0 =A0struct device *dev =3D &pdev->dev;
>
> - =A0 =A0 =A0 data =3D kzalloc(sizeof(struct pc87360_data), GFP_KERNEL);
> + =A0 =A0 =A0 data =3D devm_kzalloc(dev, sizeof(struct pc87360_data), GFP=
_KERNEL);
> =A0 =A0 =A0 =A0if (!data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> @@ -1269,15 +1269,12 @@ static int __devinit pc87360_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0for (i =3D 0; i < LDNI_MAX; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->address[i] =3D extra_isa[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data->address[i]
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& !request_region(extra_isa[i], PC87360=
_EXTENT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pc8=
7360_driver.driver.name)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& !devm_request_region(dev, extra_isa[i=
], PC87360_EXTENT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0pc87360_driver.driver.name)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Region 0x%x-=
0x%x already "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"in use!\n=
", extra_isa[i],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0extra_isa[=
i]+PC87360_EXTENT-1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i--; i >=3D 0; i--)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_reg=
ion(extra_isa[i], PC87360_EXTENT);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EBUSY;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> @@ -1325,13 +1322,13 @@ static int __devinit pc87360_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0if (data->innr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D sysfs_create_group(&dev->kobj, &pc=
8736x_vin_group);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (data->innr =3D=3D 14) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D sysfs_create_group(&dev->kobj, &pc=
8736x_therm_group);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* create device attr-files for varying sysfs groups */
> @@ -1341,11 +1338,11 @@ static int __devinit pc87360_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D sysfs_create_group=
(&dev->kobj,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 &pc8736x_temp_attr_group[i]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D device_create_file(dev, &dev_attr_=
alarms_temp);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < data->fannr; i++) {
> @@ -1353,49 +1350,37 @@ static int __devinit pc87360_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D sysfs_create_group=
(&dev->kobj,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 &pc8736x_fan_attr_group[i]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (FAN_CONFIG_CONTROL(data->fan_conf, i))=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D device_create_file=
(dev, &pwm[i].dev_attr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0err =3D device_create_file(dev, &dev_attr_name);
> =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>
> =A0 =A0 =A0 =A0data->hwmon_dev =3D hwmon_device_register(dev);
> =A0 =A0 =A0 =A0if (IS_ERR(data->hwmon_dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D PTR_ERR(data->hwmon_dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
>
> -ERROR3:
> +error:
> =A0 =A0 =A0 =A0pc87360_remove_files(dev);
> - =A0 =A0 =A0 for (i =3D 0; i < 3; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->address[i])
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_region(data->addres=
s[i], PC87360_EXTENT);
> - =A0 =A0 =A0 }
> -ERROR1:
> - =A0 =A0 =A0 kfree(data);
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> =A0static int __devexit pc87360_remove(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct pc87360_data *data =3D platform_get_drvdata(pdev);
> - =A0 =A0 =A0 int i;
>
> =A0 =A0 =A0 =A0hwmon_device_unregister(data->hwmon_dev);
> =A0 =A0 =A0 =A0pc87360_remove_files(&pdev->dev);
> - =A0 =A0 =A0 for (i =3D 0; i < 3; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->address[i])
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_region(data->addres=
s[i], PC87360_EXTENT);
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 kfree(data);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.7.9.7
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
