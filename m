From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 23 Dec 2005 03:11:39 +0000
Subject: [lm-sensors] [PATCH]  rework w83792d  to use sensor-attr arrays
Message-Id: <43AB6AEB.6030504@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Yuan, everyone,

attached patch reworks w83792d  to use sensor-attr arrays.
this results in ~ 13K  shrink in object code.

I dont have one of these chips, so this is compile-tested only,
 but Winbond does ;-) and they're evidently supporting the driver (yay),
so Im hopeful that they will try this, and clean up the mistakes Ive 
inevitably made.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

