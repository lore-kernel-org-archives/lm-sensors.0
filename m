From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <20030925235015.4c196a08.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > +	   This sets fan-divs to 2, among others.
> >
> > Where does it do that? Can't find it.
> 
> That comment refers to the reset i.e. write 0x80 into register 0x00.

Oh, OK, I missed that at first.

> > The datasheet actually says that fan_div3 can be set to either 2 or
> > 8. It's controled by bit 6 of register 0x0b. It differs from the
> > other two divisors in that it is coded on a single bit while the
> > others have three, which let them chose between 8 different divisors
> > from 1 to 128. You could as well consider that the bit 6 of register
> > 0x0b controls the*second* bit of fan_div3, which MSB and LSB are
> > fixed to 0 and 1, respectively. This make div3 look more like div1
> > and 2 (to me at least, and should help in the code too).
> 
> Where did you get this info from? In the "IT8705F Preliminary
> Environment Controller (EC) Programming Guide V0.3"
> (it8705f_PG_ec_v03.pdf) I can't find it. There the bits 7 and 6 of
> register 0x0b are only descripted as reserved. I downloaded above
> pdf-file directly from ITE Inc's web side!

The version I have says:

7   -   Reserved
6  R/W  FAN_TAC3 Counter Divisor
        0: divided by 2
        1: divided by 8

I don't remember where I got it from, although I'm pretty sure I also
got them from ITE's website. I don't remember the original name either
(I'm renaming files to a standardized format). Maybe the filesize will
help:

1644525 Jul 18  2000 IT8702-0.3.pdf
1281351 Mar 16  2001 IT8705F-p1-0.3.pdf <-- this one
 657518 Mar 16  2001 IT8705F-p2-0.3.pdf
1150423 Mar 25  2002 IT8712F-0.6.pdf
 993541 Jun 11 09:20 IT8712F-0.7.pdf

I may send any of them to you if you want.

> > (BTW, does this really compile? I thought you couldn't declare a
> > variable after real code in a given block.)
> 
> Umm..., I'm a C++ guy :-) and in C++ it is perfectly OK to declare a
> variable anywhere inside a block. It compiles perfectly with gcc 3.3.1
> on my SuSE 8.2 box, anyway.

Still I don't want this in our repository.

> > You don't need a special case for 1, unless I'm missing something.
> > And you definitely want to return 1 as the default value, as it was
> > the case before, because fan_div = 2 is a reasonable default. I also
> > believe that we should try to find out the nearest divisor from what
> > the user entered. Setting the divisor to 128, or either 2 , when the
> > user asked for 31, is poor. We can do better than that. What about
> > that:
> >
> > extern inline u8 DIV_TO_REG(long val)
> > {
> > 	u8 i;
> > 	for( i = 0; i < 7; i++ )
> > 		if( val>>i = 1 )
> > 			return i;
> > 	return 2;
> > }
> >
> > This considers the highest weighted bit, whatever the lower bits are
> > set to.
> 
> OK, but it your code returns the register value for a divisor of four
> (4) in case the desired value is greater than 32 (=1<<6), it should be
> a seven for a divisor of 128.
> [...]
> 	return 7;
> }

We're both wrong here. I am because what I wanted is return 1 (for a fan
divisor of 2, as said above). You are because 1<<6 is 64, not 32 ;) And
I am once again because the condition is "i <= 7", not "i < 7". So this
should read:

extern inline u8 DIV_TO_REG(long val)
{
	u8 i;
	for( i = 0; i <= 7; i++ )
		if( val>>i = 1 )
			return i;
	return 1;
}

Is it OK now?

> > I want the chip reset (0x80 at 0x00) gone, and everything else that
> > causes trouble with it. The rest will be kept, inside an init=1
> > conditional. Is it OK?
> 
> It's fine with me, thought I felt better keeping the chip reset in,
> too. Inside a if(reset=1) with reset defaulting to 0.

OK for me.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
