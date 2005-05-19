From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [RFC PATCH 2.6.12-rc2-mm2 0/2] i2c: new sysfs class "hwmon"
Message-Id: <20050411044427.GA4963@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali, Greg, et. al:

After a brief chat w/ Khali last week (and some reading LDDv3) I did these
patches.  The result for me looks like this:

/sys/class/hwmon/1-0290/device/ -> /sys/devices/platform/i2c-1/1-0290

Notes/Questions:

1. I don't like "1-0290" for a class ID, but it was the easiest thing to
use at the time.  A better name might be w83627thf-0.

2. The kernel complains if I don't provide a class::release function, but
I can't really see a need for it in this case.  If I hold a file open through
the /sys/class/hwmon/X/device/Y link and then try to rmmod the driver, the 
rmmod will sleep until I close the file just as I expect.  Any hints here
Greg?

3. I added the struct class_device to struct i2c_client.  This makes it
slightly easier to modify the sensors drivers... but not all i2c_clients
will need it (bloat).  It could be added to each struct <driver>_data
(e.g. w83627hf_data) instead.

4. I didn't modify all the chips, just w83627hf.c and lm78.c as examples.
(IIRC Khali experiments a lot on lm78).

Comments?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
