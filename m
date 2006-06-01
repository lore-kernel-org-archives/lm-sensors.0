From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 01 Jun 2006 01:44:38 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hopefully this is it!
- Shortened the code fences
- Changed the default clause in the combined callbacks to call out an error
- Changed the nr sensor-attr-2 field to a more meaningful name
- Used static lookup tables where appropriate
- Fixed a bug in the register mapping of the auto_point registers
- Used ARRAY_SIZE macro instead of hardcoded values


This is a new driver for the VIA vt1211 Super-IO chip. It is a rewrite of the
existing vt1211 driver (by Mark D. Studebaker and Lars Ekman) that has been
around for a while but never made it into the main kernel tree.

It is implemented as a platform driver and therefore requires the
latest CVS version
of lm_sensors to function properly.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-vt1211-new-driver.patch
Type: application/octet-stream
Size: 36694 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/cd2fc75d/attachment-0001.obj 
