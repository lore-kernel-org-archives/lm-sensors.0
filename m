From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 26 Mar 2012 15:49:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: max6639: Convert to dev_pm_ops
Message-Id: <1332776988.21301.44.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332447838-30632-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1332447838-30632-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-03-26 at 11:41 -0400, Mark Brown wrote:
> The I2C specific PM operations have been deprecated and printing a
> warning on boot for over a year now.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'll stick with SET_SYSTEM_SLEEP_PM_OPS and the added #ifdef.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
