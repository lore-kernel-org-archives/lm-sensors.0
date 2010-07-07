From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 07 Jul 2010 14:52:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pc87360) Fix device resource
Message-Id: <AANLkTinw8F05_ujmVojX5D7Csxz_b7z0k2IqSQ8NQME4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100707145841.58052281@hyperion.delvare>
In-Reply-To: <20100707145841.58052281@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

hi Jean

On Wed, Jul 7, 2010 at 6:58 AM, Jean Delvare <khali@linux-fr.org> wrote:
> It's not OK to call platform_device_add_resources() multiple times
> in a row. Despite its name, this functions sets the resources, it
> doesn't add them. So we have to prepare an array with all the
> resources, and then call platform_device_add_resources() once.
>
> Before this fix, only the last I/O resource would be actually
> registered. The other I/O resources were leaked.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Cc: stable@kernel.org
> ---
> Jim, do you still have your system with a PC8736x device? If you do,
> can you please test this fix and report? Thanks.

Its not handy, but I see about arranging access.

Did you catch this by inspection?
was there another thread that triggered your recollection/association ?
Any simple check for this ?
I dont suppose a /proc/<file> is gonna shout RESOURCE LEAK ..
that said, I'll look before&after for something more subtle.

thanks Jean
Jim

>
> =A0drivers/hwmon/pc87360.c | =A0 30 ++++++++++++++++--------------
> =A01 file changed, 16 insertions(+), 14 deletions(-)
>
> --- linux-2.6.35-rc4.orig/drivers/hwmon/pc87360.c =A0 =A0 =A0 2010-05-17 =
18:20:27.000000000 +0200
> +++ linux-2.6.35-rc4/drivers/hwmon/pc87360.c =A0 =A02010-07-07 14:11:03.0=
00000000 +0200
> @@ -1610,11 +1610,8 @@ static struct pc87360_data *pc87360_upda
>
> =A0static int __init pc87360_device_add(unsigned short address)
> =A0{
> - =A0 =A0 =A0 struct resource res =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "pc87360",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IO,
> - =A0 =A0 =A0 };
> - =A0 =A0 =A0 int err, i;
> + =A0 =A0 =A0 struct resource res[3];
> + =A0 =A0 =A0 int err, i, res_count;
>
> =A0 =A0 =A0 =A0pdev =3D platform_device_alloc("pc87360", address);
> =A0 =A0 =A0 =A0if (!pdev) {
> @@ -1623,22 +1620,27 @@ static int __init pc87360_device_add(uns
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 memset(res, 0, 3 * sizeof(struct resource));
> =A0 =A0 =A0 =A0for (i =3D 0; i < 3; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!extra_isa[i])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res.start =3D extra_isa[i];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res.end =3D extra_isa[i] + PC87360_EXTENT -=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[res_count].start =3D extra_isa[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[res_count].end =3D extra_isa[i] + PC873=
60_EXTENT - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[res_count].name =3D "pc87360",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[res_count].flags =3D IORESOURCE_IO,
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D acpi_check_resource_conflict(&res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D acpi_check_resource_conflict(&res[r=
es_count]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_device_put;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D platform_device_add_resources(pdev,=
 &res, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "pc87360: D=
evice resource[%d] "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"addition fa=
iled (%d)\n", i, err);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_device_put;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res_count++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D platform_device_add_resources(pdev, res, res_count);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "pc87360: Device resources =
addition failed "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"(%d)\n", err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_device_put;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0err =3D platform_device_add(pdev);
>
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
