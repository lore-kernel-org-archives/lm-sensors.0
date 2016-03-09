From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Date: Wed, 09 Mar 2016 22:23:14 +0000
Subject: Re: [lm-sensors] [PATCH 10/13] thermal: convert rockchip_thermal to use devm_thermal_zone_of_sensor_
Message-Id: <8638741.XZr7Brn4dS@diego>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com> <1457559336-17652-11-git-send-email-edubezval@gmail.com>
In-Reply-To: <1457559336-17652-11-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Eduardo Valentin <edubezval@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Caesar Wang <caesar.upstream@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org

Am Mittwoch, 9. M=E4rz 2016, 13:35:32 schrieb Eduardo Valentin:
> This changes the driver to use the devm_ version
> of thermal_zone_of_sensor_register and cleans
> up the  local points and unregister calls.
>=20
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

to me this looks ok
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I've also added in some Rockchip people that were working on the driver in =
the=20
past.


Heiko

> ---
>  drivers/thermal/rockchip_thermal.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/thermal/rockchip_thermal.c
> b/drivers/thermal/rockchip_thermal.c index b58e3fb..792c5d0 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -753,8 +753,8 @@ rockchip_thermal_register_sensor(struct platform_devi=
ce
> *pdev,
>=20
>  	sensor->thermal =3D thermal;
>  	sensor->id =3D id;
> -	sensor->tzd =3D thermal_zone_of_sensor_register(&pdev->dev, id, sensor,
> -						      &rockchip_of_thermal_ops);
> +	sensor->tzd =3D devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> +					sensor, &rockchip_of_thermal_ops);
>  	if (IS_ERR(sensor->tzd)) {
>  		error =3D PTR_ERR(sensor->tzd);
>  		dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
> @@ -782,7 +782,7 @@ static int rockchip_thermal_probe(struct platform_dev=
ice
> *pdev) const struct of_device_id *match;
>  	struct resource *res;
>  	int irq;
> -	int i, j;
> +	int i;
>  	int error;
>=20
>  	match =3D of_match_node(of_rockchip_thermal_match, np);
> @@ -865,9 +865,6 @@ static int rockchip_thermal_probe(struct platform_dev=
ice
> *pdev) dev_err(&pdev->dev,
>  				"failed to register sensor[%d] : error =3D %d\n",
>  				i, error);
> -			for (j =3D 0; j < i; j++)
> -				thermal_zone_of_sensor_unregister(&pdev->dev,
> -						thermal->sensors[j].tzd);
>  			goto err_disable_pclk;
>  		}
>  	}
> @@ -879,7 +876,7 @@ static int rockchip_thermal_probe(struct platform_dev=
ice
> *pdev) if (error) {
>  		dev_err(&pdev->dev,
>  			"failed to request tsadc irq: %d\n", error);
> -		goto err_unregister_sensor;
> +		goto err_disable_pclk;
>  	}
>=20
>  	thermal->chip->control(thermal->regs, true);
> @@ -891,11 +888,6 @@ static int rockchip_thermal_probe(struct
> platform_device *pdev)
>=20
>  	return 0;
>=20
> -err_unregister_sensor:
> -	while (i--)
> -		thermal_zone_of_sensor_unregister(&pdev->dev,
> -						  thermal->sensors[i].tzd);
> -
>  err_disable_pclk:
>  	clk_disable_unprepare(thermal->pclk);
>  err_disable_clk:
> @@ -913,7 +905,6 @@ static int rockchip_thermal_remove(struct
> platform_device *pdev) struct rockchip_thermal_sensor *sensor =3D
> &thermal->sensors[i];
>=20
>  		rockchip_thermal_toggle_sensor(sensor, false);
> -		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
>  	}
>=20
>  	thermal->chip->control(thermal->regs, false);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
