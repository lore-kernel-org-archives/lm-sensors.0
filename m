From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: RFC PATCH remove DIV_TO_REG in gl518sm.c
Message-Id: <st1s31h4ugdd8gq5d6p22mjhson8ahnf9t@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Starting converting gl518sm.c to use proper DIV_TO_REG error 
handling and found nothing using the macro?

This trivial patch removes that apparently unused macro.

Signed-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.11-mm4/drivers/i2c/chips/gl518sm.c	2005-03-17 07:56:47.000000000 +1100
+++ linux-2.6.11-mm4x/drivers/i2c/chips/gl518sm.c	2005-03-21 10:29:06.000000000 +1100
@@ -109,7 +109,6 @@
 #define VDD_TO_REG(val)		(SENSORS_LIMIT((((val)*4+47)/95),0,255))
 #define VDD_FROM_REG(val)	(((val)*95+2)/4)
 
-#define DIV_TO_REG(val)		((val)=4?2:(val)=2?1:(val)=1?0:3)
 #define DIV_FROM_REG(val)	(1 << (val))
 
 #define BEEP_MASK_TO_REG(val)	((val) & 0x7f & data->alarm_mask)
