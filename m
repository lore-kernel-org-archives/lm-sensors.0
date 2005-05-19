From: gene.heskett@verizon.net (Gene Heskett)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <200308031457.37236.gene.heskett@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday 03 August 2003 10:54, Jean Delvare wrote:
>> >It seems that the adm1021 module isn't used, so you may not load
>> > it.
>>
>> Humm, I wonder where I got that from originally?  rmmod'ing it
>> speeds up the report, a lot!  I'll take that puppy out of rc.local
>> and modules.conf forthwith.  Thanks for spotting that.
>
>The module has 9 different addresses to check (must be the one that
> has more), that's why it must be slow.
>
>> Ah, I didn't know that.  The +1.66 is the -.100 in the current
>> bios setting, and it did cool it down 5 or so degrees.  It should
>> be running 1.75 volts. On inspection I find this:
>>
>>     set in0_min 1.8 * 0.95
>>     set in0_max 1.8 * 1.05
>>
>> I lowered the 1.8 to 1.75 in both lines but that didn't change the
>> report.  Is that incorrectly formatted?
>
>No, the line is correct, but I suspect you forgot to run "sensors
> -s".
>
Duh!

>> >Voltages are correct, except V5SB which is a bit high.
>>
>> Whats that feed?  Its not adjustable by any means that I know of,
>> this is a Biostar M7VIB board. But I'm thinking about replacing it
>> with an M7VIK.
>
>It is the stand-by voltage. It's not used if you don't leave you
>computer in standby mode. Anyway, as you noticed, there's no way to
>adjust the value, so let's forget about it.

Thanks Jean. 2.7.0 is now doing what its supposed to I believe.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
