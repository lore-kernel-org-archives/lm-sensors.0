From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 07 Oct 2008 01:18:24 +0000
Subject: [lm-sensors] [PATCH 00/12] Various hwmon patches
Message-Id: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-scsi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi all,

Here are a myriad of hwmon patches that I've been working on for (roughly)
2.6.28.  Please have a look and let me know what you think.

- Further elaboration of the hwmon sysfs interface for power meters
- New drivers: adt7462 (v2) and ics932s401
- adt7462 v2: Fix some mislabelling problems and make it autoload via DMI
- DMI based autoloading of various hwmon drivers for various IBM systems
- Automatic loading for i5k-amb driver
- Fix adt7470 mislabelling problems 
- Update adt7473 documentation
- adt7470/adt7473: Check input values from sysfs

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
