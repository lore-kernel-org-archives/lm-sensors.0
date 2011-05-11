From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 May 2011 15:08:17 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110511170817.08d8a203@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 May 2011 16:28:04 +0200, Luca Tettamanti wrote:
> On Wed, May 11, 2011 at 04:15:45PM +0200, Jean Delvare wrote:
> > On Wed, 11 May 2011 15:48:59 +0200, Luca Tettamanti wrote:
> > > The driver uses lahf to copy the lowest byte of EFLAGS to eax, then
> > > shifts it to right and test the lowest bit (CF).
> > > Using pushf instead we get the whole EFLAGS and test the lowest bit.
> > > Does it make sense? Someone should double check the patch, I don't trust
> > > my assembly skills ;)
> > > 
> > > diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
> > > index d72433f..3554d10 100644
> > > --- a/drivers/char/i8k.c
> > > +++ b/drivers/char/i8k.c
> > > @@ -139,8 +139,8 @@ static int i8k_smm(struct smm_regs *regs)
> > >  		"movl %%edi,20(%%rax)\n\t"
> > >  		"popq %%rdx\n\t"
> > >  		"movl %%edx,0(%%rax)\n\t"
> > > -		"lahf\n\t"
> > > -		"shrl $8,%%eax\n\t"
> > > +		"pusfh\n\t"
> > 
> > I think you meant pushf, not pusfh, right?
> 
> Yeah, right... hand me that brown paper bag ;)
> 
> > 
> > > +		"popl %%eax\n\t"
> > >  		"andl $1,%%eax\n"
> > >  		:"=a"(rc)
> > >  		:    "a"(regs)
> > 
> > I am no asm expert, but I don't get why you removed the shrl
> > instruction. As I understand it, your pushf+popl replaces only lahf,
> > the bit shifting is still needed (I assume the code wants to test bit 8
> > in the flag register.)
> 
> AFAIK lahf loads the lowest byte of EFLAGS into AH which is the upper
> half of AX, hence the shift.

Yes, you're right, of course. So much for my asm skills. Please return
the brown paper bag to me when you're done ;)

> The popl is wrong though, pushf only pushes 2 bytes... so let's try
> again:
> 
> diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
> index d72433f..f71f266 100644
> --- a/drivers/char/i8k.c
> +++ b/drivers/char/i8k.c
> @@ -139,8 +139,8 @@ static int i8k_smm(struct smm_regs *regs)
>  		"movl %%edi,20(%%rax)\n\t"
>  		"popq %%rdx\n\t"
>  		"movl %%edx,0(%%rax)\n\t"
> -		"lahf\n\t"
> -		"shrl $8,%%eax\n\t"
> +		"pushf\n\t"
> +		"pop %%ax\n\t"
>  		"andl $1,%%eax\n"
>  		:"=a"(rc)
>  		:    "a"(regs)

Looks reasonable. I can't test it as I don't have the hardware, but I
have updated the driver at:
  http://khali.linux-fr.org/devel/misc/i8k/
with the above fix. Jeff, Harry, can you test?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
