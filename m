From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 29 Jul 2009 17:05:07 +0000
Subject: [lm-sensors] [PATCH 3/7] of: Remove "stm,m25p40" alias
Message-Id: <20090729170507.GC4803@oksana.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
In-Reply-To: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

The alias isn't needed any longer since the m25p80 driver converted
to the module device table matching.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/base.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 69f85c0..ddf224d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -447,7 +447,6 @@ struct of_modalias_table {
 static struct of_modalias_table of_modalias_table[] = {
 	{ "fsl,mcu-mpc8349emitx", "mcu-mpc8349emitx" },
 	{ "mmc-spi-slot", "mmc_spi" },
-	{ "stm,m25p40", "m25p80" },
 };
 
 /**
-- 
1.6.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
