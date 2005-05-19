From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: [PATCH] More i2c driver changes 2.6.0-test2
Message-Id: <10603869391598@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <106038693850@kroah.com>
References: <10603869373490@kroah.com>
In-Reply-To: <10603869373490@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1126, 2003/08/08 16:33:00-07:00, wodecki@gmx.de

[PATCH] I2C: i2c sysfs rant

On Wed, Aug 06, 2003 at 04:22:44PM -0700, Greg KH wrote:
> On Wed, Aug 06, 2003 at 09:11:45PM +0200, Wiktor Wodecki wrote:
> > Hello folks,
> >
> > I just saw that I2C provides "/sys/bus/i2c/drivers/dev\ driver" in
> > 2.6.0-test2. It would be nice if you'd consider renaming this to
> > dev_driver, to avoid un-neccessary quoting in scripts.
> >
> > Thank You :-)
>
> Patches are always gladly accepted :)

here you go


 drivers/i2c/i2c-dev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Fri Aug  8 16:47:15 2003
+++ b/drivers/i2c/i2c-dev.c	Fri Aug  8 16:47:15 2003
@@ -474,7 +474,7 @@
 
 static struct i2c_driver i2cdev_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "dev driver",
+	.name		= "dev_driver",
 	.id		= I2C_DRIVERID_I2CDEV,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= i2cdev_attach_adapter,

