From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: [OOPS] w83781d during rmmod (2.5.69-bk17)
Message-Id: <20030524183748.GA3097@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>

This applies to all kernel versions since w83781d was brought in from 
the lm_sensors project.

The subclients of w83781d are never registered with i2c_attach_client().
But, w83781d_detach_client() tries to i2c_detach_client() them anyway.
This was harmless, until i2c-core was "listified"... because the old
array method silently ignored the attempt to detach a non-existent client.

The latest lm_sensors CVS of w83781d has the necessary i2c_attach_client()
calls - not sure why they were removed during conversion to 2.5.x.  Do we
intend to attach these subclients or not?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
