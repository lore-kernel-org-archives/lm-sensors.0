From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 05 Apr 2010 13:24:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sht15) Properly handle the case
Message-Id: <20100405132409.GB6580@rakim.wolfsonmicro.main>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100403180551.4299abac@hyperion.delvare>
In-Reply-To: <20100403180551.4299abac@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 03, 2010 at 06:05:51PM +0200, Jean Delvare wrote:
> When CONFIG_REGULATOR isn't set, regulator_get_voltage() returns 0.
> Properly handle this case by not trusting the value.
> 
> Reported-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
