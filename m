From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 May 2011 15:01:30 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110513170130.70957eec@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 13 May 2011 14:48:01 +0200, Luca Tettamanti wrote:
> On Thu, May 12, 2011 at 05:49:44PM -0600, Harry G McGavran Jr wrote:
> > I went back through the logs to make sure there was nothing
> > about the latest i8k in them.  Actually I found only ONE
> > line in syslog:
> > 
> > May 11 11:07:12 XX kernel: [173400.479332]  [<ffffffffa00613f2>] 
> > i8k_hwmon_show_fan+0x32/0x40 [i8k]
> 
> Ok, this is consistent with the hung program reported by Jeff, there's
> an error at kernel level while the sensor is being read.
> 
> AMD64 Architecture Manual says that:
> 
>  (pushf) In 64-bit mode, this instruction defaults to a 64-bit operand
>  size and there is no prefix available to encode a 32-bit operand size.

D'oh. I suspected something like this, but given that pushfq exists, I
assumed pushf had to be different. I guess I shouldn't have assumed...

> 
> so my patch may be corrupting the stack. Lets try like this:
> 
> diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
> index d72433f..ee01716 100644
> --- a/drivers/char/i8k.c
> +++ b/drivers/char/i8k.c
> @@ -139,8 +139,8 @@ static int i8k_smm(struct smm_regs *regs)
>  		"movl %%edi,20(%%rax)\n\t"
>  		"popq %%rdx\n\t"
>  		"movl %%edx,0(%%rax)\n\t"
> -		"lahf\n\t"
> -		"shrl $8,%%eax\n\t"
> +		"pushfq\n\t"
> +		"popq %%rax\n\t"
>  		"andl $1,%%eax\n"
>  		:"=a"(rc)
>  		:    "a"(regs)
> 
> 
> If it still doesn't work we should involve someone who actually has a
> clue about x86 asm ;)

Hopefully it will work OK this time. I've updated the driver at:
  http://khali.linux-fr.org/devel/misc/i8k/
Harry, Jeff, care to try again? Thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
