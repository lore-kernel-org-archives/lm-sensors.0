From: Rodolfo Giometti <giometti@linux.it>
Date: Fri, 11 Sep 2009 15:07:04 +0000
Subject: [lm-sensors] hwmon & mfd: add mfd support to
Message-Id: <1252681625-385-1-git-send-email-giometti@linux.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-1-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-1-git-send-email-giometti@linux.it>
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
