From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:59 +0000
Subject: [lm-sensors] [PATCH 28/30] i2c: Constify i2c_algorithm declarations,
Message-Id: <11593190173151-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c: Constify i2c_algorithm declarations, part 1

Make struct i2c_algorithm declarations const in all i2c algorithm
drivers.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: David Brownell <david-b at pacbell.net>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/algos/i2c-algo-bit.c |    2 +-
 drivers/i2c/algos/i2c-algo-pca.c |    2 +-
 drivers/i2c/algos/i2c-algo-pcf.c |    2 +-
 drivers/i2c/algos/i2c-algo-sgi.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 48fe3a3..21c36bf 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -512,7 +512,7 @@ static u32 bit_func(struct i2c_adapter *
 
 /* -----exported algorithm data: -------------------------------------	*/
 
-static struct i2c_algorithm i2c_bit_algo = {
+static const struct i2c_algorithm i2c_bit_algo = {
 	.master_xfer	= bit_xfer,
 	.functionality	= bit_func,
 };
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index b88a6fc..9081c9f 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -355,7 +355,7 @@ static int pca_init(struct i2c_algo_pca_
 	return 0;
 }
 
-static struct i2c_algorithm pca_algo = {
+static const struct i2c_algorithm pca_algo = {
 	.master_xfer	= pca_xfer,
 	.functionality	= pca_func,
 };
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 5b24930..3b20033 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -458,7 +458,7 @@ static u32 pcf_func(struct i2c_adapter *
 
 /* -----exported algorithm data: -------------------------------------	*/
 
-static struct i2c_algorithm pcf_algo = {
+static const struct i2c_algorithm pcf_algo = {
 	.master_xfer	= pcf_xfer,
 	.functionality	= pcf_func,
 };
diff --git a/drivers/i2c/algos/i2c-algo-sgi.c b/drivers/i2c/algos/i2c-algo-sgi.c
index 932c4fa..490d999 100644
--- a/drivers/i2c/algos/i2c-algo-sgi.c
+++ b/drivers/i2c/algos/i2c-algo-sgi.c
@@ -157,7 +157,7 @@ static u32 sgi_func(struct i2c_adapter *
 	return I2C_FUNC_SMBUS_EMUL;
 }
 
-static struct i2c_algorithm sgi_algo = {
+static const struct i2c_algorithm sgi_algo = {
 	.master_xfer	= sgi_xfer,
 	.functionality	= sgi_func,
 };
-- 
1.4.2.1


