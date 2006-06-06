From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 06 Jun 2006 16:58:46 +0000
Subject: [lm-sensors] [PATCH] I2C: i2c_bit_add_bus should initialize SDA and
Message-Id: <m34pyyz0e1.fsf@defiant.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi,

Another thing: I noticed the i2c_bit_add_bus doesn't set SDA and SCL
lines to a known levels. If the hw driver set them to 1 all is fine
and the first START condition is detected correctly. But if they're
set differently (for example, if both are zero), the START will not
work.

I'm not sure if the following patch isn't an overkill, though, and
if the lack of initialization is a real problem which shows in
practice and not only on my analyzer.

In case you think it's needed:

This patch makes i2c_bit_add_bus() initialize SDA and SCL lines
as required by subsequent START condition.

Signed-off-by: Krzysztof Halasa <khc at pm.waw.pl>

--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -544,6 +544,13 @@ int i2c_bit_add_bus(struct i2c_adapter *
 	adap->timeout = 100;	/* default values, should	*/
 	adap->retries = 3;	/* be replaced by defines	*/
 
+	setsda(bit_adap, 0);	/* may mean START if SCL = 1 */
+	udelay(bit_adap->udelay);
+	setscl(bit_adap, 1);	/* may clock a zero bit in */
+	udelay(bit_adap->udelay);
+	setsda(bit_adap, 1);	/* STOP */
+	udelay(bit_adap->udelay);
+
 	i2c_add_adapter(adap);
 	return 0;
 }

