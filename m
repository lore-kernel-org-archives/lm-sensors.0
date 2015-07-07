From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Jul 2015 19:32:51 +0000
Subject: Re: [lm-sensors] [PATCH V3 0/3] hwmon:f71882fg add new Fintek SuperIO support
Message-Id: <559C2963.4010902@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436257358-31360-1-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1436257358-31360-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Hung <hpeter@gmail.com>, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>

On 07/07/2015 01:22 AM, Peter Hung wrote:
> The first patch will add Fintek F81866/F71868 SuperIO
> with H/W monitor function to f71882fg.c.
>
> But some F81866 functional address is differ from F71882fg.
> The following 2 patches will fix this problem.
>
> The test report is upload to following link. If I lost something,
> with test, please let me know. I'll append it to the report.
>
> Here is F81866 on customer MB report:
> https://drive.google.com/file/d/0B8vRwwYO7aMFUmliSFVWVVRUaTA/view?pli=1
>
> Cause we had no F71868 MB currently, we just check and mapping
> register to driver.
>
> Changelog:
> V3
> 	1. Fix fatal compile error. (Thanks to Guenter Roeck)
> 	2. Fix array size and content not match error.
> 	   (Thanks to Dan Carpenter)
>
> V2
> 	1. Fix comments by Guenter Roeck <linux@roeck-us.net>
> 	   all newer add IC should keep chip IDs in numeric order.
>
> Peter Hung (3):
>    hwmon:f71882fg add f81866/f71868 SuperIO support
>    hwmon:f71882fg fix f81866a temp/beep setting
>    hwmon:f71882fg fix f81866a voltage protection
>
>   drivers/hwmon/f71882fg.c | 163 +++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 131 insertions(+), 32 deletions(-)
>
Series applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
