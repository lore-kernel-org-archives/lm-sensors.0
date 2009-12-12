From: roger blofeld <blofeldus@yahoo.com>
Date: Sat, 12 Dec 2009 02:54:54 +0000
Subject: [lm-sensors] [PATCH] adt7462: Fix pin 28 monitoring
Message-Id: <994.13667.qm@web53501.mail.re2.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-27544763-1260586494=:13667"
List-Id: <lm-sensors.vger.kernel.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, lkml <linux-kernel@vger.kernel.org>

--0-27544763-1260586494=:13667
Content-Type: text/plain; charset=us-ascii

The ADT7462_PIN28_VOLT value is a 4-bit field, so the corresponding shift must be 4.

Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>
---
My mailer will whitespace damage the inline copy of the patch.
The attached version should be OK.

diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 1852f27..262c133 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -97,7 +97,7 @@ I2C_CLIENT_INSMOD_1(adt7462);
 #define        ADT7462_PIN24_SHIFT        6
 #define        ADT7462_PIN26_VOLT_INPUT    0x08
 #define        ADT7462_PIN25_VOLT_INPUT    0x20
-#define        ADT7462_PIN28_SHIFT        6    /* cfg3 */
+#define        ADT7462_PIN28_SHIFT        4    /* cfg3 */
 #define        ADT7462_PIN28_VOLT        0x5
 
 #define ADT7462_REG_ALARM1            0xB8


      
--0-27544763-1260586494=:13667
Content-Type: application/octet-stream; name="adt7462-p28-shift.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="adt7462-p28-shift.patch"

VGhlIEFEVDc0NjJfUElOMjhfVk9MVCB2YWx1ZSBpcyBhIDQtYml0IGZpZWxk
LCBzbyB0aGUgY29ycmVzcG9uZGluZyBzaGlmdCBtdXN0IGJlIDQuCgpTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBCbG9mZWxkIDxibG9mZWxkdXNAeWFob28uY29t
PgotLS0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vYWR0NzQ2Mi5jIGIv
ZHJpdmVycy9od21vbi9hZHQ3NDYyLmMKaW5kZXggMTg1MmYyNy4uMjYyYzEz
MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9od21vbi9hZHQ3NDYyLmMKKysrIGIv
ZHJpdmVycy9od21vbi9hZHQ3NDYyLmMKQEAgLTk3LDcgKzk3LDcgQEAgSTJD
X0NMSUVOVF9JTlNNT0RfMShhZHQ3NDYyKTsKICNkZWZpbmUJCUFEVDc0NjJf
UElOMjRfU0hJRlQJCTYKICNkZWZpbmUJCUFEVDc0NjJfUElOMjZfVk9MVF9J
TlBVVAkweDA4CiAjZGVmaW5lCQlBRFQ3NDYyX1BJTjI1X1ZPTFRfSU5QVVQJ
MHgyMAotI2RlZmluZQkJQURUNzQ2Ml9QSU4yOF9TSElGVAkJNgkvKiBjZmcz
ICovCisjZGVmaW5lCQlBRFQ3NDYyX1BJTjI4X1NISUZUCQk0CS8qIGNmZzMg
Ki8KICNkZWZpbmUJCUFEVDc0NjJfUElOMjhfVk9MVAkJMHg1CiAKICNkZWZp
bmUgQURUNzQ2Ml9SRUdfQUxBUk0xCQkJMHhCOAo=

--0-27544763-1260586494=:13667
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--0-27544763-1260586494=:13667--
