From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 15 Jan 2013 06:53:08 +0000
Subject: [lm-sensors] [patch] hwmon/max6697: fix memset size in max6697_init_chip()
Message-Id: <20130115065308.GA899@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>

sizeof(p) was intended instead of sizeof(data).  data is a pointer and
p is a 7 character struct.  It probably doesn't make a difference most
of the time, but it could result in using uninitialized data.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index a1c8c0a..d229cc7 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -474,7 +474,7 @@ static int max6697_init_chip(struct i2c_client *client)
 		return 0;
 
 	if (!pdata || client->dev.of_node) {
-		memset(&p, 0, sizeof(data));
+		memset(&p, 0, sizeof(p));
 		max6697_get_config_of(client->dev.of_node, &p);
 		pdata = &p;
 	}

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
