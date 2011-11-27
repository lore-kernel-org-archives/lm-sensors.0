From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 27 Nov 2011 17:48:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: convert drivers/hwmon/* to use
Message-Id: <20111127174849.GA31315@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322205165.11718.2.camel@phoenix>
In-Reply-To: <1322205165.11718.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sonic Zhang <sonic.zhang@analog.com>, Marc Pignat <marc.pignat@hevs.ch>, Paul Thomas <pthomas8589@gmail.com>, Eric Miao <eric.miao@marvell.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Nov 25, 2011 at 02:12:45AM -0500, Axel Lin wrote:
> This patch converts the drivers in drivers/hwmon/* to use the
> module_spi_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Cc: Sonic Zhang <sonic.zhang@analog.com>
> Cc: Marc Pignat <marc.pignat@hevs.ch>
> Cc: Paul Thomas <pthomas8589@gmail.com>
> Cc: Eric Miao <eric.miao@marvell.com>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

module_spi_driver() is not (yet) available in mainline, so this patch
can not be applied right now.

It would probably make sense to resubmit the patch once the code necessary
to support it is available, to make sure it does not miss any new drivers.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
