From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: LM93 not getting fan nreading
Message-Id: <20041122074754.23cf53a0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041119122315.50064.qmail@web8506.mail.in.yahoo.com>
In-Reply-To: <20041119122315.50064.qmail@web8506.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>     In LM93 driver there is no such fan divisors
> present.Is there any other way to solve the problem.

Oh, you're right. It's quite rare to see fan monitoring chips without
dividers, sorry I missed that.

> Shall i get fan values by using 3 pin fan.It is
> specified in the data sheet that 4th pin is needed to
> get the fan values while using PWM.

If the datasheet says you need 4-wire fans, and it doesn't work without
it, then I guess you really need these. I believe these are rather news
since I never heard about nor saw 4-wire fans so far. Sounds like a
smart idea to allow PWM fan speed control while still reliably
monitoring the fan speed (which is hardly the case with 3-wire fans).

I cannot tell you more as I don't know the LM93 very well, nor do I know
your specific motherboard.

-- 
Jean Delvare
http://khali.linux-fr.org/
