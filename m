From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 17 Dec 2013 18:01:31 +0000
Subject: Re: [lm-sensors] I2C support for AMD Hudson-1
Message-Id: <20131217180131.GB2840@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131217063226.GD25105@phys.ethz.ch>
In-Reply-To: <20131217063226.GD25105-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Dec 17, 2013 at 07:32:26AM +0100, Christian Herzog wrote:
> Dear list,
> 
> I'm currently beta testing a pretty cool embedded board for router
> applications etc. (http://www.pcengines.ch/apu.htm) that sports a Hudson-1 FCH
> which is pretty similar to the Hudson-2 your module supports but sufficiently
> different so that i2c-piix4 doesn't work.
> I found a patched i2c-piix4 source that adds support for the Hudson-1 and it
> works beautifully: http://www.men.de/products/13SC24-90.html#t=overview
> Now I'm wondering if you would be willing to get this patch into lm-sensors
> and also the kernel.
> If there's anything I can do to help, please let me know.
> I expect those boards to become at least as popular as their alix predecessors
> were, so out-of-the-box kernel support would be nice.
> 
Wrong mailing list. Copying linux-i2c.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
