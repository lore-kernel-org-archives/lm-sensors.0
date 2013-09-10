From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 10 Sep 2013 15:07:43 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <522F35BF.6070909@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-2-git-send-email-wni@nvidia.com> <20130909111242.GW29403@sirena.org.uk> <522DB253.6000707@roeck-us.net> <20130909135022.GZ29403@sirena.org.uk> <20130909155043.GA18975@roeck-us.net> <522E9059.3070305@nvidia.com> <522E93D6.2010304@roeck-us.net> <522E94AE.7000804@wwwdotorg.org> <522E97CE.4070300@roeck-us.net> <522E9C84.9070405@wwwdotorg.org> <20130910100939.GW29403@sirena.org.uk>
In-Reply-To: <20130910100939.GW29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/10/2013 04:09 AM, Mark Brown wrote:
> On Mon, Sep 09, 2013 at 10:13:56PM -0600, Stephen Warren wrote:
>> On 09/09/2013 09:53 PM, Guenter Roeck wrote:
> 
>>> Earlier comments suggest that this is not the intended use case
>>> for regulator_get_optional().
> 
> That's right.
> 
>> Isn't the issue only whether the optional aspect of the regulator
>> is implemented by:
> 
>> a) regulator_get_optional() returning failure, then the driver
>> having to check for that and either using or not-using the
>> regulator.
> 
>> b) regulator_get_optional() returning a dummy regulator
>> automatically when none is specified in DT or the regulator
>> lookup table, and hence the driver can always call
>> regulator_enable/disable on the returned value.
> 
> No.  There are a couple of issues here.  One is that we don't want
> to litter all drivers with conditional code to check if they
> actually got the regulator and so on, that's just pointless make
> work on the part of consumers.

So that's exactly the difference between (a) and (b) above.

> The other is that just ignoring errors is generally terrible 
> practice which we don't want to encourage - ignoring the specific
> case where nothing is provided and the system has control of that
> is one thing but just ignoring any error is another.

Yes, obviously the code somewhere needs to distinguish between
missing-so-use-a-dummy, and specified-but-in-a-broken-way. Doesn't
regulator_get_optional() already distinguish those two cases? Perhaps
that's the enhancement to regulator_get_optional() that you were
requesting.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
