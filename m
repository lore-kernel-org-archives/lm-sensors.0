From: Christian Hohnstaedt <chohnstaedt@innominate.com>
Date: Tue, 24 Jul 2007 09:35:37 +0000
Subject: [lm-sensors] =?iso-8859-1?q?=5BPATCH=5D_lm75=2Ec_write_values_bel?=
Message-Id: <20070724093537.GA18984@tweety>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

writing values < 0=B0C to TLow and THigh of the LM75 is not=20
supported by the driver, since it strtoul()s instead
of strtol()ing.

Trivial fix attached.


Christian Hohnstaedt

--=20
Christian Hohnstaedt
Software Engineer

Innominate Security Technologies AG  /protecting industrial networks/
tel: +49.30.6392-3285 fax: +49.30.6392-3307
Albert-Einstein-Strasse 14, D-12489 Berlin, Germany
http://www.innominate.com

Register Court: AG Charlottenburg, HR B 81603
Management Board: Joachim Fietz, Dirk Seewald
Chairman of the Supervisory Board: Edward M. Stadum

--gBBFr7Ir9EOA20Yy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="lm75.diff"

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index a40166f..4fa3220 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -95,7 +95,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm75_data *data = i2c_get_clientdata(client);
 	int nr = attr->index;
-	unsigned long temp = simple_strtoul(buf, NULL, 10);
+	int temp = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp[nr] = LM75_TEMP_TO_REG(temp);

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--gBBFr7Ir9EOA20Yy--
