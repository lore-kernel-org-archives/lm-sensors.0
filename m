From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: rpm of 0 with smsc47m1 does not cause alarm
Message-Id: <41978662.8060902@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41879A3F.3050304@earthlink.net>
In-Reply-To: <41879A3F.3050304@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I looked at this also and the datasheet seems clear that the alarm bits in register 4 do not require the corresponding
bits in the enable register (0x0a) to be set, so I don't get it.
The only thing I can think of is that the documentation is wrong; setting the bits in the enable register
as follows
	isaset -f 0x68a 0xd8
would show us whether this is true.

Jean Delvare wrote:
> Hi David,
> 
> 
>># isadump -f 0x0680 0x80
>>
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>00: 01 00 01 00 18 ff e7 18 00 00 18 00 00 00 00 00
>>10: 02 06 67 18 c0 00 00 00 00 00 00 00 00 00 03 03
>>20: 81 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
>>30: 00 00 00 05 05 04 04 01 00 04 84 84 00 01 01 05
>>40: 05 05 04 05 04 05 04 01 01 00 00 00 84 13 04 57
>>50: 00 00 00 00 00 00 14 14 f0 ff ff 68 68 00 00 00
>>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> Bits 6 and 7 of register 0x04 are actually cleared, so this is no driver
> bug. The chipset doesn't set the flags. After reading the datasheet
> again, I don't thing there is a way to disable them, so they have to be
> enabled (but not set at the moment). Could be that the chipset does only
> raise an alarm on slow fan, not on stopped/absent fan. Doesn't make much
> sense of course, but that may still be true.
> 
> I'd suggest that you give a try with a working fan and make sure you get
> a valid speed reported. Then change the low limit above the fan speed,
> and see if the alarm triggers. If it does, but disappears if you then
> unplug the fan, then I guess it validates my theory.
> 
> We may consider faking the alarm bits it this specific case, since it's
> odd that the chipset doesn't do it, and is contrary to what other chips
> such as the LM87 do, if I'm not mistaken.
> 
