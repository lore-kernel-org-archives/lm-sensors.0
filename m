From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 12 Feb 2011 03:51:38 +0000
Subject: Re: [lm-sensors] [PATCH 03/17] jz4740: mfd_cell is now implicitly
Message-Id: <20110212035138.GA6859@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110211180250.483936cc@queued.net>
In-Reply-To: <20110211180250.483936cc@queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger@queued.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Fri, Feb 11, 2011 at 09:02:50PM -0500, Andres Salomon wrote:
> 
> No need to explicitly set the cell's platform_data/data_size.
> 
> Modify clients to use mfd_get_cell helper function instead of
> accessing platform_data directly.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

I don't see anything different to the previous version of this patch
(which was Acked by Jean already), and there is no changelog available
for the complete series either.

A changelog would be really helpful.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
