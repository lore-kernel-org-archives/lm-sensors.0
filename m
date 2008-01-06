From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Jan 2008 09:48:59 +0000
Subject: [lm-sensors] Call for lm-sensors 3.1.0
Message-Id: <20080106104859.7ab4ffc0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I would like to release a new version out of the lm-sensors-3.0.0
branch soon. We have fixed a few annoying bugs since 3.0.0 (rrd support
in sensord, voltage value references in sensors.conf.eg), but more
importantly, I've made two major changes in libsensors. Firstly, it no
longer depends on libsysfs. Secondly, it supports hwmon attributes in
the hwmon class devices. I think that these changes are important
enough that the library minor version should be increased (i.e. we go
from libsensors.so.4.0.0 to libsensors.so.4.1.0). In particular I seem
to remember that the minor version should be increased when the
dependencies change, but I can't remember where I read this. If anyone
has a reference documenting good practice in this area, I'm interested.

As a consequence, we would number this release 3.1.0 rather than 3.0.1.
If you disagree, please let me know.

The release schedule could look like:
* January 20th: SVN freeze.
* January 21st to 27th: testing.
* January 28th: release.

If anyone has objections please speak up.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
