From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: I2C documentation in Linux 2.6
Message-Id: <20031109194856.GB1932@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031109143302.76713452.khali@linux-fr.org>
In-Reply-To: <20031109143302.76713452.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 09, 2003 at 02:33:02PM +0100, Jean Delvare wrote:
> 
> Hi Greg,
> 
> Attached are two updates for inclusion to Documentation/i2c in Linux
> 2.6.

Can you split this into two different email messages, both as patches
that I can apply to the kernel tree?  That makes it a world easier to
apply them.

> +  static struct i2c_driver foo_driver = {
> +    .owner          = THIS_MODULE,
> +    .name           = "Foo version 2.3 driver",
> +    .id             = I2C_DRIVERID_FOO, /* usually from i2c-id.h */

Why is this needed anymore?

> +    .flags          = I2C_DF_NOTIFY,

Are there any usages of this field becides the I2C_DF_NOTIFY?  In a
quick grep, it looks like everyone sets this value, so why even have
this field at all?

thanks,

greg k-h
