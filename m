From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: Adding S4882 support to the i2c-amd756 driver
Message-Id: <20041022034103.GF9774@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041017222721.1f12466d.khali@linux-fr.org>
In-Reply-To: <20041017222721.1f12466d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

(Replying to self)

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-10-21 23:21:17 -0400]:
> Yes, I'll want to tackle this in stages.  The sysfs fixups can come later.
> It brings up a point though: if the MUX client is registered "manually"
> as we're calling it, what do we do with the sysfs structure?  Maybe it 
> would be better for i2c_lock_adapter to do this:
> 
> 1) force all existing clients to detach
> 2) attach the caller client as normal
> 3) mark the bus as no-probe and allow no further client attachments

To be more clear, what I'm suggesting would be declared like this:

	int i2c_attach_client_exclusive(struct i2c_client *client);

The "unlock" part can be rolled into the normal i2c_detach_client routine.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
