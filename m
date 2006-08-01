From: YouEatlard@cox.net (John Kester)
Date: Tue, 01 Aug 2006 02:20:35 +0000
Subject: [lm-sensors]  New device: SMSC's  EMC6W201 -support?
Message-Id: <000001c6b511$13306cd0$3401a8c0@towerlard>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060115233832.76526.qmail@web81604.mail.mud.yahoo.com>
In-Reply-To: <20060115233832.76526.qmail@web81604.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ric,
 
I'm currently working with Alfredo Milani Comparetti (programmer for
SpeedFan) on getting SpeedFan for Windows up and running with this
board. I haven't done any scripting or C programming years, but I am
willing to try my hand at it to get the Linux version up.  
 
>Here's what I have so far:
>
>Alfredo,
>     Thanks for your response. I just spent about an hour looking at
the motherboard with a 3 inch magnifying >glass and can only guess which
it is. None of them are actually labeled EMC6W201. None are even labeled
with the >manufacture's name (SMSC). Even better, the chip is supposed
to have 9 pins per side making it a 36 pin chip and >there are no chips
on my board that match that either. There are only 8 pins per side that
are actually >connected per the chip's diagram so I'm guessing pin #9
actually isn't there, or that there is another pin per >side that the
diagram doesn't list.
>
>Here my guesses:
>B5011A-1KFBG
>CT01515 P11
>741323P
>
>ISL
>6539CA2
>GO522BBGD
>
>ICS
>8634BY0IL
>
>The board has 7 fan headers, all have a monitor pin.(BIOS monitors 5) 
>BIOS monitors 4 temperatures and 5 voltages
>
>Beyond this all I can give you is sources for tech data and maybe
another source of info
>Block diagram:
>http://www.2cpu.com/Files/2CEWH_RH_BLOCK_DIAGRAM.pdf       
>EMC6W201 product page:
>http://www.smsc.com/main/catalog/emc6w201.html#Additional
>Product preview with block diagram
>More info posted by Ric Johnson:
>http://lists.lm-sensors.org/pipermail/lm-sensors/2006-January/015023.ht
ml
>
>Thank you for your time,
>
>--John
>
>-----Original Message-----
>>From: Alfredo Milani-Comparetti [mailto:alfredo at milanicomparetti.com] 
>>Sent: Monday, July 17, 2006 8:21 AM
>>To: YouEatLard at cox.net
>>Subject: Re: SF DEBUG Story (N) (NNN) (v4.28)
>>
>>> SpeedFan version : SpeedFan 4.28
>>> Motherboard model : GA-2CEWH
 
>>> SMB Dump from address $2E --> <Unknown> (SMBus at $5040) (No error)
>>> 30: B7 03 C3 06 FA 06 80 80 80 00 00 00 00 00 5C B1
..............\.
 
>>> I''m currently looking into finding what monitors the processor
temperatures. My
>> guess is that the EMC6W201 is doing it, but I''m not havng much luck
tracking it
>>> down. Others with this board are having the same problem. I looked
through the
>>> data and it seems to all be correct. FYI: The EMC6W201 runs off the
NVidia CK804
>>> chipset. FYI: This board does have have 3 chipsets. Let me know if
you need a
>>> block diagram of the board. I only have the basics, but even this is
more then
>>> NVidia normally puts out.
 
>>The chip at $2E identifies itself with numbers $5C $B1. EMC6W201
should have 
>>$5C $B0. If you can read the actual chip name and tell me exactly
what's 
>>written on it, I will try to figure out what to do.
 
>>Alfredo Milani Comparetti
>>alfredo [at] milanicomparetti.com
>>SpeedFan home page --> http://www.almico.com/speedfan.php
>>Delphi home page --> http://www.almico.com/delphi
>>Elf home page    --> http://www.radsite.com/elf
 
I've also been talking to Gigabyte, but standard tech support... is
standard tech support.
Please let me or him know if anything changes on the knowledge base is
of things.
 
-John Kester
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060731/cebcf95e/attachment-0001.html 
