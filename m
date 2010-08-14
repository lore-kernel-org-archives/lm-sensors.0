From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Aug 2010 17:51:04 +0000
Subject: Re: [lm-sensors] [PATCH 27/42] drivers/hwmon: Adjust confusing if
Message-Id: <20100814195104.5dff8cbe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.1008052224500.31692@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1008052224500.31692@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Julia Lawall <julia@diku.dk>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, 5 Aug 2010 22:25:06 +0200 (CEST), Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
>=20
> The if (ret) test has no effect if the if branch is not taken, so move it
> into the branch that it is already aligned with.
>=20
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @r disable braces4@
> position p1,p2;
> statement S1,S2;
> @@
>=20
> (
> if (...) { ... }
> |
> if (...) S1@p1 S2@p2
> )
>=20
> @script:python@
> p1 << r.p1;
> p2 << r.p2;
> @@
>=20
> if (p1[0].column =3D p2[0].column):
>   cocci.print_main("branch",p1)
>   cocci.print_secs("after",p2)
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <julia@diku.dk>
>=20
> ---
>  drivers/hwmon/mc13783-adc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> index ce3c7bc..0b53713 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -162,10 +162,11 @@ static int __init mc13783_adc_probe(struct platform=
_device *pdev)
>  	if (ret)
>  		goto out_err_create1;
> =20
> -	if (!(priv->mc13783->flags & MC13783_USE_TOUCHSCREEN))
> +	if (!(priv->mc13783->flags & MC13783_USE_TOUCHSCREEN)) {
>  		ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13783_group_ts);
>  		if (ret)
>  			goto out_err_create2;
> +	}
> =20
>  	priv->hwmon_dev =3D hwmon_device_register(&pdev->dev);
>  	if (IS_ERR(priv->hwmon_dev)) {

Already fixed by this commit:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=EAf06ee22594ac90cdd0279483b06c1db1667e01

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
