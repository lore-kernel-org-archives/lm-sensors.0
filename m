From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 31 Aug 2006 23:44:00 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 4] hwmon: new vt1211 driver
Message-Id: <191fb4ca0608311644t25d61cc1ne31d5e19b0568b98@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a new driver for the VIA vt1211 Super-IO chip. It is a rewrite
of the existing vt1211 driver (by Mark D. Studebaker and Lars Ekman)
which has been around for a while but never made it into the main
kernel tree.

It is implemented as a platform driver and therefore requires the
latest CVS version of lm_sensors to function properly.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-vt1211-new-driver.patch
Type: application/octet-stream
Size: 43054 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060831/9acf8842/attachment-0001.obj 
