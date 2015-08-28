From: Christian Fetzer <fetzer.ch@gmail.com>
Date: Fri, 28 Aug 2015 08:31:22 +0000
Subject: [lm-sensors] [PATCH 1/4] i2c-piix4: Optionally release smba in piix4_adap_remove
Message-Id: <1440750685-19172-2-git-send-email-fetzer.ch@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is in preparation to support the multiplexed SMBus main controller
in the SB800 chipset where the controller address is shared among
the four multiplexed ports. As such the address region should be
only freed for the first multiplexed adapter to avoid double free
warnings.

Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 630bce6..97d2165 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -660,13 +660,14 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 }
 
-static void piix4_adap_remove(struct i2c_adapter *adap)
+static void piix4_adap_remove(struct i2c_adapter *adap, int free_smba)
 {
 	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
 
 	if (adapdata->smba) {
 		i2c_del_adapter(adap);
-		release_region(adapdata->smba, SMBIOSIZE);
+		if (free_smba)
+			release_region(adapdata->smba, SMBIOSIZE);
 		kfree(adapdata);
 		kfree(adap);
 	}
@@ -675,12 +676,12 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 static void piix4_remove(struct pci_dev *dev)
 {
 	if (piix4_main_adapter) {
-		piix4_adap_remove(piix4_main_adapter);
+		piix4_adap_remove(piix4_main_adapter, 1);
 		piix4_main_adapter = NULL;
 	}
 
 	if (piix4_aux_adapter) {
-		piix4_adap_remove(piix4_aux_adapter);
+		piix4_adap_remove(piix4_aux_adapter, 1);
 		piix4_aux_adapter = NULL;
 	}
 }
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
