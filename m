From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050209220906.21fa245b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> OK here's the latest. It looks like we are making progress.
> 
> Now when I scan the ISA bus, I get this:
> Probing for `Winbond W83627EHF'
>   Trying address 0x0290... Success!
>     (confidence 8, driver `to-be-written')
> 
> Then under Super I/O sensors:
> Probing for `Winbond W83627EHF Super IO Sensors'
>   Success... found at address 0x0290
> 
> But under Secondary Super I/O:
> Probing for `Winbond W83627EHF Super IO Sensors'
>   Failed! (skipping family)

Alright, finally what I expected :)

Tests are finished for now, sensors-detect is W83627EHF aware. Next step
would be to write the driver itself, but this is much more work, of
course.

-- 
Jean Delvare
