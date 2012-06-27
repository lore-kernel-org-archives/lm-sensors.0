From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Jun 2012 16:56:39 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Honeywell Humidicon HIH-6130/HIH-6131 humidity and temperature se
Message-Id: <20120627165639.GA12712@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEACA6F.4020600@gmail.com>
In-Reply-To: <4FEACA6F.4020600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 27, 2012 at 08:55:11AM +0000, Iain Paton wrote:
> This is a new driver for the Honeywell Humidicon HIH-6130/HIH-6131 humidity sensor.
> 
> The driver is based on the existing Sensiron sht21 driver with the necessary changes
> to the probe, update_measurements and conversion functions necessary to use the
> Honeywell sensors.
> 
> There's no difference between the 6130 & 6131 other than the 6131 having an external
> condensation filter attached.
> 
> Signed-off-by: Iain Paton <ipaton0@gmail.com>

Good job. Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
