From: tandrews@grok.co.za (Thomas Andrews)
Date: Thu, 04 May 2006 06:32:05 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060504063205.GG19375@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Wed, May 03, 2006 at 11:24:23PM -0400, Jim Cromie wrote:

> This is premature, and hugely incomplete - (basically one observation)

Even so I really appreciate it! :)
 
> >+	// Select ACB0 (LDN 5)
> >+	outb(0x07,sio); // LDN select register
> >+	outb(0x05,val); // Choose LDN 5 ie ACCESS.bus 1
> >+	outb(0x60,sio); // Select I/O port 0 base addr
> >+	h1 = inb(val);
> >+	outb(0x61,sio);
> >+	l1 = inb(val);
> >  
> 
> please use these helper functions - lifted verbatim from another patch.
> These show up in various superio drivers in lm-sensors, consistency is good,
> and will help later if we need to mediate access to the SIO port,
> to share it amongst multiple drivers.
> 
> +
> +static inline void superio_outb(int reg, int val)
> +{
> +	outb(reg, SIO_REG_CIP);
> +	outb(val, SIO_REG_DIP);
> +}
> +
> +static inline int superio_inb(int reg)
> +{
> +	outb(reg, SIO_REG_CIP);
> +	return inb(SIO_REG_DIP);
> +}
> +
> +static inline void superio_select(int ldn)
> +{
> +	outb(SIO_VT1211_LDN, SIO_REG_CIP);
> +	outb(ldn, SIO_REG_DIP);
> +}
> +
> +static inline void superio_enter(void)
> +{
> +	outb(0x87, SIO_REG_CIP);
> +	outb(0x87, SIO_REG_CIP);
> +}
> +
> +static inline void superio_exit(void)
> +{
> +	outb(0xaa, SIO_REG_CIP);
> +}

I can't use those helper functions as is, because the whole purpose of
my patch is so that you can move away from using a #define for
SIO_REG_CIP. I'll write some equivalents for this module which use a
parameter instead.

> I havent actually checked, but it would be nice if you used the -p option
>   -p     Show which C function each change is in.

Thanks, I will use -p in future.

> and eventually, you'll probly need to do something about the nesting level.
> // and the c++ comments. :-(

I've changed all the comments to /* */ style.

Regards,
Thomas

