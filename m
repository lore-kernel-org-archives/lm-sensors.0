From: Dan Carpenter <error27@gmail.com>
Date: Wed, 03 Mar 2010 07:09:14 +0000
Subject: [lm-sensors] e5e9f44c causes buffer under-runs
Message-Id: <20100303070914.GE5086@bicker>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Smatch complains about:  e5e9f44c2 i2c: Drop I2C_CLIENT_INSMOD_2 to 8

The original define had an "any_chip", but this patch removed it.

-#define I2C_CLIENT_INSMOD_8(chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8) \
-enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,       \
-            chip7, chip8 }

This causes some buffer under runs.

drivers/hwmon/fschmd.c +1040 fschmd_detect(33) warn: array offset '(kind-1)' can be negative (-1)
drivers/hwmon/tmp401.c +527 tmp401_detect(37) warn: array offset '(kind-1)' can be negative (-1)
drivers/hwmon/tmp421.c +255 tmp421_detect(30) warn: array offset '(kind-1)' can be negative (-1)
drivers/hwmon/tmp421.c +256 tmp421_detect(31) warn: array offset '(kind-1)' can be negative (-1)

(From a test version of smatch).

regards,
dan carpenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
