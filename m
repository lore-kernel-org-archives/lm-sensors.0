From: kelledin@users.sourceforge.net (Kelledin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman on alpha
Message-Id: <200307240222.53468.kelledin@users.sourceforge.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c-velleman.c needs to pick up the HZ macro.  It does this fine 
on x86, but it needs a little extra help on alpha.  Patch 
attached; doesn't appear to break the x86 compile.

I don't actually have or use this device, so someone else will 
need to test this out...I just wanted i2c to compile.

Also, I'm seeing a lot of "cast from pointer to integer of 
different size" warnings compiling this same driver, mostly 
having to do with the CTRL macro.  This worries me, especially 
on 64-bit platforms.  Should I be worried in this case?

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-2.8.0-velleman.patch
Type: text/x-diff
Size: 382 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030724/3b861bf8/i2c-2.8.0-velleman.bin
