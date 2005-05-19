From: kumar.gala@freescale.com (Kumar Gala)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH] I2C-MPC: use wait_event_interruptible_timeout
Message-Id: <4A7789C4-65C0-11D9-B612-000393DBC2E8@freescale.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0501131647540.26980@blarg.somerset.sps.mot.com>
In-Reply-To: <Pine.LNX.4.61.0501131647540.26980@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

I will send it in a more "official" way shortly.  I will also have some 
patches to allow building the driver for OCP (on-chip peripheral, the 
old PPC way of doing drivers) or as a platform_device.  This is meant 
to act as an interim until we can convert all the various PPC sub-archs 
to use platform_devices (at which point, I will kill the OCP side of 
the driver).

- kumar

On Jan 13, 2005, at 5:36 PM, Greg KH wrote:

> On Thu, Jan 13, 2005 at 04:50:52PM -0600, Kumar Gala wrote:
>  > I've changed the i2c-mpc.c driver to use 
> wait_event_interruptible_timeout
> >
> > Can you take a look and let me know if this looks good.? I'm going 
> to have
> > some other changes to the driver to handle moving it from an OCP 
> based
> > driver to using platform_device.
>
> Looks sane to me.? You've tested this out?? If you're comfortable with
>  it, care to resend it with a "Signed-off-by:" line to me so I can 
> apply
>  it to the kernel tree?
>
> thanks,
>
> greg k-h

