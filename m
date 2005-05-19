From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: arima computations updated
Message-Id: <20040527195422.16fb9013.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0405271646320.1458@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0405271646320.1458@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> (in0+1)*231/10000
> 
> print(quotient);
> reminder is handled this way:
> 
> newrem=reminder*10
> 
> if newrem<10000 then
> print("0%d",reminder);
> else
> print(reminder);
> end if

This is strange... They do a special case what <10000 but not when <1000
for example. So I guess that 1.0023 would appear ad 1.023? And I don't
see the benefit of *10.

> in2*296/10000
> 
> print(quotient);
> reminder is handled this way:
> 
> newrem=reminder*10
> 
> if newrem<10000 then
> print("0%d",reminder);
> else
> print( (reminder+600) );
> end if

Even stranger. I cannot see the idea behind the +600.

What does the print function exactly? Print the numerical value of eax?

> print((reminderofthis*256+quotientofthis)+400)

This goes completely weird. It's not even monotonic!

> 0000AC66  58                pop ax        ;ax holds reminder
> 0000AC67  B30A              mov bl,0xa
> 0000AC69  F6F3              div bl  	  ;do reminder /10, AH reminder
> 0000AC6B  660FB7C0          movzx eax,ax  ;extend to 32bit
> 0000AC6F  6605740E0000      add eax,0xe74 ;add 3700
> 0000AC75  E84DCE            call 0x7ac5   ;call print

Seems clear (unless your explanations don't match the code, I don't know
x86 asm enough to tell). But what does the print function exactly?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
