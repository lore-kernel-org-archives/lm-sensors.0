From: juergh@gmail.com (Juerg Haefliger)
Date: Wed, 30 Aug 2006 05:35:37 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 3] hwmon: new vt1211 driver
Message-Id: <191fb4ca0608292235s3494ddecp2276c5d9841ac775@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

3rd try :-) Incorporated (hopefully) all changes requested by Jean Delvare.

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
Size: 45323 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060829/39a6cea0/attachment-0001.obj 
