From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Jun 2014 18:10:22 +0000
Subject: Re: [lm-sensors] [PATCH] Added support for Lattice's POWR1220 power manager IC.
Message-Id: <539B3E8E.2010300@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <53965259.8020806@roeck-us.net>
In-Reply-To: <53965259.8020806@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/12/2014 01:22 PM, Scott Kanowitz wrote:
> This patch adds support for Lattice's POWR1220 power manager IC. Read
> access to all the ADCs on the chip are supported through the hwmon
> sysfs files.
>
> Signed-off-by: Scott Kanowitz <skanowitz@echo360.com>

Hi Scott,

Nicely done, though next time it would be great if you can add a change log.
There are a couple of unneeded ( ), which I removed. No need to resend.
Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
