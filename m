From: Lukasz Majewski <l.majewski@samsung.com>
Date: Wed, 25 Feb 2015 13:28:15 +0000
Subject: Re: [lm-sensors] [PATCH v4 5/8] ARM: dts: Add properties to use pwm-fan device as a cooling device i
Message-Id: <20150225142815.562fe22b@amdc2363>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-6-git-send-email-l.majewski@samsung.com>
 <20150224193711.GA353@developer.amazonguestwifi.org>
In-Reply-To: <20150224193711.GA353@developer.amazonguestwifi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>

Hi Eduardo,

> On Wed, Feb 18, 2015 at 11:07:33AM +0100, Lukasz Majewski wrote:
> > With those bindings it is possible to use pwm-fan device available
> > in Odroid U3 as a cooling device.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> > Changes for v2:
> > - Rename cooling-pwm-values property to cooling-levels
> > Changes for v3:
> > - Change patch's topic to "ARM dts"
> > - Reduce maximal cooling-level to 230 from 255
> > Changes for v4:
> > - None
> > ---
> >  arch/arm/boot/dts/exynos4412-odroidu3.dts | 33
> > ++++++++++++++++++++++++++++++- 1 file changed, 32 insertions(+), 1
> > deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > b/arch/arm/boot/dts/exynos4412-odroidu3.dts index 60bd1e4..3e5df3e
> > 100644 --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > @@ -32,11 +32,42 @@
> >  		};
> >  	};
> >  
> > -	pwm-fan {
> > +	fan0: pwm-fan {
> >  		compatible = "pwm-fan";
> >  		pwms = <&pwm 0 10000 0>;
> > +		cooling-min-state = <0>;
> > +		cooling-max-state = <3>;
> > +		#cooling-cells = <2>;
> > +		cooling-levels = <0 102 170 230>;
> >  		status = "okay";
> >  	};
> > +
> > +	thermal-zones {
> > +		cpu_thermal: cpu-thermal {
> 
> 
> This thermal zone misses the mandatory properties as per 
>  Documentation/devicetree/bindings/thermal/thermal.txt

Following mandatory properties:
		thermal-sensors = <&tmu 0>;
		polling-delay-passive = <0>;
		polling-delay = <0>;
		trips {

		}

are defined in exynos4-cpu-thermal.dtsi included by this file.

In this patch only device dependent changes are stated.

> 
> > +			cooling-maps {
> > +				map0 {
> > +				     trip = <&cpu_alert1>;
> > +				     cooling-device = <&cpu0 7 7>;
> > +				};
> > +				map1 {
> > +				     trip = <&cpu_alert2>;
> > +				     cooling-device = <&cpu0 13
> > 13>;
> > +				};
> > +				map2 {
> > +				     trip = <&cpu_alert0>;
> > +				     cooling-device = <&fan0 0 1>;
> > +				};
> > +				map3 {
> > +				     trip = <&cpu_alert1>;
> > +				     cooling-device = <&fan0 1 2>;
> > +				};
> > +				map4 {
> > +				     trip = <&cpu_alert2>;
> > +				     cooling-device = <&fan0 2 3>;
> > +				};
> > +			};
> > +		};
> > +	};
> >  };
> >  
> >  &pwm {
> > -- 
> > 2.0.0.rc2
> > 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
