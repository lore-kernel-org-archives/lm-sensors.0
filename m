From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 10 Sep 2013 04:13:56 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <522E9C84.9070405@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-1-git-send-email-wni@nvidia.com> <1378722552-10357-2-git-send-email-wni@nvidia.com> <20130909111242.GW29403@sirena.org.uk> <522DB253.6000707@roeck-us.net> <20130909135022.GZ29403@sirena.org.uk> <20130909155043.GA18975@roeck-us.net> <522E9059.3070305@nvidia.com> <522E93D6.2010304@roeck-us.net> <522E94AE.7000804@wwwdotorg.org> <522E97CE.4070300@roeck-us.net>
In-Reply-To: <522E97CE.4070300-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/09/2013 09:53 PM, Guenter Roeck wrote:
> On 09/09/2013 08:40 PM, Stephen Warren wrote:
>> On 09/09/2013 09:36 PM, Guenter Roeck wrote:
...
>>> My understanding is that by adding regulator support you essentially
>>> committed to adding regulators (if necessary dummy ones) for this driver
>>> to all those platforms. This is quite similar to other drivers in the
>>> same situation. Once you start along that route, you'll have to go it
>>> all the way.
>>
>> By using regulator_get_optional(), the regulator should be optional,
>> hence you only have to add it to platforms that need it.
>>
> 
> Earlier comments suggest that this is not the intended use case for
> regulator_get_optional().

Isn't the issue only whether the optional aspect of the regulator is
implemented by:

a) regulator_get_optional() returning failure, then the driver having to
check for that and either using or not-using the regulator.

b) regulator_get_optional() returning a dummy regulator automatically
when none is specified in DT or the regulator lookup table, and hence
the driver can always call regulator_enable/disable on the returned value.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
