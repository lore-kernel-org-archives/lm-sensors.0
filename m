From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Mon, 26 Aug 2013 22:42:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: Change my email address.
Message-Id: <20130826224227.GB4781@blackbox.djwong.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've changed employers, so change the email addresses to match.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 drivers/hwmon/acpi_power_meter.c |    4 ++--
 drivers/hwmon/adt7462.c          |    4 ++--
 drivers/hwmon/adt7470.c          |    4 ++--
 drivers/hwmon/i5k_amb.c          |    4 ++--
 drivers/hwmon/ibmaem.c           |    4 ++--
 drivers/hwmon/ibmpex.c           |    4 ++--
 drivers/misc/ics932s401.c        |    4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 6351aba..a9e3d01 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -2,7 +2,7 @@
  * A hwmon driver for ACPI 4.0 power meters
  * Copyright (C) 2009 IBM
  *
- * Author: Darrick J. Wong <djwong@us.ibm.com>
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1001,7 +1001,7 @@ static void __exit acpi_power_meter_exit(void)
 	acpi_bus_unregister_driver(&acpi_power_meter_driver);
 }
 
-MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
+MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
 MODULE_DESCRIPTION("ACPI 4.0 power meter driver");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 69481d3..b96216c 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -2,7 +2,7 @@
  * A hwmon driver for the Analog Devices ADT7462
  * Copyright (C) 2008 IBM
  *
- * Author: Darrick J. Wong <djwong@us.ibm.com>
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1970,6 +1970,6 @@ static int adt7462_remove(struct i2c_client *client)
 
 module_i2c_driver(adt7462_driver);
 
-MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
+MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
 MODULE_DESCRIPTION("ADT7462 driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 6099f50..0f4dea5 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -2,7 +2,7 @@
  * A hwmon driver for the Analog Devices ADT7470
  * Copyright (C) 2007 IBM
  *
- * Author: Darrick J. Wong <djwong@us.ibm.com>
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1314,6 +1314,6 @@ static int adt7470_remove(struct i2c_client *client)
 
 module_i2c_driver(adt7470_driver);
 
-MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
+MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
 MODULE_DESCRIPTION("ADT7470 driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index de058c2..6c0080a 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -3,7 +3,7 @@
  * temperature sensors
  * Copyright (C) 2007 IBM
  *
- * Author: Darrick J. Wong <djwong@us.ibm.com>
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -609,7 +609,7 @@ static void __exit i5k_amb_exit(void)
 	platform_driver_unregister(&i5k_amb_driver);
 }
 
-MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
+MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
 MODULE_DESCRIPTION("Intel 5000 chipset FB-DIMM AMB temperature sensor");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 1429f6e..e2b56a2 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -3,7 +3,7 @@
  * temperature/power/energy sensors and capping functionality.
  * Copyright (C) 2008 IBM
  *
- * Author: Darrick J. Wong <djwong@us.ibm.com>
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1103,7 +1103,7 @@ static void __exit aem_exit(void)
 		aem_delete(p1);
 }
 
-MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
+MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
 MODULE_DESCRIPTION("IBM AEM power/temp/energy sensor driver");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 74b365e..20ab0fb 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -2,7 +2,7 @@
  * A hwmon driver for the IBM PowerExecutive temperature/power sensors
  * Copyright (C) 2007 IBM
  *
- * Author: Darrick J. Wong <djwong@us.ibm.com>
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -606,7 +606,7 @@ static void __exit ibmpex_exit(void)
 		ibmpex_bmc_delete(p);
 }
 
-MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
+MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
 MODULE_DESCRIPTION("IBM PowerExecutive power/temperature sensor driver");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/misc/ics932s401.c b/drivers/misc/ics932s401.c
index 0029536..28f51e0 100644
--- a/drivers/misc/ics932s401.c
+++ b/drivers/misc/ics932s401.c
@@ -2,7 +2,7 @@
  * A driver for the Integrated Circuits ICS932S401
  * Copyright (C) 2008 IBM
  *
- * Author: Darrick J. Wong <djwong@us.ibm.com>
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -482,7 +482,7 @@ static int ics932s401_remove(struct i2c_client *client)
 
 module_i2c_driver(ics932s401_driver);
 
-MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
+MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
 MODULE_DESCRIPTION("ICS932S401 driver");
 MODULE_LICENSE("GPL");
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
