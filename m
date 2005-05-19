From: delvare@serianet.com (Jean Delvare)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: patches to i2c/lm_sensors 2.6.2 for later 2.2.x kernels
Message-Id: <Pine.LNX.4.33.0111232001350.8251-300000@jddev.intranet.serianet.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

Here are two patches, for i2c-2.6.2 and lm_sensors-2.6.2 respectively,
that remove warnings seen with latest 2.2.x kernels (2.2.19 and later for
i2c, 2.2.18 and later for lm_sensors). I tested them on my own 2.2.20
system, they work ok. The changes are not very important, they it should
be safe using them.

By the way, I invite you to have a look at i2c-2.6.2/kernel/i2c-proc.h. It
seems that this file was historically called sensors.h, and the
description line hasn't been updated. Also, this header "identifies"
itself as SENSORS_SENSORS_H. Shouldn't this be changed to I2C_PROC_H ?


-- 
Jean "Khali" Delvare
mail: delvare@serianet.com
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
diff -ruN i2c-2.6.2/kernel/i2c-proc.c i2c-2.6.2-khali/kernel/i2c-proc.c
--- i2c-2.6.2/kernel/i2c-proc.c	Sun Oct 14 17:04:46 2001
+++ i2c-2.6.2-khali/kernel/i2c-proc.c	Fri Nov 23 18:54:29 2001
@@ -49,10 +49,18 @@
 static int i2c_proc_chips(ctl_table * ctl, int write,
 			      struct file *filp, void *buffer,
 			      size_t * lenp);
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,19)) && \
+    (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
+static int i2c_sysctl_chips(ctl_table * table, int *name, unsigned nlen,
+				void *oldval, size_t * oldlenp,
+				void *newval, size_t newlen,
+				void **context);
+#else
 static int i2c_sysctl_chips(ctl_table * table, int *name, int nlen,
 				void *oldval, size_t * oldlenp,
 				void *newval, size_t newlen,
 				void **context);
+#endif /* 2.2.19+ */
 
 int __init sensors_init(void);
 
@@ -298,9 +306,16 @@
 	return 0;
 }
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,19)) && \
+    (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
+int i2c_sysctl_chips(ctl_table * table, int *name, unsigned nlen,
+			 void *oldval, size_t * oldlenp, void *newval,
+			 size_t newlen, void **context)
+#else
 int i2c_sysctl_chips(ctl_table * table, int *name, int nlen,
 			 void *oldval, size_t * oldlenp, void *newval,
 			 size_t newlen, void **context)
+#endif /* 2.2.19+ */
 {
 	struct i2c_chips_data data;
 	int i, oldlen, nrels, maxels,ret=0;
@@ -405,9 +420,16 @@
 
 /* This function is equivalent to i2c_proc_real, only it interacts with
    the sysctl(2) syscall, and returns no reals, but integers */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,19)) && \
+    (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
+int i2c_sysctl_real(ctl_table * table, int *name, unsigned nlen,
+			void *oldval, size_t * oldlenp, void *newval,
+			size_t newlen, void **context)
+#else
 int i2c_sysctl_real(ctl_table * table, int *name, int nlen,
 			void *oldval, size_t * oldlenp, void *newval,
 			size_t newlen, void **context)
+#endif /* 2.2.19+ */
 {
 	long results[MAX_RESULTS];
 	int oldlen, nrels = MAX_RESULTS,ret=0;
diff -ruN i2c-2.6.2/kernel/i2c-proc.h i2c-2.6.2-khali/kernel/i2c-proc.h
--- i2c-2.6.2/kernel/i2c-proc.h	Mon May 28 00:40:53 2001
+++ i2c-2.6.2-khali/kernel/i2c-proc.h	Fri Nov 23 18:51:39 2001
@@ -55,10 +55,18 @@
    found.
    In all cases, client points to the client we wish to interact with,
    and ctl_name is the SYSCTL id of the file we are accessing. */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,19)) && \
