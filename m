From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 27 Nov 2011 01:37:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: convert drivers/hwmon/* to use
Message-Id: <20111127013735.GA24906@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322206260.11718.4.camel@phoenix>
In-Reply-To: <1322206260.11718.4.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Donggeun Kim <dg77.kim@samsung.com>, Simon Guinot <sguinot@lacie.com>, Lars-Peter Clausen <lars@metafoo.de>, MyungJoo Ham <myungjoo.ham@samsung.com>, Ben Dooks <ben@simtec.co.uk>, Hans de Goede <hdegoede@redhat.com>, J Keerthy <j-keerthy@ti.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Nov 25, 2011 at 02:31:00AM -0500, Axel Lin wrote:
> This patch converts the drivers in drivers/hwmon/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Cc: Donggeun Kim <dg77.kim@samsung.com>
> Cc: Simon Guinot <sguinot@lacie.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Ben Dooks <ben@simtec.co.uk>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: J Keerthy <j-keerthy@ti.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied. I'll let it rest in linux-next for a couple of days and send it to Linus
if there are no problems.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
