From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3-mm2 0/2] i2c: new sysfs class "hwmon"
Message-Id: <20050503034714.GB4977@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone:

Here's another attempt.  It's pretty trivial given Greg's suggestions.

There is still the question of what to use for class device ID string.
We could resurrect each chip's ID number (that was incremented but never
used) to make names like lm78-0, lm78-1, etc.  But, the uniqueness
requirement isn't completely guaranteed that way.  E.g. two different
modules might name a class device w83627hf-0.  Suggestions?

(The patch still uses the guaranteed unique bus ID for now.)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
