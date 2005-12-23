From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 23 Dec 2005 03:16:19 +0000
Subject: [lm-sensors] [PATCH] rework w83792d to use sensor-attr arrays
Message-Id: <43AB6C03.6040206@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:

> hi Yuan, everyone,
>
> attached patch reworks w83792d  to use sensor-attr arrays.
> this results in ~ 13K  shrink in object code.
>
> I dont have one of these chips, so this is compile-tested only,
> but Winbond does ;-) and they're evidently supporting the driver (yay),
> so Im hopeful that they will try this, and clean up the mistakes Ive 
> inevitably made.
>
> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
>
now attached.  That really was a mousing error.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensor-attr-array-w83792d.patch
Type: text/x-patch
Size: 75784 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051223/5d696f66/sensor-attr-array-w83792d-0001.bin
