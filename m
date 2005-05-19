From: nroeder@inf.ed.ac.uk (Nils Roeder)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: userspace  dev-interface linux-2.6.7
Message-Id: <427F4202.60601@inf.ed.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <42775670.5070709@inf.ed.ac.uk>
In-Reply-To: <42775670.5070709@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi,

here is an updated version of Documentation/i2c/dev_interface
which just adds that there are two versions of i2c-dev.h
and that the userspace version is distributed with lm_sensors.

   nils
-------------- next part --------------
--- Documentation/i2c/dev-interface.orig	2005-05-09 11:47:22.000000000 +0100
+++ Documentation/i2c/dev-interface	2005-05-09 11:50:18.000000000 +0100
@@ -16,7 +16,9 @@ C example
 So let's say you want to access an i2c adapter from a C program. The
 first thing to do is `#include <linux/i2c.h>" and "#include <linux/i2c-dev.h>. 
 Yes, I know, you should never include kernel header files, but until glibc 
-knows about i2c, there is not much choice.
+knows about i2c, there is not much choice. For this purpose there are two 
+i2c-dev.h files, one for kernel-space and one for user-space. The user-space 
+version of i2c-dev.h is distributed with lm_sensors for historical reasons.
 
 Now, you have to decide which adapter you want to access. You should
 inspect /sys/class/i2c-dev/ to decide this. Adapter numbers are assigned
