From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: Patches for lm-sensors and I2C
Message-Id: <3D51F826.1451CAF0@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Aurelien,
Thank you very much for the corrections.
My brain led me to believe all the adapters were called
within the chips/sensors.c module.
I will add the patch for 2.4.18/19 and 2.5.30 on the 
web page.

I had to make small adjustments to get the desired results
from your patch.
+
+int __init i2c_mainboard_init_all(void)
+{
+#ifdef CONFIG_I2C_ALI1535
+       i2c_ali1535_init;
This should be i2c_ali1535_init(); otherwise it is a
invalid statement.
Thanks,
Albert
Aurelien Jarno wrote:
> 
> Hello
> 
> I have downloaded the patches for I2C and lm-sensors for kernel 2.4.18
> from your website. There is no problem to patch the kernel, but if the
> modules for mainboards are included directly into the kernel (not in
> modules), they aren't run on startup. Here is the patch to correct that.
> 
> Aurelien
> 
>   ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>                                    Name: 2.4.18-2.6.4-sensors-6-patch
>    2.4.18-2.6.4-sensors-6-patch    Type: text/x-diff
>                                Encoding: base64

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
