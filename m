From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Message-Id: <2538186705051100583c6b1ffb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org
Cc: Justin Thiessen <jthiessen@penguincomputing.com>

Hi,

This patch presents as an example one possible way to use the dynamic
callbacks to clean up one of the i2c chip drivers, adm1026 (for more
information please see
http://archives.andrew.net.au/lm-sensors/msg31310.html).

The first patch defines a new macros like DEVICE_ATTR that also sets
the attribute private data (Greg whats your opinion on defining a
separate set of macros for this v.s. rolling it into one macro?).

The second patch changes adm1026 to pass the sensor index/number via
the private data pointer. I can't test this patch (so you won't want
to apply this) but I'm CCing it to the adm1026 maintainer.

The size difference:

-----------------2.6.11.7--------------------
Module                  Size  Used by
adm1026                44692  0
------2.6.12-rc4-sysdyncallback-----
Module                  Size  Used by
adm1026                32656  0

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani

---
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro.diff
Type: text/x-patch
Size: 1252 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050511/b643cab7/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: adm1026-sysdyncallback.diff
Type: text/x-patch
Size: 21594 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050511/b643cab7/adm1026-sysdyncallback.bin
