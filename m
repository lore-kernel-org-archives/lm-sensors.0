From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Dec 2011 21:42:08 +0000
Subject: Re: [lm-sensors] unsupported intel smbus controller?
Message-Id: <1323726128.2415.72.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <19012-1323723512-333625@sneakemail.com>
In-Reply-To: <19012-1323723512-333625@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-12-12 at 15:58 -0500, yu8ehurwa2@snkmail.com wrote:
> Running sensors-detect gives:
> 
>  .
>  .
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Found unknown SMBus adapter 8086:1c22 at 0000:00:1f.3.
> Sorry, no supported PCI bus adapters found.
> 
> 
> from lspci ...
> 00:1f.3 SMBus: Intel Corporation Cougar Point SMBus Controller (rev 05)
> 
> from lspci -n ...
> 00:1f.3 0c05: 8086:1c22 (rev 05)
> 
> 
> I'm running:
> lm_sensors-3.1.1-10.el6.i686
> 
> 
> How do I set about trying to add support for this controller?
> 
Both the current version of sensors-detect and the i2c-i801 kernel
module support it. Try "sudo modprobe i2c-i801". If that does not help,
you may have to upgrade to a more recent kernel.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
