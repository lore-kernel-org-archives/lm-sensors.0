From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 07 Nov 2011 15:44:38 +0000
Subject: [lm-sensors] [PATCH 2/5] IIO:ADC:max1363 add datasheet_name entries.
Message-Id: <1320680681-5635-3-git-send-email-jic23@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320680681-5635-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1320680681-5635-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: guenter.roeck@ericsson.com, khali@linux-fr.org, dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org, lars@metafoo.de, maxime.ripard@free-electrons.com, lm-sensors@lm-sensors.org, thomas.petazzoni@free-electrons.com, zdevai@gmail.com, Jonathan Cameron <jic23@cam.ac.uk>

From: Jonathan Cameron <jic23@cam.ac.uk>

Kind of obvious for this device but useful
for testing purposes.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/iio/adc/max1363_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/iio/adc/max1363_core.c b/drivers/iio/adc/max1363_core.c
index f21ec63..603969b 100644
--- a/drivers/iio/adc/max1363_core.c
+++ b/drivers/iio/adc/max1363_core.c
@@ -252,6 +252,7 @@ static const enum max1363_modes max1363_mode_list[] = {
 		.channel = num,						\
 		.address = addr,					\
 		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
+		.datasheet_name = "AIN"#num				\
 	}								\
 
 /* bipolar channel */
@@ -264,6 +265,7 @@ static const enum max1363_modes max1363_mode_list[] = {
 		.channel2 = num2,					\
 		.address = addr,					\
 		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
+		.datasheet_name = "AIN"#num"-AIN"#num2			\
 	}
 
 
-- 
1.7.7.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
