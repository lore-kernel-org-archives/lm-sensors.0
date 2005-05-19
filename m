From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <2538186705050901066def6d69@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Two patches for comment, first defining a set of macros as I
previously described would be useful, and second an initial patch to
adapt net/core/net-sysfs.c to take advantage of dynamic callbacks
(although this needs testing) using said macros.

Before: 15K linux-2.6.12-rc4/usr/src/linux/net/core/net-sysfs.o
After: 12K  linux-2.6.12-rc4-sysfsdyncallback-net-sysfs/net/core/net-sysfs.o

Obviously not as big a difference as with adm1026, but that's to be
expected, it doesn't define near as many attributes. I think the patch
cleans up the code aesthetically quite a bit too. If someone could
work out how to get rid of the macros for sprintfs (FIELD_FORMAT, etc)
that would be even better.

Night...errr morning :-),
Yani
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-datamacros.diff
Type: text/x-patch
Size: 3218 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050509/d3771d4c/patch-linux-2.6.12-rc4-sysfsdyncallback-datamacros.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-net-sysfs.diff
Type: text/x-patch
Size: 7291 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050509/d3771d4c/patch-linux-2.6.12-rc4-sysfsdyncallback-net-sysfs.bin
