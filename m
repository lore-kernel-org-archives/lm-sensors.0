From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 08 Aug 2013 17:33:13 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Add power control
Message-Id: <5203D659.4050907@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com> <1375944991-29182-2-git-send-email-wni@nvidia.com> <520359E9.1000600@roeck-us.net> <52036920.4050808@nvidia.com> <52037F9A.7070802@roeck-us.net>
In-Reply-To: <52037F9A.7070802-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 08/08/2013 05:23 AM, Guenter Roeck wrote:
> On 08/08/2013 02:47 AM, Wei Ni wrote:
...
>> I think get_regulator() will return error values, not only
>> -EPROBE_DEFER, so we should set data->lm90_reg to NULL to handle other
>> error values.
>>
> Matter of opinion if you want to check for IS_ERR or NULL later on.

No, if regulator returns either:

* Something valid
* Someting IS_ERR()

... then everywhere has to check the value using IS_ERR().

If regulator returns either:

* Something valid
* Someting NULL

... then everywhere has to check the value against NULL.

checking against both IS_ERR() and NULL shouldn't ever happen, and
likewise IS_ERR_OR_NULL() is deprecated.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
