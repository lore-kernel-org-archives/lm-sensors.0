From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 07 Nov 2008 18:56:21 +0000
Subject: [lm-sensors] [PATCH 0/5] Various hwmon patches
Message-Id: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi all,

Here are a myriad of hwmon patches that I've been working on.  Please have a
look and let me know what you think.

- New driver: adt7462
- Automatic loading for i5k-amb driver
- adt7470/adt7473: Check input values from sysfs
- lm85: Add adt7468 support

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
