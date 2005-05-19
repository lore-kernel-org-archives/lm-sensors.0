From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <408476E5.7000809@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
>>the point is that we tell people what's at 0x30, that it's associated
>>with what's at 0x50.
> 
> 
> If we follow my idea to use reads instead of quick writes for the
> 0x30-0x37 range, then the user doesn't see 0x30 as holding a device, so
> we don't have to tell him what's there.
> 
> 
>>I went through the datasheets of the Microchip and ST parts pretty
>>carefully yesterday, it's clear that it's a byte-write-data that
>>does the write-protect.
> 
> 
> And other chips (Fairchild NM34W02) say "byte write". If that's "byte
> write" in the SMBus way, then it's a 2-byte command (as opposed to
> 3-byte byte-write-data). I wouldn't swear that we will never see a chip
> for which a quick write would be sufficent.
> 

The NM34W02 datasheet makes clear in Figure 5 what a byte write is,
it's what we call byte-write-data.
The ST M34C02 datasheet has the same thing in Figure 6.
You're right we can't guarantee it. But the datasheets I've seen
have been quite consistent.


> My point is that I don't see the benefit in telling the user that he has
> a write-protectable EEPROM, while I see the potential danger in
> quick-writing the eeprom's write-protect address.
> 

Maybe it's a value to tell the user what it is.
But we've been telling them for years it's a "shadow",
maybe it doesn't add any value to tell them otherwise.

We've been using quick write for years, and haven't ever had a report that
somebody saw something once at 30-37 and never again.
Of course who would notice such a thing?

> I would suggest that we comment out the eeprom with $chip = 2 in
> @chips_id by default. We can leave it in if some people happen to need
> it, but not do it by default.
> 

If you wish. I did it as an experiment.

> BTW, at least one EEPROM model (Catalyst CAT34RC02) can also read byte
> from its write-protection address, so your detection method would miss
> it.
> 

Correct. We'd have to add it as yet another eeprom chip type.
Which stretches things even more.


> 
>>Clearly the Vaio detection in eeprom_detect() was being called
>>both for chip=0 and chip=1, so I changed it so it was only called
>>for chip=1. I didn't realize that you did it for both to
>>reduce "noise". IMO not doing things twice is better than
>>reducing "noise".
> 
> 
> Granted. The global detection scheme is poor but making detection
> functions more complex to compensate that isn't the right thing to do, I
> admit. I think that my main reason for doing that was because
> sensors-detect used to suggest bogus module options in that case. Then I
> fixed that but did not revert the detect_eeprom function.
> 
> 
>>Perhaps a better long-term solution is to call a detection
>>routine once and allow it to return different names,
>>rather than calling it multiple times, one for each chip name.
> 
> 
> Yes, I think that would be the correct way. But this means much work...
> 

p.s. sorry I vanished from IRC on Sunday, I got busy...
