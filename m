From: laurent.riffard@free.fr (Laurent Riffard)
Date: Sat, 01 Oct 2005 23:07:18 +0000
Subject: [lm-sensors] Re: [PATCH 2.6-mm 5/5] i2c: make i2c-isa drivers
Message-Id: <433EFA3F.3070500@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <433D50FC.30907@free.fr>
In-Reply-To: <433D50FC.30907@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Le 01.10.2005 21:49, Jean Delvare a ?crit :
> Hi Laurent,
> 
>>In function i2c_isa_add_driver, copied driver should inherit the owner field
>>as well as the name field.
>>
>>
>>Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
>>---
>>
[snip]
> 
> This one doesn't apply, because of tabs/spaces conversions it seems.
> Please resend in a suitable form.
> 
> BTW, I appreciate diffstat output in the patch headers, it helps
> figuring out at a glance which files a patch affects and how.
> 
> Thanks,

Oops ! Sorry about that... here is an updated version:

---
In function i2c_isa_add_driver, copied driver should inherit the owner field
as well as the name field.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
---

 i2c-isa.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6-mm/drivers/i2c/busses/i2c-isa.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-isa.c	2005-09-09 23:39:50.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-isa.c	2005-09-10 10:55:14.425721250 +0200
@@ -92,6 +92,7 @@
 
 	/* Add the driver to the list of i2c drivers in the driver core */
 	driver->driver.name = driver->name;
+	driver->driver.owner = driver->owner;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_isa_device_probe;
 	driver->driver.remove = i2c_isa_device_remove;


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051001/55d9e139/signature.bin
