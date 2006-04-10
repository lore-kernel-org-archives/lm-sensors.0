From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 10 Apr 2006 10:45:25 +0000
Subject: [lm-sensors] w83792d watchdog
Message-Id: <443A3745.9080507@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <442B0C6F.4080604@sh.cvut.cz>
In-Reply-To: <442B0C6F.4080604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> I have finished the w83793 driver, and i'm testing it.
> So i can be the tester if you need testers on watchdog now, 

Good.

> 
> Hmm, you mean reading after reboot will not clear the bit?
> Reading use i2cdump after reboot will clear the bit in my computer. 

I tried the SOFT watchdog and the bit seems sticky. I will test
this evening.

>>This is so far to datasheet, now to real funcs:
>>
>>1) What will happen if I enable hard and soft watchdog same 
>>time? (i'm disabling the hard watchdog timer in first place so
>>it should not be an issue but you never know)
> 
> 
> I tried write 0x33 and 0x55 to CR01, it seems only the last one is
> enabled by reading CR02.

Ok I will try too.

> 
> 
>>2) I tried many ways to reset the watchdog timer but only 
>>seems to work is to write 0xAA to CR1 and then 0x55 to re-enable it.
>>     This seems bit strange because the computer can fail 
>>just in between of this two writes Yes I know this is not 
>>probable, but
>>     the best method is just to re-write the timeout value or 
>>rewrite the enable (0x55) - as others might do. Were there
>>     some strange reason for this design?
>>
> 
> 
> I'm quite confusing about this.... Do you mean you can not set the
> timeout value??

I can but after for example one minute I need to refresh the watchdog
so it wont boot the computer. As I have written I tried several methods to
reset the counter back to count the the timeout value.

The only that worked so far is to disable/enable the watchdog which
is non-atomic operation. Other winbond watchdogs works different
way, sufficient is to rewrite the timeout for example.

Regards
Rudolf

