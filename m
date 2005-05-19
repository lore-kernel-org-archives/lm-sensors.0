From: adaplas@hotpop.com (Antonino A. Daplas)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <200503162346.28272.adaplas@hotpop.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 16 March 2005 17:54, Jean Delvare wrote:
> Hi Mike, Antonio & all,
>
> > I narrowed the problem down.
> > In the following scenario, the OOPS occurs:
> > CONFIG_I2C=y
> > CONFIG_FB_NVIDIA=y
> > CONFIG_FB_NVIDIA_I2C=y
> >
> > If CONFIG_I2C is changed to build as a module, no crash occurs.
>
> Hardly relevant, since this means CONFIG_FB_NVIDIA!=y as well.
>
> > If CONFIG_FB_NVIDIA_I2C is not set, no crash occurs.
> > If CONFIG_FB_NVIDIA is changed to build as a module, no crash occurs.
>
> I guess the driver won't auto-load, so you should try to modprobe it
> afterwards. Maybe it'll crash as well then.
>
> Mike, can you please provide a decoded oops? There's not much we can do
> without that.
>
> I wonder if this problem could be related to this one:
> http://bugme.osdl.org/show_bug.cgi?idC47
>
> This too is a bit-banging I2C adapter, part of a framebuffer driver
> (savage there instead of nv here).
>
> Antonio, any idea? You wrote both drivers recently.
>
> I'm rather ignorant when it comes to IRQs so I'm not sure I can really
> help.
>

I've only seen the savage bug report.  Yes, unfortunately, this is the
case of 2 drivers attempting to control a single device since the savagefb
and the i2c prosavage drivers will attempt to ioremap the same mmio region.
If you need the i2c prosavage bus, then savagefb must be completely
disabled, as setting CONFIG_FB_SAVAGE_I2C to n will not help.  If both
savagefb and i2c are needed, then you just have to use the i2c bus
registered by savagefb. 

And yes, there is code duplication, but unfortunately savagefb cannot use
the i2c-prosavage bus since one of them will fail to acquire the io regions.

I haven't seen the nvidiafb report, but it is probably something similar.

This is similar to the fbdev/DRM problem of who owns the device.  We can
also throw in i2c bus drivers in the mix, at least for VGA devices. Perhaps a
low-level VGA driver (as proposed by Alan Cox) will be needed to resolve
this problem.

Tony

