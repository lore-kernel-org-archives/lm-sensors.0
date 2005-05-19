From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: linux 2.6 port of smsc47m1
Message-Id: <4095741D.6090805@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040429023201.89488.qmail@web20802.mail.yahoo.com>
In-Reply-To: <20040429023201.89488.qmail@web20802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Gabriele, I reviewed the code and the datasheet and I agree with Jean that the
code looks totally broken. On the other hand you would think I tested the
driver when I wrote it. Would you please test the PWM operation in the current driver,
including the PWM enable?
Running our pwmconfig script would be a good test.
thanks
mds

Jean Delvare wrote:
> Quoting myself:
> 
> 
>>That's about all for this first check. I have yet to take a look at
>>the sysfs callback functions.
> 
> 
> OK, I just did this. Your code is correct in the sense that it does the
> same as what the 2.4/CVS driver does. However, I have noticed a number
> of strangenesses, and think this is the right time to discuss them.
> 
> First, there is no lock on read/write. There is a lock for the update
> function, but that's about all. It's obviously not sufficent. Usually,
> drivers have a second lock for read and write operations.
> 
> Second, I'm really confused by the operations made on the PWM registers.
> When reading the code, it looks like bit 7 is for enabling PWM and bits
> 6-0 hold the duty cycle value. Except that only bits 5-0 can be set,
> and the conversions macros are odd. When looking at the datasheet OTOH,
> I read that PWM enable is bit 0, inverted (1 actually disables PWM),
> and value is in bits 6-1. Bit 7 is a clock modifier, we don't care.
> Conversions would be as simple as multiplying / dividing by 4 (with
> some rounding if you want).
> 
> Mark, am I missing something here or is PWM handling in the smsc47m1
> driver plain broken? I'd be surprised that nobody reported so far if it
> is, but sometimes we get surprised.
> 
> Another point that could be improved in the 2.6 driver is the fan
> divisor setting. Instead of defaulting to 2 on invalid sets, you should
> refuse them and return -EINVAL. This couldn't be done in the 2.4
> driver, but it can be in 2.6, so let's do it. A number of drivers
> already do (fscher.c was the first IIRC).
> 
> Thanks.
> 
