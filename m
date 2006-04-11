From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 11 Apr 2006 18:34:44 +0000
Subject: [lm-sensors] w83792d watchdog
Message-Id: <443BF6C4.6030803@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <442B0C6F.4080604@sh.cvut.cz>
In-Reply-To: <442B0C6F.4080604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

>>Hmm, you mean reading after reboot will not clear the bit?
>>Reading use i2cdump after reboot will clear the bit in my computer. 

I found the reason. The chip is powered from VSB which means that the chip
configuration survives power on/off. (For example I enabled watchdog in CR40
halted the machine, boot and the enwdt bit watch still set - and the timeout flag
too) Only plug/unplug of cable worked - this was expected ;)

It clears after the reboot too but I was somehow confused.

>>I tried write 0x33 and 0x55 to CR01, it seems only the last one is
>>enabled by reading CR02.

Yes same here too. Last value seems to enable it.

>>>2) I tried many ways to reset the watchdog timer but only 
>>>seems to work is to write 0xAA to CR1 and then 0x55 to re-enable it.
>>>    This seems bit strange because the computer can fail 
>>>just in between of this two writes Yes I know this is not 
>>>probable, but
>>>    the best method is just to re-write the timeout value or 
>>>rewrite the enable (0x55) - as others might do. Were there
>>>    some strange reason for this design?
>>>
>>
>>
>>I'm quite confusing about this.... Do you mean you can not set the
>>timeout value??
> 
> 
> I can but after for example one minute I need to refresh the watchdog
> so it wont boot the computer. As I have written I tried several methods to
> reset the counter back to count the the timeout value.

I tried again and just re-enabling the watchdog is not working, nor
writing new timeout value.

Moreover it seems that just enabling the watchdog without rewriting the timeout register first
will cause immediate reset.

Lets wait for FAE to answer, I will meanwhile test the class.

regards
Rudolf

