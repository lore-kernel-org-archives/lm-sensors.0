From: juergh@gmail.com (Juerg Haefliger)
Date: Sat, 24 Mar 2007 04:47:31 +0000
Subject: [lm-sensors] [PATCH] lm-sensors: add dme1737 support
Message-Id: <191fb4ca0703232147q3a74701ci4bedf256201ee587@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fixes a bug in sensors-detect that prevents the SMSC
DME1737 from being discovered. It also adds full support for the chip
to libsensors and sensors.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm-sensors-add-dme1737-support.patch
Type: text/x-patch
Size: 15069 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070323/cb7010c7/attachment-0001.bin 
