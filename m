From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 23 May 2009 17:30:20 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: Updated documentation on alarms
Message-Id: <4A1832AC.9050004@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B515021B3103@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B515021B3103@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 05/21/2009 11:57 PM, Engelmayer Christian wrote:
> From: Christian Engelmayer<christian.engelmayer@frequentis.com>
>
> Added gpio channel alarm and fan limit alarm 'max_alarm' to the alarm
> section.
>

Not sure if we should mention the gpio alarms in the sysfs docs as they
are a bit non standard,

Jean ?

Regards,

Hans


> Signed-off-by: Christian Engelmayer<christian.engelmayer@frequentis.com>
> ---
>
> --- Documentation/hwmon/sysfs-interface.orig	2009-05-21 23:03:27.000000000
> +0200
> +++ Documentation/hwmon/sysfs-interface	2009-05-21 23:42:31.000000000 +0200
> @@ -379,6 +379,7 @@ implementation.
>   in[0-*]_alarm
>   fan[1-*]_alarm
>   temp[1-*]_alarm
> +gpio[0-*]_alarm
>   		Channel alarm
>   		0: no alarm
>   		1: alarm
> @@ -389,6 +390,7 @@ OR
>   in[0-*]_min_alarm
>   in[0-*]_max_alarm
>   fan[1-*]_min_alarm
> +fan[1-*]_max_alarm
>   temp[1-*]_min_alarm
>   temp[1-*]_max_alarm
>   temp[1-*]_crit_alarm
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
