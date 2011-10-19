From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 19 Oct 2011 14:47:04 +0000
Subject: [lm-sensors] [PATCH 2/6] IIO:ADC:max1363 add datasheet_name entries.
Message-Id: <1319035628-32580-3-git-send-email-jic23@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1319035628-32580-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319035628-32580-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com, zdevai@gmail.com, linux@arm.linux.org.uk, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, gregkh@suse.de, lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, khali@linux-fr.org, Jonathan Cameron <jic23@cam.ac.uk>

Kind of obvious for this device but useful
for testing purposes.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/iio/adc/max1363_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/iio/adc/max1363_core.c b/drivers/iio/adc/max1363_core.c
index ee06d48..e035df9 100644
--- a/drivers/iio/adc/max1363_core.c
+++ b/drivers/iio/adc/max1363_core.c
@@ -251,7 +251,8 @@ static const enum max1363_modes max1363_mode_list[] = {
 		.indexed = 1,						\
 		.channel = num,						\
 		.address = addr,					\
-		.info_mask = MAX1363_INFO_MASK				\
+		.info_mask = MAX1363_INFO_MASK,				\
+		.datasheet_name = "AIN"#num				\
 	}								\
 
 /* bipolar channel */
@@ -264,6 +265,7 @@ static const enum max1363_modes max1363_mode_list[] = {
 		.channel2 = num2,					\
 		.address = addr,					\
 		.info_mask = MAX1363_INFO_MASK,				\
+		.datasheet_name = "AIN"#num"-AIN"#num2			\
 	}
 #define MAX1363_INFO_MASK (1 << IIO_CHAN_INFO_SCALE_SHARED)
 
-- 
1.7.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
