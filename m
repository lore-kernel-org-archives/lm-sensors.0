From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:31:56 +0000
Subject: [lm-sensors] [PATCH] i2c: Static function fixes, 1 of 4
Message-Id: <11305336633426@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Static function fixes, 1 of 4

eeprom_detect is first declared static and then when
the function is actually implemented, there is no static.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6536c49a1ee2bd85eee0e7fa41e67c5743f2f93e
tree 6286f837ae9b7109aae92658f2b676e0151c2766
parent 2445eb62e98250f1ec8cbc8cf7c4be9cfafe88e5
author Ben Dooks <ben-linux@fluff.org> Wed, 26 Oct 2005 21:04:12 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:12 -0700

 drivers/i2c/chips/eeprom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
index ee7cbc8..4baf573 100644
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -155,7 +155,7 @@ static int eeprom_attach_adapter(struct 
 }
 
 /* This function is called by i2c_probe */
-int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
+static int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct eeprom_data *data;

