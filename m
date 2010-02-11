From: frollic nilsson <frollic@gmail.com>
Date: Thu, 11 Feb 2010 20:10:00 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <eb22c3ee1002111210m309f7112o2a6cb2529fdb9db8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

sorry, missed the reply to all button :\

with the extra code inserted, I get a AIDI =3D 1 in the logs

On Thu, Feb 11, 2010 at 5:25 PM, Luca Tettamanti <kronos.it@gmail.com> wrot=
e:
> Do not strip the CC!
>
> On Thu, Feb 11, 2010 at 04:36:53PM +0100, frollic nilsson wrote:
>> Well, I tried adding the #define DEBUG in the drivers/hwmon/asus_atk0110=
.c and
>> recompiling, but there wasn't any more output in the dmesg/messages.
>> They don't even say the driver gets loaded, but it's there if I list
>> it using lsmod.
>
> Ok, this means that ACPI core is not even calling the add method.
> I guess that I can happen if _STA reports that the device is not function=
al.
>
> Please apply this patch:
>
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index 028284f..a9e07e4 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -1405,6 +1405,14 @@ static int atk_remove(struct acpi_device *device, =
int type)
> =A0static int __init atk0110_init(void)
> =A0{
> =A0 =A0 =A0 =A0int ret;
> + =A0 =A0 =A0 acpi_status status;
> + =A0 =A0 =A0 u64 val;
> +
> + =A0 =A0 =A0 status =3D acpi_evaluate_integer(NULL, "\\AIDI", NULL, &val=
);
> + =A0 =A0 =A0 if (status !=3D AE_OK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("Failed to eval AIDI: %s\n", acpi_fo=
rmat_exception(status));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("AIDI =3D %llu\n", val);
>
> =A0 =A0 =A0 =A0ret =3D acpi_bus_register_driver(&atk_driver);
> =A0 =A0 =A0 =A0if (ret)
>
> Luca
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
