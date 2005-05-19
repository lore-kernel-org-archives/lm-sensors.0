From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: pc87360 sensor-driver results
Message-Id: <20040503213514.3569d38c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sorry about not responding for the last few days; I was unaware that
> I would be unavailable during the weekend, and was thus unable to get
> in contact with HP, Asustek, or National Semiconductor. I don't think
> I'll have time today, but it will certainly be on my agenda for this
> week.

No problem. I had plenty of other issues to work on, and this gave me
some time to do some fixes and improvements to the driver.

> The output of sensors has an overall better look and feeling; it is
> much cleaner.

Great :)

> Fan speeds are still causing the same problem when pwm is changed
> here are the outputs of isadump -f 0xecc0 16 during pwm changing:

Let me summarize what I see here:

> pwm1 and pwm2 is 255
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 ff 00 ff 00 ff ff 0f 60 ff 00 64 ff 00 64 00

1* Fan 2 is already broken at the beginning of the experiment, although
both PWM are 255. Odd.

> pwm2 is 200
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 ff 00 c8 00 ff ff 0f 60 ff 00 64 ff 00 64 00
> 
> pwm2 is 230
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 ff 00 e6 00 ff ff 0f 60 ff 00 64 ff 00 64 00

2* Changing PWM 2 has no effect.

> pwm2 is 255 and pwm1 is 200
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 c8 00 ff 00 ff ff 00 64 ff 1b 60 ff 00 64 00

Fan 2 is working again, and now fan1 is broken.

> pwm 1 is 230
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 e6 00 ff 00 ff ff 00 64 ff 1b 60 ff 00 64 00
> 
> pwm1 is 240
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 f0 00 ff 00 ff ff 00 64 ff 1c 60 ff 00 64 00

No change here.

> pwm1 is 245 and pwm2 is 215
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 f5 00 d7 00 ff ff 00 64 ff 00 64 ff 00 64 00

Both fans are now OK.

I still don't get what's going on. If you want to experiment further,
there are two things you may try:

1* Changing PWM base clock:

isaset -f 0xecc0 3
isaset -f 0xecc2 3

And play with PWM again, and see if it changed anything.

2* Disabling control and monitoring, and reenabling it.

isaset 0x2e 0x2f 7 9
isaset 0x2e 0x2f 0xf0 0
isaset 0x2e 0x2f 0xf0 0xfc

And play with PWM again, and see if it changed anything.

I doubt it'll work, but there's nothing smart I can think of at the
moment.

I'll ask my other tester to try changing pwm values as well and tell me
if he observes the same problems as you.

There's another thing I would like you to do:

isaset -f 0xecd9 9
isaset -f 0xecda 1

sleep 2100
isadump -f 0xecd0 16 9 > pc87366-in9.dump

isaset -f 0xecd9 9
isaset -f 0xecda 0

This will temporarily enable Vbat monitoring, wait for it to be updated
(may take up to 34 minutes, thus the sleep) and grab its value, then
disable it again.

My other tester has a strange value for Vbat (1.02V, should be 3.0V) and
I wonder if it'll be the same for you or not.

And please provide in8 dump again:

isadump -f 0xecd0 16 9 > pc87366-in8.dump

It is disabled in your previous dump (while the driver now enables it on
load, so it is enabled).

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
