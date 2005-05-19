From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-i810.c
Message-Id: <20030718170851.62c95c70.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0307181618400.1795-200000@conradin.ath.cx>
In-Reply-To: <Pine.LNX.4.21.0307181618400.1795-200000@conradin.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The drivers for the I2C and DCC Busses don't work (at least on my
> Computer).
>
> With ver 2.7.0 nothing worked and no devices were detected by
> i2cdetect. But i2c-algo-bit's bit_test succeded.

How can you say it succeeded if you were not able to load any bus
driver?

> With ver 2.8.0 my Chrontel TV encoder was detected, but
> communication did not work and i2c-algo-bit's bit_test failed.
> (SDA stuck high). The driver got the first ACK (after sending the
> DAB), but never got the second one after sending the RAB.
> 
> Using the attached patch everything works.

Could you tell us how you did come to the values you are using? We can't
apply a patch unless we fully understand what it does. The set family is
the same in 2.7.0 and 2.8.0. Only the get family was changed. Please
take a look at the attached patch and tell us if reverting this part is
enough to get the driver to work again for you.

Also, could you tell us which chip driver is used for your tv encoder?
And is your monitor DDC capable or not?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
--- i2c-i810.c	24 Nov 2002 05:45:28 -0000	1.10
+++ i2c-i810.c	3 Jul 2003 01:30:13 -0000	1.17
@@ -140,22 +109,26 @@
 	readlong(I810_GPIOB);	/* flush posted write */
 }
 
-/* The GPIO pins are open drain, so the pins always remain outputs.
+/* The GPIO pins are open drain, so the pins could always remain outputs.
+   However, some chip versions don't latch the inputs unless they
+   are set as inputs.
    We rely on the i2c-algo-bit routines to set the pins high before
    reading the input from other chips. Following guidance in the 815
    prog. ref. guide, we do a "dummy write" of 0 to the register before
    reading which forces the input value to be latched. We presume this
-   applies to the 810 as well. This is necessary to get
+   applies to the 810 as well; shouldn't hurt anyway. This is necessary to get
    i2c_algo_bit bit_test=1 to pass. */
 
 static int bit_i810i2c_getscl(void *data)
 {
+	outlong(SCL_DIR_MASK, I810_GPIOB);
 	outlong(0, I810_GPIOB);
 	return (0 != (readlong(I810_GPIOB) & SCL_VAL_IN));
 }
 
 static int bit_i810i2c_getsda(void *data)
 {
+	outlong(SDA_DIR_MASK, I810_GPIOB);
 	outlong(0, I810_GPIOB);
 	return (0 != (readlong(I810_GPIOB) & SDA_VAL_IN));
 }
@@ -176,12 +149,14 @@
 
 static int bit_i810ddc_getscl(void *data)
 {
+	outlong(SCL_DIR_MASK, I810_GPIOA);
 	outlong(0, I810_GPIOA);
 	return (0 != (readlong(I810_GPIOA) & SCL_VAL_IN));
 }
 
 static int bit_i810ddc_getsda(void *data)
 {
+	outlong(SDA_DIR_MASK, I810_GPIOA);
 	outlong(0, I810_GPIOA);
 	return (0 != (readlong(I810_GPIOA) & SDA_VAL_IN));
 }
