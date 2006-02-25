From: juergh@gmail.com (Juerg Haefliger)
Date: Sat, 25 Feb 2006 21:24:43 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH 1/2] hwmon: new vt1211 driver

This is a new driver for the VIA vt1211 Super-IO chip. It is a rewrite of the
existing vt1211 driver (by Mark D. Studebaker and Lars Ekman) that has been
around for a while but never made it into the main kernel tree. It is
implemented as a platform driver and therefore requires the latest CVS version
of lm_sensors to function properly.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>

---
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-vt1211-new-driver.patch
Type: text/x-patch
Size: 40592 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060225/20104c1f/hwmon-vt1211-new-driver-0001.bin
