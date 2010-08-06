From: Charles Logan <cybercorecentre@gmail.com>
Date: Fri, 06 Aug 2010 09:04:20 +0000
Subject: Re: [lm-sensors] [PATCH 3/42] drivers/hwmon: Adjust confusing if
Message-Id: <AANLkTikGYhWCVW1HqdhwqRHaph54S9U4eKi7nNLHktMV@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.1008052217240.31692@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1008052217240.31692@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Julia Lawall <julia@diku.dk>
Cc: Rudolf Marek <r.marek@assembler.cz>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Corrected:

> // <smpl>
> @r disable braces5@
> position p1,p2;
> statement S1,S2;
> @@
>
> (
> if (...) { ... }
> |
> if (...) S1@p1 S2@p2
> )
>
> @script:python@
> p1 << r.p1;
> p2 << r.p2;
> @@
>
> if (p1[0].column =3D p2[0].column):
>  cocci.print_main("branch",p4)
>  cocci.print_secs("after",p5)
> // </smpl>



On Thu, Aug 5, 2010 at 10:17 PM, Julia Lawall <julia@diku.dk> wrote:
> From: Julia Lawall <julia@diku.dk>
>
> Move the if(err) statement after the if into the if branch indicated by i=
ts
> indentation. =A0The preceding if(err) test implies that err cannot be non=
zero
> unless the if branch is taken.
>
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @r disable braces4@
> position p1,p2;
> statement S1,S2;
> @@
>
> (
> if (...) { ... }
> |
> if (...) S1@p1 S2@p2
> )
>
> @script:python@
> p1 << r.p1;
> p2 << r.p2;
> @@
>
> if (p1[0].column =3D p2[0].column):
> =A0cocci.print_main("branch",p1)
> =A0cocci.print_secs("after",p2)
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>
>
> ---
> =A0drivers/hwmon/k8temp.c | =A0 =A03 ++-
> =A01 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index 8bdf80d..b9bb3e0 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -252,12 +252,13 @@ static int __devinit k8temp_probe(struct pci_dev *p=
dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &sens=
or_dev_attr_temp3_input.dev_attr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_remove;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->sensorsp & SEL_PLACE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->sensorsp & SEL_PLACE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D device_create_file=
(&pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 &sensor_dev_attr_temp4_input.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 dev_attr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_=
remove;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0err =3D device_create_file(&pdev->dev, &dev_attr_name);
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
