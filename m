From: mark@solarsys.private (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Oops: i2c-proc.c
Message-Id: <20030324012157.GC13727@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030130235623.A4057@earth.solarsys.net>
In-Reply-To: <20030130235623.A4057@earth.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark D. Studebaker <mds@paradyne.com> [2003-03-23 19:26:19 -0500]:

> thanks.
> how does this compare to the much more elaborate fix in 2.5.64?
> 
> http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/i2c/i2c-proc.c@1.17?nav=index.html|src/.|src/drivers|src/drivers/i2c|hist/drivers/i2c/i2c-proc.c
> 
> Is your change below sufficient?
> 

Good timing, heh.  As your message was coming in, I just finished trying Christoph's
patch backported to CVS (with lk2-4 tag).  It behaves the same as my patch: eeprom
inserts and works but w83781d hangs during insertion.  Likely w83781d has problems
of its own.

I'll apply CHC's patch to CVS/lk2-4 if you want.  But, I'm wondering if I should
continue to look at it... is that branch just going to die anyway?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
