From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 24 Mar 2012 15:33:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: max6639: Convert to dev_pm_ops
Message-Id: <20120324153311.GA2618@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332447838-30632-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1332447838-30632-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Thu, Mar 22, 2012 at 04:23:58PM -0400, Mark Brown wrote:
> The I2C specific PM operations have been deprecated and printing a
> warning on boot for over a year now.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Actually, there is a problem with your patch. With the patch applied,
my nightly builds tell me:

Build: /home/groeck/local/linux-staging:hwmon:2:3

/tmp/linux.6026/drivers/hwmon/max6639.c:599: warning: 'max6639_suspend' defined but not used
/tmp/linux.6026/drivers/hwmon/max6639.c:610: warning: 'max6639_resume' defined but not used
--------------------

This suggests that something is wrong if CONFIG_PM is not set (missing #ifdef around the
suspend/resume functions ? Or is there some better way to do this without #ifdef ?).

I'll back out your patch for now. Please have a look.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
