From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Ticket #1941: nforce4 support in sensors-detect
Message-Id: <20050328095315.503f3a6c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050325220626.4fdc613c.khali@linux-fr.org>
In-Reply-To: <20050325220626.4fdc613c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Yeah, the new script doesn't help since I do have the IT8712F chip.
> Here's:
> # cat /proc/ioports
> (...)
> 0170-0177 : ide1
> 02f8-02ff : serial

So the 0x290-0x297 range is actually free.

> That is with these modules loaded:
> # lsmod
> Module                  Size  Used by
> it87                   25884  0 
> i2c_sensor              3200  1 it87
> i2c_isa                 2432  0 
> i2c_dev                10240  0 
> i2c_nforce2             5760  0 
> i2c_core               19736  5 it87,i2c_sensor,i2c_isa,i2c_dev,i2c_nforce2

So the it87 driver should have requested the range, but for some reason
did not.

> From what I can see, nothing else is using the chip. I might be wrong
> in my interpretations though.

No, you are correct.

Ah, maybe I get it. Can you please provide the output of:
isadump -f 0x290 16

We had reports that the latest revisions of the IT8712F do not pass
some legacy test:
http://bugzilla.kernel.org/show_bug.cgi?idC35
http://archives.andrew.net.au/lm-sensors/msg29962.html

Maybe that's your case. If it is, know that a fix has already been
applied to the driver:
http://archives.andrew.net.au/lm-sensors/msg29992.html

But it'll take some time to reach Linus' tree, of course. It's already
in -mm though.

-- 
Jean Delvare
