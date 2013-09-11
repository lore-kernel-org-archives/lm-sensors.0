From: Wei Ni <wni@nvidia.com>
Date: Wed, 11 Sep 2013 11:35:35 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <52305587.6020207@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <522E93D6.2010304@roeck-us.net> <522E94AE.7000804@wwwdotorg.org> <522E97CE.4070300@roeck-us.net> <522E9C84.9070405@wwwdotorg.org> <20130910100939.GW29403@sirena.org.uk> <522F35BF.6070909@wwwdotorg.org> <20130910170438.GS29403@sirena.org.uk> <522F5A65.8040907@wwwdotorg.org> <20130910181837.GD29403@sirena.org.uk> <522F66FB.2000608@wwwdotorg.org> <20130910185235.GF29403@sirena.org.uk>
In-Reply-To: <20130910185235.GF29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/11/2013 02:52 AM, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Sep 10, 2013 at 12:37:47PM -0600, Stephen Warren wrote:
> 
>> OK, so for the DT binding we should make vcc-supply a required
>> property, yet the driver will still work OK if that property just
>> happens to be missing (or e.g. when instantiated from a board file,
>> and there's no regulator).
> 
> Yup.  That way we've got both the binding and code trying to make things
> work, hopefully that'll maximise robustness.

Ok, it looks like regulator_get will handle all things, looking forward
to your patches :)
Then I think my changes will be simple, just something like:
+	reg = devm_regulator_get(dev, "vcc");
+	if (!IS_ERR(reg)) {
+		err = regulator_enable(reg);
+		if (err < 0)
+			return err;
+	} else {
+		return PTR_ERR(reg);
+	}

Wei.

> 
> * Unknown Key
> * 0x7EA229BD
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
