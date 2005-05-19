From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: arima computations updated
Message-Id: <Pine.LNX.4.58.0405272111520.1458@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0405271646320.1458@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0405271646320.1458@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > newrem=reminder*10
> >
> > if newrem<10000 then
> > print("0%d",reminder);
> > else
> > print(reminder);
> > end if
>
> This is strange... They do a special case what <10000 but not when <1000
> for example. So I guess that 1.0023 would appear ad 1.023? And I don't
> see the benefit of *10.

Its only multiplied to perform the test. Printing is done with original
numbers. I think its only some kind of padding, but next +600 is strange.


> > if newrem<10000 then
> > print("0%d",reminder);
> > else
> > print( (reminder+600) );
> > end if
>
> Even stranger. I cannot see the idea behind the +600.

Same problem.

> What does the print function exactly? Print the numerical value of eax?

See the end.

> > print((reminderofthis*256+quotientofthis)+400)
>
> This goes completely weird. It's not even monotonic!

I guess it should be swapped
so xchg al,ah  is missing but again the purporse is mysterious.

> > 0000AC66  58                pop ax        ;ax holds reminder
> > 0000AC67  B30A              mov bl,0xa
> > 0000AC69  F6F3              div bl  	  ;do reminder /10, AH reminder
> > 0000AC6B  660FB7C0          movzx eax,ax  ;extend to 32bit
> > 0000AC6F  6605740E0000      add eax,0xe74 ;add 3700
> > 0000AC75  E84DCE            call 0x7ac5   ;call print
>
> Seems clear (unless your explanations don't match the code, I don't know
> x86 asm enough to tell). But what does the print function exactly?

00007AC5  6633D2            xor edx,edx  ;zero edx
00007AC8  66B90A000000      mov ecx,0xa ;10
00007ACE  66F7F1            div ecx  	;divide
00007AD1  660BC0            or eax,eax	;is eax zero
00007AD4  7405              jz 0x7adb	;if so we are at the end.
00007AD6  52                push dx	;reminder in EDX
00007AD7  E8EBFF            call 0x7ac5 ;recursively call us again EAX is
                                        ;quotient
00007ADA  5A                pop dx	;restore digit
00007ADB  8AC2              mov al,dl   ;al=dl
00007ADD  0C30              or al,0x30  ;
00007ADF  268805            mov [es:di],al ;write one digit.
00007AE2  47                inc di ;inc pointer
00007AE3  C3                ret

It simply convert number stored in eax to string pointed by es:di register
pair. Its recursive to get right order.

sprintf(esdi,"%d",eax);

Regards

Rudolf
