From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 31 May 2008 06:25:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f71882fg) Delete needless
Message-Id: <4840EF70.1020803@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
 > These functions aren't used before being defined, so there's no point
 > in forward-declaring them.
 >
 > Signed-off-by: Jean Delvare <khali at linux-fr.org>
 > Cc: Hans de Goede <j.w.r.degoede at hhs.nl>
 >---
 >  drivers/hwmon/f71882fg.c |    6 ------
 >  1 file changed, 6 deletions(-)

Looks good to me:
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