+    (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
+extern int i2c_sysctl_real(ctl_table * table, int *name, unsigned nlen,
+			       void *oldval, size_t * oldlenp,
+			       void *newval, size_t newlen,
+			       void **context);
+#else
 extern int i2c_sysctl_real(ctl_table * table, int *name, int nlen,
 			       void *oldval, size_t * oldlenp,
 			       void *newval, size_t newlen,
 			       void **context);
+#endif /* 2.2.19+ */
 extern int i2c_proc_real(ctl_table * ctl, int write, struct file *filp,
 			     void *buffer, size_t * lenp);
 
-------------- next part --------------
diff -ruN lm_sensors-2.6.2/kernel/chips/adm1025.c lm_sensors-2.6.2-khali/kernel/chips/adm1025.c
--- lm_sensors-2.6.2/kernel/chips/adm1025.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/adm1025.c	Fri Nov 23 19:41:35 2001
@@ -45,7 +45,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/bt869.c lm_sensors-2.6.2-khali/kernel/chips/bt869.c
--- lm_sensors-2.6.2/kernel/chips/bt869.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/bt869.c	Fri Nov 23 19:42:12 2001
@@ -38,7 +38,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/ddcmon.c lm_sensors-2.6.2-khali/kernel/chips/ddcmon.c
--- lm_sensors-2.6.2/kernel/chips/ddcmon.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/ddcmon.c	Fri Nov 23 19:49:19 2001
@@ -37,7 +37,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/gl520sm.c lm_sensors-2.6.2-khali/kernel/chips/gl520sm.c
--- lm_sensors-2.6.2/kernel/chips/gl520sm.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/gl520sm.c	Fri Nov 23 19:42:34 2001
@@ -37,7 +37,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/icspll.c lm_sensors-2.6.2-khali/kernel/chips/icspll.c
--- lm_sensors-2.6.2/kernel/chips/icspll.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/icspll.c	Fri Nov 23 19:42:52 2001
@@ -46,7 +46,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/lm87.c lm_sensors-2.6.2-khali/kernel/chips/lm87.c
--- lm_sensors-2.6.2/kernel/chips/lm87.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/lm87.c	Fri Nov 23 19:43:16 2001
@@ -79,7 +79,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/matorb.c lm_sensors-2.6.2-khali/kernel/chips/matorb.c
--- lm_sensors-2.6.2/kernel/chips/matorb.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/matorb.c	Fri Nov 23 19:43:35 2001
@@ -40,7 +40,7 @@
 #endif
 
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/maxilife.c lm_sensors-2.6.2-khali/kernel/chips/maxilife.c
--- lm_sensors-2.6.2/kernel/chips/maxilife.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/maxilife.c	Fri Nov 23 19:43:59 2001
@@ -74,7 +74,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/mtp008.c lm_sensors-2.6.2-khali/kernel/chips/mtp008.c
--- lm_sensors-2.6.2/kernel/chips/mtp008.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/mtp008.c	Fri Nov 23 19:44:18 2001
@@ -41,7 +41,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/pcf8574.c lm_sensors-2.6.2-khali/kernel/chips/pcf8574.c
--- lm_sensors-2.6.2/kernel/chips/pcf8574.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/pcf8574.c	Fri Nov 23 19:48:26 2001
@@ -55,7 +55,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/thmc50.c lm_sensors-2.6.2-khali/kernel/chips/thmc50.c
--- lm_sensors-2.6.2/kernel/chips/thmc50.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/thmc50.c	Fri Nov 23 19:44:53 2001
@@ -38,7 +38,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
diff -ruN lm_sensors-2.6.2/kernel/chips/via686a.c lm_sensors-2.6.2-khali/kernel/chips/via686a.c
--- lm_sensors-2.6.2/kernel/chips/via686a.c	Sat Oct 13 19:48:42 2001
+++ lm_sensors-2.6.2-khali/kernel/chips/via686a.c	Fri Nov 23 19:45:12 2001
@@ -59,7 +59,7 @@
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,13)
+#ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
 
