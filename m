From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 26 May 2009 09:01:26 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/1] hwmon: Updated documentation on
Message-Id: <4A1BAFE6.30506@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B515021B3458@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B515021B3458@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/25/2009 10:15 PM, Engelmayer Christian wrote:
> From: Christian Engelmayer<christian.engelmayer@frequentis.com>
>
> Added fan limit alarm 'max_alarm' to the alarm section.
>

Looks good to me now,

Acked-by: Hans de Goede <hdegoede@redhat.com>


> Signed-off-by: Christian Engelmayer<christian.engelmayer@frequentis.com>
> ---
> No longer mentioning non standard gpio alarms after clarification by the
> maintainer.
>
> --- Documentation/hwmon/sysfs-interface.orig	2009-05-21 23:03:27.000000000
> +0200
> +++ Documentation/hwmon/sysfs-interface	2009-05-25 22:08:13.000000000 +0200
> @@ -389,6 +389,7 @@ OR
>   in[0-*]_min_alarm
>   in[0-*]_max_alarm
>   fan[1-*]_min_alarm
> +fan[1-*]_max_alarm
>   temp[1-*]_min_alarm
>   temp[1-*]_max_alarm
>   temp[1-*]_crit_alarm
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
