From: Nishanth Menon <nm@ti.com>
Date: Fri, 27 Sep 2013 12:24:39 +0000
Subject: Re: [lm-sensors] [PATCHv4 11/18] arm: dts: add omap4430 thermal data
Message-Id: <20130927122439.GA8360@kahuna>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
 <1380251605-3804-12-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1380251605-3804-12-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, devicetree@vger.kernel.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, grant.likely@linaro.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 23:13-20130926, Eduardo Valentin wrote:
> This patch changes the dtsi entry on omap4430 to contain
> the thermal data. This data will enable the passive
> cooling with CPUfreq cooling device at 100C and the
> system will do a thermal shutdown at 125C.
>=20
> Cc: "Beno=EEt Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x=
.dtsi
> index bcf455e..e9c97d6 100644
> --- a/arch/arm/boot/dts/omap443x.dtsi
> +++ b/arch/arm/boot/dts/omap443x.dtsi
> @@ -12,7 +12,7 @@
> =20
>  / {
>  	cpus {
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			/* OMAP443x variants OPP50-OPPNT */
>  			operating-points =3D <
>  				/* kHz    uV */
> @@ -25,9 +25,15 @@
>  		};
>  	};
> =20
> -	bandgap {
> +	thermal-zones{
> +		#include "omap4-cpu-thermal.dtsi"
> +	};
> +
> +	bandgap: bandgap {
>  		reg =3D <0x4a002260 0x4
>  		       0x4a00232C 0x4>;
>  		compatible =3D "ti,omap4430-bandgap";
> +
> +		#thermal-sensor-cells =3D <0>;
2 cents:
we might want to move bandgap under ocp?

>  	};
>  };
> --=20
> 1.8.2.1.342.gfa7285d
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Regards,
Nishanth Menon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
