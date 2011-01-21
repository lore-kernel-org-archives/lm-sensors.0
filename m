From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 21 Jan 2011 17:04:16 +0000
Subject: Re: [lm-sensors] [PATCH] HWMON: (lis3lv02d) Convert SPI to
Message-Id: <1295629456.9786.442.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1295558876-25061-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1295558876-25061-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-01-20 at 16:27 -0500, Mark Brown wrote:
> There is a move to deprecate bus-specific PM operations and move to
> using dev_pm_ops instead in order to reduce the amount of boilerplate
> code in buses and facilitiate updates to the PM core. Do this move for
> the lis3lv02d SPI driver.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
