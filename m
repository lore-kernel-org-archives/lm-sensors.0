From: Arun Raghavan <arraghav@gmail.com>
Date: Tue, 26 Oct 2010 13:43:47 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <AANLkTi=sR2KUNms_Y__3YvUgaUZT7KfRjh1FGDbhfHqf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> On Sun, 24 Oct 2010 21:40:38 -0400, Arun Raghavan wrote:
>> Thanks again for the prompt response. One more question regarding
>> coretemp: any idea how I can probe the sensor in my own source code?
>> I'm hoping to be able to probe a few times a second, while the
>> lm-sensors usage guide says max. probing frequency should be at most
>> 0.3-0.5 Hz.
>
> Out of curiosity, which "usage guide" are you referring to?
>
'Usage guide' was probably misleading, I meant the FAQ:
http://www.lm-sensors.org/wiki/FAQ/Chapter1

[snip]
> There's no reason why overclocking would help. Overclocking will
> generate more heat, but the time it takes to generate it won't change.
>
Since the maximum temperature was higher, I was hoping to see some
intermediate reading
between idle and fully-loaded temperatures.

[snip]
> Arun, back to your immediate issue, you have two options, either
> rebuild the coretemp driver with a shorter cache lifetime (replace HZ
> with HZ/10 in function coretemp_update_device) or access the MSR
> yourself from user-space (but then you lose all the power of
> libsensors.)
>
Thanks for the suggestion, I will try it. Is it known how frequently the sensors
actually update the readings?

thanks,
-arun

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
