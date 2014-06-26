From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Jun 2014 13:46:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ntc_thermistor: correct the information printed during probe
Message-Id: <53AC242B.3020903@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403787014-5858-1-git-send-email-ch.naveen@samsung.com>
In-Reply-To: <1403787014-5858-1-git-send-email-ch.naveen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, cpgs@samsung.com, herbert@gondor.apana.org.au

On 06/26/2014 05:50 AM, Naveen Krishna Chatradhi wrote:
> Currently, dev_info() at the end of the probe says
> "type:%s ". But, prints the pdev->name.
>
> This patch uses "pdev_id->name" which prints the thermistor type.
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

Another good catch.

Applied, thanks.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
