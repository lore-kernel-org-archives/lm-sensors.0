From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors/i2c 2.8.2
Message-Id: <20040104172246.43b0d548.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040104141910.64b647a2.khali@linux-fr.org>
In-Reply-To: <20040104141910.64b647a2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I tried to build kernels with i2c/lm_sensors 2.8.2 patched in, and I
> think I found a bug: The mkpatch generated patch requires lm75.h, but
> does not include it:
> 
> ../qlogicfas.c: In function `qlogicfas_detect':
> ../qlogicfas.c:650: warning: passing arg 1 of
> `scsi_unregister_Rsmp_1e4cecd6' from incompatible pointer type
> lm75.c:28:18: lm75.h: No such file or directory lm75.c: In function
> `lm75_temp': lm75.c:286: warning: implicit declaration of function
> `LM75_TEMP_FROM_REG' lm75.c:292: warning: implicit declaration of
> function `LM75_TEMP_TO_REG' make[2]: *** [lm75.o] Error 1
> make[1]: *** [_modsubdir_sensors] Error 2
> 
> I will add include/linux/lm75.h as an extra patch to the kernel I am
> preparing.

Thanks for reporting. This was already fixed in CVS on December 18,
2003. All you have to do is add the relevant line in mkpatch/FILES.
Patch follows:

Index: FILES
=================================RCS file: /home/cvs/lm_sensors2/mkpatch/FILES,v
retrieving revision 1.22
retrieving revision 1.23
diff -u -r1.22 -r1.23
--- FILES	22 Jun 2003 16:28:45 -0000	1.22
+++ FILES	18 Dec 2003 05:24:55 -0000	1.23
@@ -31,6 +31,7 @@
 kernel/chips/gl518sm.c		drivers/sensors/gl518sm.c
 kernel/chips/gl520sm.c		drivers/sensors/gl520sm.c
 kernel/chips/it87.c		drivers/sensors/it87.c
+kernel/chips/lm75.h		drivers/sensors/lm75.h
 kernel/chips/lm75.c		drivers/sensors/lm75.c
 kernel/chips/lm78.c		drivers/sensors/lm78.c
 kernel/chips/lm80.c		drivers/sensors/lm80.c


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
