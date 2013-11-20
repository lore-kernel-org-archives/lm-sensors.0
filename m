From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 20 Nov 2013 12:32:45 +0000
Subject: Re: [lm-sensors] [PATCHv5 10/20] arm: dts: add omap4430 thermal data
Message-Id: <20131120123245.GA3242@amd.pavel.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
 <1384285582-16933-11-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1384285582-16933-11-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

HI!

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

I see you also add labels to various other entries...

> @@ -25,9 +25,15 @@
>  		};
>  	};
> =20
> -	bandgap {
> +	thermal-zones{

You may want to include space here.

> +		#include "omap4-cpu-thermal.dtsi"
> +	};
> +
> +	bandgap: bandgap {
>  		reg =3D <0x4a002260 0x4
>  		       0x4a00232C 0x4>;
>  		compatible =3D "ti,omap4430-bandgap";
> +
> +		#thermal-sensor-cells =3D <0>;
>  	};
>  };

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
