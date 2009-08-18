From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 18 Aug 2009 23:47:57 +0000
Subject: [lm-sensors] [PATCH 0/2] ACPI 4.0 power meter
Message-Id: <20090818234757.2004.88017.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Pavel Machek <pavel@ucw.cz>

Hi all,

This is a two-part patchset.  The first patch extends the hwmon sysfs interface
to include power capping features and extra data about the accuracy and
internal operation of the power meter.  The second patch implements a hwmon
driver for ACPI 4.0 compliant power meters that uses the expanded sysfs
interface.  I don't have an example DSDT from any actual piece of hardware, but
I can send some sample ASL code that I've been using to outfit kvm with a power
meter if anyone requests it.

This latest revision updates the driver itself to send sysfs poll notifications
upon receipt of ACPI events and updates the sysfs hwmon documentation to
reflect that.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
