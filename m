From: lourens@rainbowdesert.net (Lourens Veen)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Strange values on ASRock K7S8X mainboard with W83697 chip
Message-Id: <200407240015.08951.lourens@rainbowdesert.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407221213.00965.lourens@rainbowdesert.net>
In-Reply-To: <200407221213.00965.lourens@rainbowdesert.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Theory: the hardware guys at ASRock miswired in5 and in6. The
> > BIOS software guys programmed the BIOS according to the
> > datasheet. When testing, they noticed the problem, and disabled
> > the negative voltage readout. It is a low-budget product after
> > all, so fixing the hardware might simply have been too
> > expensive. And negative voltages are hardly used in todays PCs
> > anyway.

Looks like I was wrong. I just talked to Khali on IRC, and he gave 
me some tips which seem to work. So, for future reference, here is 
what seems to be the right configuration for the ASRock K7S8X:

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10)+1)*@  ,  @/((30/10)+1)
    compute in5 -((30/10)+1)*@  ,  -@/((30/10)+1)
    compute in6 -((6.8/10)+1)*@ ,  -@/((6.8/10)+1)

Also note the 30 instead of the default 28, that solves the too-low 
reading and it's been used on other mainboards as well according to 
Khali.

I'll still let you know if/when I get more from ASRock.

Lourens
-- 
GPG public key: http://home.student.utwente.nl/l.e.veen/lourens.key

