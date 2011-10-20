From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 20 Oct 2011 09:33:02 +0000
Subject: [lm-sensors] [PATCH 1/6] IIO: core: add datasheet_name to chan_spec
Message-Id: <1319103187-27791-2-git-send-email-jic23@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1319103187-27791-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319103187-27791-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com, zdevai@gmail.com, linux@arm.linux.org.uk, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, gregkh@suse.de, lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, khali@linux-fr.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com, Jonathan Cameron <jic23@cam.ac.uk>

This allows for matching against the name given
on a datasheet, however silly/inconsistent it might
be.

Useful for in kernel interfaces.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 include/linux/iio/iio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 8066c8a..beedc5c 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -128,6 +128,7 @@ struct iio_chan_spec {
 	} scan_type;
 	long                    info_mask;
 	char			*extend_name;
+	const char		*datasheet_name;
 	unsigned		processed_val:1;
 	unsigned		modified:1;
 	unsigned		indexed:1;
-- 
1.7.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
