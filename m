From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 25 Nov 2011 11:03:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: convert drivers/hwmon/* to use
Message-Id: <20111125110311.GB5315@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322206260.11718.4.camel@phoenix>
In-Reply-To: <1322206260.11718.4.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Donggeun Kim <dg77.kim@samsung.com>, Simon Guinot <sguinot@lacie.com>, Lars-Peter Clausen <lars@metafoo.de>, MyungJoo Ham <myungjoo.ham@samsung.com>, Ben Dooks <ben@simtec.co.uk>, Hans de Goede <hdegoede@redhat.com>, J Keerthy <j-keerthy@ti.com>, "David S. Miller" <davem@davemloft.net>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On Fri, Nov 25, 2011 at 03:31:00PM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/hwmon/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
