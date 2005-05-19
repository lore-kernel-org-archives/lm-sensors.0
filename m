From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: w83781d hangs on i2c bus driver
Message-Id: <20030604030738.GA16916@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EDD5C50.5030504@paradyne.com>
In-Reply-To: <3EDD5C50.5030504@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark D. Studebaker <mds@paradyne.com> [2003-06-03 22:41:20 -0400]:
> Works fine on ISA.
> 
> If you modprobe an i2c bus driver after w83781d is modprobed, the bus 
> driver modprobe hangs,
> presumably while w83781d is scanning the bus.
> If you modprobe w83781d after an i2c bus driver is modprobed, the w83781d 
> modprobe hangs.
> 
> Any ideas let us know.

I assume you're talking about lk2-4, not the 2.5 stuff that recently
went to lkml.

I haven't ever been able to load lk2-4 w83781d.o.  The symptoms are
similar: it hangs as soon as I modprobe it (with I2C adapter).  I'll
try to debug that one so you can hack on the other chips I don't
have. :)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
