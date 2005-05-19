From: motupota@yahoo.com (Jack Yindo)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: lm_sensors device request
Message-Id: <20040502190113.75974.qmail@web60802.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was wondering if you guys could add support for the
Texas Instruments tmp100, since I have no progamming
skills in c :)
The chip doesn't have an id, here's a dump
SMBus Register :$48
>   $00: $12   $01: $80   $02: $4B   $03: $50   $04:
> $00  $05: $00   $06: $00
> $07: $00
the temp is at the first value 12, in hex, so in dec
18 C.  I looked at the code for the lm75 and really
had no idea what I was looking at, it shouldn't be to
hard to add though, I think.


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
