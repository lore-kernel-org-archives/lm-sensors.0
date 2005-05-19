From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [Fwd: [PATCH] - i2c/i2c-dev.c::i2c_dev_init() cleanup.]
Message-Id: <40EC3194.2070302@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I don't think this ever made it to the list:

-------- Original Message --------
From: - Tue Jul  6 09:36:20 2004
Date: Mon, 5 Jul 2004 17:24:39 -0300
From: Luiz Fernando N. Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: greg@kroah.com
Cc: phil@netroedge.com, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] - i2c/i2c-dev.c::i2c_dev_init() cleanup.
Message-ID: <20040705202439.GA743@lorien.prodam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


  Hi !

  This patch does the fallowing cleanup for
drivers/i2c/i2c-dev.c::i2c_dev_init():

*) in a error condition, return the error code of register_chrdev()
insted of -EIO;
*) adds missing audit for class_register();
*) in a error condition, only prints "Driver Initialisation Failed",
insted printing the cause. (Note that the error will be printed by
the return of the error code, and the information about what function
caused the problem need to be done by a debug code).

  Only compiled, lack of hardware.

Signed-off-by: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>

diffstat:  drivers/i2c/i2c-dev.c |   33 +++++++++++++++++++++------------
  1 files changed, 21 insertions(+), 12 deletions(-)

diff -X dontdiff -Nparu a/drivers/i2c/i2c-dev.c a~/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	2004-06-30 16:34:44.000000000 -0300
+++ a~/drivers/i2c/i2c-dev.c	2004-06-30 17:01:05.000000000 -0300
@@ -518,20 +518,29 @@ static int __init i2c_dev_init(void)

  	printk(KERN_INFO "i2c /dev entries driver\n");

-	if (register_chrdev(I2C_MAJOR,"i2c",&i2cdev_fops)) {
-		printk(KERN_ERR "i2c-dev.o: unable to get major %d for i2c bus\n",
-		       I2C_MAJOR);
-		return -EIO;
-	}
+	res = register_chrdev(I2C_MAJOR, "i2c", &i2cdev_fops);
+	if (res)
+		goto out;
+
+	res = class_register(&i2c_dev_class);
+	if (res)
+		goto out_unreg_chrdev;
+
+	res = i2c_add_driver(&i2cdev_driver);
+	if (res)
+		goto out_unreg_class;
+
  	devfs_mk_dir("i2c");
-	class_register(&i2c_dev_class);
-	if ((res = i2c_add_driver(&i2cdev_driver))) {
-		printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not 
inserted.\n");
-		devfs_remove("i2c");
-		unregister_chrdev(I2C_MAJOR,"i2c");
-		return res;
-	}
+
  	return 0;
+
+out_unreg_class:
+	class_unregister(&i2c_dev_class);
+out_unreg_chrdev:
+	unregister_chrdev(I2C_MAJOR,"i2c");
+out:
+	printk(KERN_ERR "%s: Driver Initialisation failed", __FILE__);
+	return res;
  }

  static void __exit i2c_dev_exit(void)

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
