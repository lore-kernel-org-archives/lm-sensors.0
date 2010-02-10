From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Feb 2010 13:21:05 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <20100210142105.27cb968a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 10 Feb 2010 14:28:49 +0200, D. Can Celasun wrote:
> Thanks for the quick reply, cpuinfo is attached.
> 
> Kernel is 2.6.32

> cpu family	: 6
> model		: 37
> model name	: Intel(R) Core(TM) i3 CPU       M 330  @ 2.13GHz

This is model 0x25, the highest model supported by the coretemp driver
so far is 0x1e. So your model isn't yet supported, but support could
probably be added easily if we knew the thermal limit for this CPU
model. Huaxu, care to send a patch for Core i3 support?

As for the SMBus, your kernel should support it, so if the i2c-i801
driver did not bind to the device, it probably means that ACPI
requested it first. In that case you should see a message similar to
that one in the kernel logs:
ACPI: I/O resource 0000:00:1f.3 [0x18e0-0x18ff] conflicts with ACPI region SMBI [0x18e0-0x18ef]
ACPI: Device needs an ACPI driver

In that case, all you can do is hope that ACPI is properly handling
thermal management on your machine.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
