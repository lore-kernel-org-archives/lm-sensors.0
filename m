From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Jun 2010 06:34:31 +0000
Subject: Re: [lm-sensors] Adding critical/fault limits to hwmon sysfs API
Message-Id: <20100624083431.6487e7fe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100620163759.GA7077@ericsson.com>
	<20100623144346.10acd898@hyperion.delvare>
	<20100624000916.GA8809@sirena.org.uk>
In-Reply-To: <20100624000916.GA8809@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, 24 Jun 2010 01:09:17 +0100, Mark Brown wrote:
> On Wed, Jun 23, 2010 at 02:43:46PM +0200, Jean Delvare wrote:
> 
> > For temperatures, we have temp[1-*]_crit, for the critical limit on the
> > high end. We don't have a name for the critical limit on the low end,
> > because no chip ever implemented that. The name we chose doesn't offer
> 
> FWIW battery monitoring chips are likely to implement under temperature
> warnings - the Wolfson chargers do, for example.  Low temperature can be
> as problematic as high temperature for the chemistry.

We already have temp[1-*]_min. We would have to add temp[1-*]_lcrit
only if a chip has 2 lower limits, one which is only a warning and one
which is critical.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
