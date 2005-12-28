From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 28 Dec 2005 21:43:23 +0000
Subject: [lm-sensors] hwmon-sensor-attr-array-2.patch
Message-Id: <43B306FB.9040301@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Hans,

This patch refactors SENSOR_DEVICE_ATTR_2 macro, following pattern set by
SENSOR_ATTR.  First it creates a new macro SENSOR_ATTR_2() which expands 
to an initialization expression, then it uses that in SENSOR_DEVICE_ATTR_2, 
which declares and initializes a struct sensor_device_attribute_2.


This version differs from that in Hans' abituguru driver,
in that it preserves the argument order used in the original 
SENSOR_DEVICE_ATTR_2 macro, Hans' version invites confusion by
transposing _nr and _index between 2 closely related macros.

Happily though, Hans coded with __SENSOR_DEVICE_ATTR2,
so his driver could coexist with the macro defined here,
and he could switch at his discretion.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-sensor-attr-array-2.patch
Type: text/x-patch
Size: 969 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051228/ba4081e3/hwmon-sensor-attr-array-2.bin
