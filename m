From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 11 Feb 2010 16:25:01 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <20100211162501.GA16103@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Do not strip the CC!

On Thu, Feb 11, 2010 at 04:36:53PM +0100, frollic nilsson wrote:
> Well, I tried adding the #define DEBUG in the drivers/hwmon/asus_atk0110.c and
> recompiling, but there wasn't any more output in the dmesg/messages.
> They don't even say the driver gets loaded, but it's there if I list
> it using lsmod.

Ok, this means that ACPI core is not even calling the add method.
I guess that I can happen if _STA reports that the device is not functional.

Please apply this patch:

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 028284f..a9e07e4 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -1405,6 +1405,14 @@ static int atk_remove(struct acpi_device *device, int type)
 static int __init atk0110_init(void)
 {
 	int ret;
+	acpi_status status;
+	u64 val;
+
+	status = acpi_evaluate_integer(NULL, "\\AIDI", NULL, &val);
+	if (status != AE_OK)
+		printk("Failed to eval AIDI: %s\n", acpi_format_exception(status));
+	else
+		printk("AIDI = %llu\n", val);
 
 	ret = acpi_bus_register_driver(&atk_driver);
 	if (ret)

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
