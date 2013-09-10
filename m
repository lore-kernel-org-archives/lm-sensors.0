From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 10 Sep 2013 18:37:47 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <522F66FB.2000608@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130909155043.GA18975@roeck-us.net> <522E9059.3070305@nvidia.com> <522E93D6.2010304@roeck-us.net> <522E94AE.7000804@wwwdotorg.org> <522E97CE.4070300@roeck-us.net> <522E9C84.9070405@wwwdotorg.org> <20130910100939.GW29403@sirena.org.uk> <522F35BF.6070909@wwwdotorg.org> <20130910170438.GS29403@sirena.org.uk> <522F5A65.8040907@wwwdotorg.org> <20130910181837.GD29403@sirena.org.uk>
In-Reply-To: <20130910181837.GD29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/10/2013 12:18 PM, Mark Brown wrote:
> On Tue, Sep 10, 2013 at 11:44:05AM -0600, Stephen Warren wrote:
> 
>> OK, so I believe you're saying that the case of a chip with just
>> a single power source, which absolutely must be present in HW for
>> the chip to be powered, isn't appropriate for
>> regulator_get_optional(). Something must always define a
>> regulator for that power source, even if there is no external SW
>> control over that power source.
> 
> Well, it really should be mandatory - personally I don't think
> it's sensible to add off-SoC chips without defining their
> regulators, it's more trouble than it's worth to have to add them
> later for all the time it takes to define the bindings.  In IETF
> terms it's a should.
> 
>> We either allow the regulator to be optional (since SW control
>> over the regulator is optional), or go back to every board file
>> and DT and add a dummy regulator in (which then breaks DT ABI,
>> and even ignoring that is a pain).
> 
> The whole point of the way I'm changing the dummy support is to
> allow us to gracefully cope with errors here so there's no
> mandatory update even though strictly there should be one.

OK, so for the DT binding we should make vcc-supply a required
property, yet the driver will still work OK if that property just
happens to be missing (or e.g. when instantiated from a board file,
and there's no regulator).

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
