From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 07 Nov 2011 15:44:37 +0000
Subject: [lm-sensors] [PATCH 1/5] IIO: core: add datasheet_name to chan_spec
Message-Id: <1320680681-5635-2-git-send-email-jic23@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320680681-5635-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1320680681-5635-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: guenter.roeck@ericsson.com, khali@linux-fr.org, dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org, lars@metafoo.de, maxime.ripard@free-electrons.com, lm-sensors@lm-sensors.org, thomas.petazzoni@free-electrons.com, zdevai@gmail.com, Jonathan Cameron <jic23@cam.ac.uk>

From: Jonathan Cameron <jic23@cam.ac.uk>

This allows for matching against the name given
on a datasheet, however silly/inconsistent it might
be.

Useful for in kernel interfaces.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 include/linux/iio/iio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 4367d82..36a50b2 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -122,6 +122,7 @@ struct iio_chan_spec {
 	} scan_type;
 	long                    info_mask;
 	char			*extend_name;
+	const char		*datasheet_name;
 	unsigned		processed_val:1;
 	unsigned		modified:1;
 	unsigned		indexed:1;
-- 
1.7.7.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
