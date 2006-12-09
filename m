From: bob2@dsv.nl (Bob =?ISO-8859-1?Q?Schl=E4rmann?=)
Date: Sat, 09 Dec 2006 23:05:39 +0000
Subject: [lm-sensors] generic chip support for sensors
Message-Id: <20061210000539.1f2f2bbd@ws01.atreidis.nl.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

These patches add generic chip support to sensors. It also adds a
function to libsensors that returns the current feature type based on
its name.

Although we are not finished yet, it should work for most chips except
for alarms.

More info and a copy of the patches can be found at: 
http://www.atreidis.nl.eu.org/lm_sensors/

If the new output of sensors is not what it should be, please let us
know.

--
Bob Schl?rmann
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors_generic_chips.patch
Type: application/octet-stream
Size: 3741 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061210/20dda48a/attachment-0003.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors_generic_print.patch
Type: application/octet-stream
Size: 17104 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061210/20dda48a/attachment-0004.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: libsensors_get_type.patch
Type: application/octet-stream
Size: 3160 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061210/20dda48a/attachment-0005.obj 
