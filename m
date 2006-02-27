From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Feb 2006 16:51:35 +0000
Subject: [lm-sensors] [PATCH] I2C: AT91RM9200 bus driver
Message-Id: <jtHCjHXp.1141059095.7587700.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1140682926.1877.25.camel@fuzzie.sanpeople.com>
In-Reply-To: <1140682926.1877.25.camel@fuzzie.sanpeople.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Andrew,

On 2006-02-27, Andrew Victor wrote:
> > Please replace all printk with dev_err etc infrastructure.
>
> Those seems to generate strange messages on this platform.
>   at91_i2c at91_i2c: AT91 i2c bus driver.
> ie, device name is doubled.

This is a known problem with the current platform driver core
implementation. In fact what you see isn't a doubled device name but a
device name followed by the device id (if I remember correctly). It
happens to be almost always the same for platform drivers so the output
looks a bit weird.

This would need to be "fixed" at the platform driver core level but
I'm not too sure what to do here, as the dev_* macros are generic ones
and not platform-driver specific.

--
Jean Delvare

