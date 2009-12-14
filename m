From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Dec 2009 09:45:53 +0000
Subject: Re: [lm-sensors] w83627hf fails with ENODEV on 2.6.33
Message-Id: <20091214104553.3048fcda@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091211183452.GD5165@wrars-comp.wrarsdomain>
In-Reply-To: <20091211183452.GD5165@wrars-comp.wrarsdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrey,

On Fri, 11 Dec 2009 23:34:52 +0500, Andrey Rahmatullin wrote:
> I've built v2.6.32-5254-g3067e02 with old working config and w83627hf
> cannot be loaded now (modprobe shows No such device, dmes is empty).
> On older kernels it warned about the resource conflict with ACPI, but
> acpi_enforce_resources=lax is passed to the kernel, so the module worked.
> Now it doesn't show the warning and doesn't work.

Thanks for reporting. This was a bug in a patch of mine. Fix is below,
I'll push it to Linus within the next few days.

From: Christian Schulte <cs@schulte.it>
Subject: hwmon: (w83627hf) Fix for "No such device"

The commit b72656dbc491484765776a16eeb55ef2e90efea6 introduced
a bug leading to the w83627hf_find function no longer finding
any chips.

Signed-off-by: Christian Schulte <cs@schulte.it>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627hf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.33-rc0.orig/drivers/hwmon/w83627hf.c	2009-12-13 09:04:29.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83627hf.c	2009-12-13 15:59:36.000000000 +0100
@@ -1135,6 +1135,7 @@ static int __init w83627hf_find(int sioa
 		"W83687THF",
 	};
 
+	sio_data->sioaddr = sioaddr;
 	superio_enter(sio_data);
 	val = force_id ? force_id : superio_inb(sio_data, DEVID);
 	switch (val) {
@@ -1177,7 +1178,6 @@ static int __init w83627hf_find(int sioa
 	}
 
 	err = 0;
-	sio_data->sioaddr = sioaddr;
 	pr_info(DRVNAME ": Found %s chip at %#x\n",
 		names[sio_data->type], *addr);
 



-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
