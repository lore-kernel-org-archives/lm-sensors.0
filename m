From: juergh@gmail.com (Juerg Haefliger)
Date: Fri, 07 Apr 2006 04:28:22 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new vt1211 driver
Message-Id: <191fb4ca0604062128m60ba1c53gbcab205aa6f40c0c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Incorporated suggestions made by Rudolf Marek.

This is a new driver for the VIA vt1211 Super-IO chip. It is a rewrite of the
existing vt1211 driver (by Mark D. Studebaker and Lars Ekman) that has been
around for a while but never made it into the main kernel tree. It is
implemented as a platform driver and therefore requires the latest CVS version
of lm_sensors to function properly.

Signed-off-by: Juerg Haefliger <juergh at gmail.com
<http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060407/8aeac2fa/attachment-0001.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-vt1211-new-driver.patch
Type: application/octet-stream
Size: 36195 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060407/8aeac2fa/hwmon-vt1211-new-driver-0001.obj
