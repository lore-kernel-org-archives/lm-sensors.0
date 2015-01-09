From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 09 Jan 2015 04:48:40 +0000
Subject: Re: [lm-sensors] [PATCH V2] (gpio-fan): Add thermal control hooks
Message-Id: <54AF5DA8.6080408@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420740303-12529-1-git-send-email-nm@ti.com>
In-Reply-To: <1420740303-12529-1-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nishanth Menon <nm@ti.com>, Jean Delvare <jdelvare@suse.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On 01/08/2015 10:05 AM, Nishanth Menon wrote:
> Allow gpio-fan to be used as thermal cooling device for platforms that
> use GPIO maps to control fans.
>
> As part of this change, we make the shutdown and remove logic the same
> as well.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
