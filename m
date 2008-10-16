From: eugene@abar.tigran-mets.am
Date: Thu, 16 Oct 2008 15:42:46 +0000
Subject: [lm-sensors] ipmisensors on 2.6.24.4
Message-Id: <Pine.LNX.4.64.0810161956320.6632@abar.tigran-mets.am>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have the following problems, trying to monitor my Broadcom CSB5 board:

sensors-detect shows that I need ipmisensors driver for my board. I 
patched kernel with stable drivers and got compile error (btw, patch 
failed and I applied it by hands.)

Then I freshed kernel source and applied last experimental driver:
ipmisensors-20070630-1330.diff

Result was the same - manual patch & compilation error:

   CC [M]  drivers/hwmon/ipmisensors.o
drivers/hwmon/ipmisensors.c: In function 'ipmisensors_register_bmc':
drivers/hwmon/ipmisensors.c:1326: warning: assignment from incompatible 
pointer type
drivers/hwmon/ipmisensors.c:1341: warning: passing argument 1 of 
'hwmon_device_unregister' from incompatible pointer type
drivers/hwmon/ipmisensors.c: In function 'ipmisensors_unregister_bmc':
drivers/hwmon/ipmisensors.c:1392: warning: passing argument 1 of 
'hwmon_device_unregister' from incompatible pointer type
drivers/hwmon/ipmisensors.c: In function 'ipmisensors_unregister_bmc_all':
drivers/hwmon/ipmisensors.c:1429: warning: passing argument 1 of 
'hwmon_device_unregister' from incompatible pointer type
drivers/hwmon/ipmisensors.c: In function 'ipmisensors_init':
drivers/hwmon/ipmisensors.c:1483: error: too many arguments to function 
'kmem_cache_create'
drivers/hwmon/ipmisensors.c:1487: error: too many arguments to function 
'kmem_cache_create'
make[2]: *** [drivers/hwmon/ipmisensors.o] Error 1
make[1]: *** [drivers/hwmon] Error 2
make[1]: *** Waiting for unfinished jobs....

So I need your advice how to monitor my sensors.

Best regards, Eugene.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
