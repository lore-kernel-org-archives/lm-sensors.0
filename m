From: Rodolfo Giometti <giometti@linux.it>
Date: Thu, 10 Sep 2009 12:30:09 +0000
Subject: [lm-sensors] hwmon & mfd: add mfd support to
Message-Id: <1252585810-5336-1-git-send-email-giometti@linux.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds mfd support to drivers/hwmon/w83627hf.c driver in
order to easily add other sub-devices drivers. In fact in the near
future I'm going to add GPIO support. :)

Please, let me know if I should change something before continuing.

Ciao,

Rodolfo



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
