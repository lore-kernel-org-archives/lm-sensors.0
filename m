From: michael.hufer@freenet.de (Michael Hufer)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <200309262025.27111.michael.hufer@freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I found and fixed the little problem I had with the original chip 
initialization. I can now load the module with reset_it87=0 and init=1  
without messing up the settings of the power supply fan from the BIOS. It was 
quite simple after all.

> > Where did you get this info from? In the "IT8705F Preliminary
> > Environment Controller (EC) Programming Guide V0.3"
> > (it8705f_PG_ec_v03.pdf) I can't find it. There the bits 7 and 6 of
> > register 0x0b are only descripted as reserved. I downloaded above
> > pdf-file directly from ITE Inc's web side!
>
> The version I have says:
>
> 7   -   Reserved
> 6  R/W  FAN_TAC3 Counter Divisor
>         0: divided by 2
>         1: divided by 8
>
> [...]
> 1281351 Mar 16  2001 IT8705F-p1-0.3.pdf <-- this one
>  [...]
> I may send any of them to you if you want.

OK, this is the complete datasheet for the chip, I have it, too. But I only 
precursory read and compared it to the hardware monitoring specific 
programming guide which I then used for the implementation. I missed the 
small differences in the register descriptions. 
I changed the code for fan_div3 to read and write this bit. 
Lets see, I'll let the driver set this bit if the desired divisor value for 
fan3 is greater or equal eight (>= 8) and clear it for a divisor < 8. Or do 
you want a different behaviour.

> > > (BTW, does this really compile? I thought you couldn't declare a
> > > variable after real code in a given block.)
> >
> > Umm..., I'm a C++ guy :-) and in C++ it is perfectly OK to declare a
> > variable anywhere inside a block. It compiles perfectly with gcc 3.3.1
> > on my SuSE 8.2 box, anyway.
>
> Still I don't want this in our repository.

Sure, I just pointed out that it is valid C++ code and also compiles in gcc's 
C-mode.

> extern inline u8 DIV_TO_REG(long val)
> {
> 	u8 i;
> 	for( i = 0; i <= 7; i++ )
> 		if( val>>i = 1 )
> 			return i;
> 	return 1;
> }
>
> Is it OK now?

OK, I'm currently using and testing it with the latest changes for the 
fan_div3 read and write to chip and above DIV_TO_REG(). Seem to work OK.

Do you want me to send the latest diff?

	Micha.
