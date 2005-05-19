From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <20050316105401.2db5658c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mike, Antonio & all,

> I narrowed the problem down.
> In the following scenario, the OOPS occurs:
> CONFIG_I2C=y
> CONFIG_FB_NVIDIA=y
> CONFIG_FB_NVIDIA_I2C=y
> 
> If CONFIG_I2C is changed to build as a module, no crash occurs.

Hardly relevant, since this means CONFIG_FB_NVIDIA!=y as well.

> If CONFIG_FB_NVIDIA_I2C is not set, no crash occurs.
> If CONFIG_FB_NVIDIA is changed to build as a module, no crash occurs.

I guess the driver won't auto-load, so you should try to modprobe it
afterwards. Maybe it'll crash as well then.

Mike, can you please provide a decoded oops? There's not much we can do
without that.

I wonder if this problem could be related to this one:
http://bugme.osdl.org/show_bug.cgi?idC47

This too is a bit-banging I2C adapter, part of a framebuffer driver
(savage there instead of nv here).

Antonio, any idea? You wrote both drivers recently.

I'm rather ignorant when it comes to IRQs so I'm not sure I can really
help.

Thanks,
-- 
Jean Delvare
