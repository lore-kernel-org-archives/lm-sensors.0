From: Michael Zintakis <michael.zintakis@googlemail.com>
Date: Sun, 01 Jul 2012 10:03:05 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <4FF02059.7070601@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> So, I have the following values by default:
>>
>> pwm1_auto_channels_pwm = 1 (1 binary - fan1)
>> pwm2_auto_channels_pwm = 2 (10 binary - fan2)
>> pwm3_auto_channels_pwm = 4 (100 binary - fan3)
>>
>>     
> Guess you mean pwm[1-3]_auto_channels_temp.
>   
Yeah, that's right.

> You are right - sorry for that. I looked into the driver. The chip
> understands [1, 2, 3], but the driver maps those values into a bit map,
> where only one bit can be true at any given time.
>   
OK, nice to know as when I set it up (with "echo X > ...") I can't use 
anything other than 1, 2 or 4 so was a bit surprised that 3 is supposed 
to be the correct value.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
