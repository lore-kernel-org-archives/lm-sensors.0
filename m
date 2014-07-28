From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 28 Jul 2014 14:26:44 +0000
Subject: Re: [lm-sensors] [PATCH -next] hwmon: (pwm-fan) Fix sparse NULL pointer warning
Message-Id: <53D65DA4.7010107@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406553478-29767-1-git-send-email-weiyj_lk@163.com>
In-Reply-To: <1406553478-29767-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/28/2014 06:17 AM, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fixes the following sparse warnings:
>
> drivers/hwmon/pwm-fan.c:107:67: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

I already had the fix for this in my tree.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
