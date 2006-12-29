From: a@gaydenko.com (Andrew Gaydenko)
Date: Fri, 29 Dec 2006 03:24:27 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <200612290624.27191@goldspace.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, David,

==== On Friday 29 December 2006 06:09, you wrote: ===>> AUX Temp doesn't change at all when both CPU are under heavy loading.
>> The sensor value is 119C always (it is for ASUS P5B-VM motherboard).
>
>Does this mean that SYSTIN also doesn't change? If so, only one of the
>cores has been wired to the w83627dhg.

No, it doesn't. 'SYS Temp' slightly changes in 49-52C range, in accordance
with BIOS monitor. Besides zalman for CPU there are two addtional silent
fans connected to 12V directly (well, via serial resistors). Probably this
is a reason for so small 'SYS Temp' changing range (BTW, I'm not an 
overcolcoker, my aim is a silence :-))

>Setting pwmX_enable to 0 is supposed to disable the pwm output for
>that fan, resulting in the maximum fan speed. The w83627ehf and
>w83627dhg do not have a way to disable the pwm output. Just write 255
>to pwmX.

OK, I'm tracing for SVN tree :-)

>
>> P.S. Must I use multiple "To:" in accordance with msg header, or must I answer
>>      to the mailing list only? (I use last variant now)
>
>The reason for including specific people in To: is so we know that you
>wanted us to read your message. We sometimes don't respond if you just
>post to the list, even though we are subscribed to the list.

I think the first rule is to avoid flooding of mail boxes. OK, I'll use all
"To:" fields for answers (and is ready to reduce to the mailing list only :-)).


Andrew

