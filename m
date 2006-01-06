From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:38 +0000
Subject: [lm-sensors] [PATCH] i2c: i2c-ibm_iic add I2C_CLASS_HWMON
Message-Id: <11365852581182@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: i2c-ibm_iic add I2C_CLASS_HWMON

Add the ibm_iic driver to the HWMON class so it will scan the
bus for connected hardware monitor sensors.

Signed-off-by: Martin Hicks <mort at bork.org>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit a4787c0d232e16e727b37205dc647337b8974f35
tree 4e7ef0882d0916bb56410a23399e2f0baa794703
parent 3fb81a3df63e1900a7b3f496806a3f8d2b4295dd
author Martin Hicks <mort at bork.org> Sun, 18 Dec 2005 17:18:01 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:27 -0800

 drivers/i2c/busses/i2c-ibm_iic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 1a58725..87fae93 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -725,6 +725,7 @@ static int __devinit iic_probe(struct oc
 	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
 	adap->id = I2C_HW_OCP;
+	adap->class = I2C_CLASS_HWMON;
 	adap->algo = &iic_algo;
 	adap->client_register = NULL;
 	adap->client_unregister = NULL;


