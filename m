From: michael.hufer@freenet.de (Michael Hufer)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <200309251933.39908.michael.hufer@freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'd really like you to investigate and find out which other settings
> were affecting the PWM setup. I don't want to remove all initialization
> code because we don't know which part of it causes problems.

Well, problem is a bit harsh, the init switched off the power supply's fan. I 
switched off the complete init shortly after starting this little project and 
didn't bother to investigate further as it did what I wanted it to do :-). 
I've some idea now what was causing this and I'll see if I can fix it.

> +	   This sets fan-divs to 2, among others.
>
> Where does it do that? Can't find it.

That comment refers to the reset i.e. write 0x80 into register 0x00.

>
> -		data->fan_div[2] = 1;
> +		data->fan_div[2] = data->fan_div[2];
>
> No comment.

Sometimes even I'm wondering about why I did things the way I did. I stumpled 
about this yesterday, too 
.. and removed it. :-) 

> +		if (*nrels_mag >= 3) {
> +			data->fan_div[1] = DIV_TO_REG(results[2]);
> +		}
>
> This must be fan_div[2] there.

Ouch, I did correct this in the kernel source tree - where I compiled the 
module - but forgot to merge the change back into the lm_sensors-cvs 
checkout.

> So this just can't work the way you want, unless you wanted it broken
> from the start ;) Understand me, I don't want to blame you, I'm
> particularly happy that you wrote that patch. But it obviously requires
> more reviewing and testing before we can commit it to our CVS
> repository.
> [...]
> The datasheet actually says that fan_div3 can be set to either 2 or 8.
> It's controled by bit 6 of register 0x0b. It differs from the other two
> divisors in that it is coded on a single bit while the others have
> three, which let them chose between 8 different divisors from 1 to 128.
> You could as well consider that the bit 6 of register 0x0b controls the
> *second* bit of fan_div3, which MSB and LSB are fixed to 0 and 1,
> respectively. This make div3 look more like div1 and 2 (to me at least,
> and should help in the code too).

Where did you get this info from? In the "IT8705F Preliminary Environment 
Controller (EC) Programming Guide V0.3" (it8705f_PG_ec_v03.pdf) I can't find 
it. There the bits 7 and 6 of register 0x0b are only descripted as reserved. 
I downloaded above pdf-file directly from ITE Inc's web side!

> BTW,
>
> -#define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
> +extern inline u8 DIV_TO_REG(long val)
> +{
> +	if( val = 1 )
> +		return 0;
> +	u8 i;
> +	for( i = 1; i < 7; i++ )
> +	{
> +		if( val = 1<<i )
> +			return i;
> +	}
> +	return 7;
> +}
>
> (BTW, does this really compile? I thought you couldn't declare a
> variable after real code in a given block.)

Umm..., I'm a C++ guy :-) and in C++ it is perfectly OK to declare a variable 
anywhere inside a block. It compiles perfectly with gcc 3.3.1 on my SuSE 8.2 
box, anyway.

> You don't need a special case for 1, unless I'm missing something. And
> you definitely want to return 1 as the default value, as it was the case
> before, because fan_div = 2 is a reasonable default. I also believe that
> we should try to find out the nearest divisor from what the user
> entered. Setting the divisor to 128, or either 2 , when the user asked
> for 31, is poor. We can do better than that. What about that:
>
> extern inline u8 DIV_TO_REG(long val)
> {
> 	u8 i;
> 	for( i = 0; i < 7; i++ )
> 		if( val>>i = 1 )
> 			return i;
> 	return 2;
> }
>
> This considers the highest weighted bit, whatever the lower bits are set
> to.

OK, but it your code returns the register value for a divisor of four (4) in 
case the desired value is greater than 32 (=1<<6), it should be a seven for a 
divisor of 128.
[...]
	return 7;
}

> > It could be made default not to reset the chip but as there might be
> > a BIOS/motherboard out there that does not correctly initialize the
> > chip, there should be a way to reset the chip on module load.
>
> So far, the BIOS seems to have been more clever than we were ;)
>
> I want the chip reset (0x80 at 0x00) gone, and everything else that
> causes trouble with it. The rest will be kept, inside an init=1
> conditional. Is it OK?

It's fine with me, thought I felt better keeping the chip reset in, too. 
Inside a if(reset=1) with reset defaulting to 0.
