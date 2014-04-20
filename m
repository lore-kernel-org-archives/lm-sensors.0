From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Apr 2014 14:41:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Document temp[1-*]_min_hyst sysfs attribute
Message-Id: <5353DC8E.70200@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140420144006.17c4f79e@endymion.delvare>
In-Reply-To: <20140420144006.17c4f79e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/20/2014 05:40 AM, Jean Delvare wrote:
> The temp[1-*]_min_hyst sysfs attribute is already implemented by 3
> hwmon drivers (adt7x10, lm77 and lm92) but was missing from the
> standard interface.
>
> Also add temp[1-*]_lcrit_hyst for consistency, even though no driver
> implement that one for the time being.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
