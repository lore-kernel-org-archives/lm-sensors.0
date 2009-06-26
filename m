From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 26 Jun 2009 09:51:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Message-Id: <20090626095116.GD5415@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A448926.1030701@samsung.com>
 <1246007760.3067.5.camel@hpdv5.satnam>
In-Reply-To: <1246007760.3067.5.camel@hpdv5.satnam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org, suchang.woo@samsung.com, kyungmin.park@samsung.com

On Fri, Jun 26, 2009 at 02:46:00PM +0530, Jaswinder Singh Rajput wrote:

> I am curious what is the use of include/linux/gp2ap002.h, it only have
> gp2ap002_platform_data structure which you can keep in your source file
> the only file which is using it.

Platform data is data which is passed in from the board-specific code
for the system (which will live under arch) to configure the driver.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
