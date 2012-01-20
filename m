From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 20 Jan 2012 09:57:42 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: convert drivers/hwmon/* to use module_spi_driver()
Message-Id: <20120120095742.GB31838@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327046027.2411.0.camel@phoenix>
In-Reply-To: <1327046027.2411.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sonic Zhang <sonic.zhang@analog.com>, Marc Pignat <marc.pignat@hevs.ch>, Paul Thomas <pthomas8589@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Jan 20, 2012 at 02:53:47AM -0500, Axel Lin wrote:
> This patch converts the drivers in drivers/hwmon/* to use the
> module_spi_driver() macro which makes the code smaller and a bit simpler.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Cc: Sonic Zhang <sonic.zhang@analog.com>
> Cc: Marc Pignat <marc.pignat@hevs.ch>
> Cc: Paul Thomas <pthomas8589@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Acked-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/hwmon/ad7314.c  |   12 +-----------
>  drivers/hwmon/adcxx.c   |   13 +------------
>  drivers/hwmon/ads7871.c |   13 +------------
>  drivers/hwmon/lm70.c    |   13 +------------
>  drivers/hwmon/max1111.c |   12 +-----------
>  5 files changed, 5 insertions(+), 58 deletions(-)
> 
Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
