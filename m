From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 24 Jun 2010 00:09:17 +0000
Subject: Re: [lm-sensors] Adding critical/fault limits to hwmon sysfs API
Message-Id: <20100624000916.GA8809@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100620163759.GA7077@ericsson.com> <20100623144346.10acd898@hyperion.delvare>
In-Reply-To: <20100623144346.10acd898@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Jun 23, 2010 at 02:43:46PM +0200, Jean Delvare wrote:

> For temperatures, we have temp[1-*]_crit, for the critical limit on the
> high end. We don't have a name for the critical limit on the low end,
> because no chip ever implemented that. The name we chose doesn't offer

FWIW battery monitoring chips are likely to implement under temperature
warnings - the Wolfson chargers do, for example.  Low temperature can be
as problematic as high temperature for the chemistry.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
