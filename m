From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 11 Sep 2005 06:06:27 +0000
Subject: [lm-sensors] libsensors / libsysfs patches for review
Message-Id: <20050911040600.GB3629@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone:

As I mentioned on IRC, I have some libsensors patches ready for review here
(as a quilt series):

http://members.dca.net/mhoffman/sensors/patches/lm_sensors2/20050910/

The fifth patch is slightly edited since I first posted them, and the sixth
patch is now ready also.  I tested them against each of the following kernels:
2.4.31 (/proc), 2.6.13-rc6 (old sysfs), and 2.6.13-rc6-mm2 (sysfs/hwmon).

Known caveats: 

1) To build libsensors on a box w/ Linux 2.4.x kernel, you still need to have
built and installed libsysfs first.  That's awkward for sure, but it's only
temporary.  The long-term plan is for lib/sysfs.c to be optional.  Likely
I'll add more automagic to the makefile.

2) I haven't prepared a documentation patch yet.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

