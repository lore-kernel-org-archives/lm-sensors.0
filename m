From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sun, 27 Jun 2010 10:20:59 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: Driver for SMM665
Message-Id: <20100627102058.GB2845@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1277416861-32494-1-git-send-email-guenter.roeck@ericsson.com>
 <1277416861-32494-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1277416861-32494-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, "Ira W. Snyder" <iws@ovro.caltech.edu>, Hans de Goede <hdegoede@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

On Thu, Jun 24, 2010 at 03:00:58PM -0700, Guenter Roeck wrote:
> This driver adds support for the monitoring features of the Summit
> Microelectronics SMM665 Six-Channel Active DC Output Controller/Monitor.

A bit late to the game here but this looks like the chip has some
regulator control functionality as well as monitoring functionality (and
the product page on the Summit web site suggests so also).  This means
that when fully supported in software the driver would cross multiple
subsystems so it might make sense to start off with a MFD rather than
direct I2C control?  

If the non-monitoring functionality can't be controlled from software
this isn't an issue.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
