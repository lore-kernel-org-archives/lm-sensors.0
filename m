From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 04 Oct 2005 23:39:00 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <20051004233813.4d207270.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
In-Reply-To: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stig,

One preliminary question: Did you attempt to contact Hans Berglund or
Oleg I. Vdovikin for their opinion on and testing of your patch?

> I have split the patch into two, annotated and signed off.  Patch 1 is 
> the bug fixes.  Patch 2 is a bit of code cleanup.  Some of patch 2 you 
> may think is not worth changing.  I have no problem with that.
> 
> On my system, the current elektor driver will oops on module load and 
> has no chance of working because the IO regions are not mapped.  Patch 
> 1 fixes it (for me).

Are you using mmapped=0 or 1? Wasn't it just a matter of using the
other? I guess there is a reason why this option exists.

I don't really feel qualified to review the first patch, as I have
relatively little idea how I/O mapping is supposed to work. Greg, want
to comment? All the (relatively) recent changes to the driver are
yours, although I'm not sure it actually means anything.

All I can offer myself are a few comments on the rest:

> +	pr_debug("i2c-elektor: Write %p 0x%02X\n", address, val & 255);

Can we get rid of that "& 255"? Looks pointless to me.

> +#if __alpha__
> +	/* API UP2000 needs some hardware fudging to make the write stick */
> +	iowrite8(val, address);
> +#endif

My understanding is that adding this here means that the following lines
later in the code:

>					/* I don't know why we need to
> 					   write twice */
>  					mmapped = 2;

could (and should) be removed. Right?

> +			printk(KERN_ERR "i2c-elektor: requested mem region (%#x:2) "
> +					"is in use.\n", base );

No dot at end of message please. Also a coding style problem, no space
before closing parenthesis.

> +		if( base_iomem = NULL ) {

Coding style.

> +			printk(KERN_ERR "i2c-elecktor: remap of memory region failed\n");

s/elecktor/elektor/

> +	pr_debug("registers %#x remapped to %p\n", base, base_iomem);

Please add an "i2c-elektor: " prefix as the other messages have.

As for the second patch, I'm globally happy with it, only a few minor
comments as well:

> -			       "i2c-elektor: requested I/O region (0x%X:2) "
> +			       "i2c-elektor: requested I/O region (%#x:2) "
>  			       "is in use.\n", base);

You could additionally drop the trailing dot.

> -					printk(KERN_INFO "i2c-elektor: found API UP2000 like board, will probe PCF8584 later.\n");
> +					printk(KERN_INFO
> +					       "i2c-elektor: found API UP2000 like board, will probe PCF8584 later.\n");

This is still too wide after your change. Please split the string, and
drop the training dot while you're there.

> -		printk(KERN_ERR "i2c-elektor: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
> +		printk(KERN_ERR "i2c-elektor: incorrect base address (%#x) specified for mmapped I/O.\n", base);

Likewise, please split into pieces so that it fits in 80 columns, and
drop the trailing dot.

Additional possible cleanup:

> 	printk(KERN_ERR "i2c-elektor: found device at %#x.\n", base);

This certainly isn't an error, and trailing dot can be dropped.

Care to respin the patches with the suggested changes? Then I'll push
them upwards.

Thanks for the good work,
-- 
Jean Delvare
