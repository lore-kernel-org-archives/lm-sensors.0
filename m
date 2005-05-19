From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: [PATCH] 5V voltage incorrect on lm93
Message-Id: <421E125A.7020300@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
    I have been hunting down an issue related to the IN10 input of the 
LM93.   I have observed that there is a rather large error between the 
actual voltage and the voltage level displayed by sensors(1)  (~ .12V).

Please find attached a small patch that fixes this problem.   The data 
sheet is very ambiguous and I and another engineer made the same mistake 
calculating the voltage per DAC step the first time we read the spec sheet.

The confusion stems from an entry in the "maximum voltage" column that 
is higher than the value in the "absolute maximum range" column.  For 5V 
only, the value in the "register reading at maximum voltage" is for the 
voltage in the "absolute maximum range", NOT the "maximum voltage".  Whew!

I have tested this patch and it fixes the problem I just outlined. 
This patch is against lm_sensors 2.9.0.

David
-------------- next part --------------
--- lm_sensors-2.9.0/kernel/chips/lm93.c.orig	2005-02-24 11:08:22.000000000 -0500
+++ lm_sensors-2.9.0/kernel/chips/lm93.c	2005-02-24 12:34:52.000000000 -0500
@@ -689,7 +689,7 @@
 };
 static const unsigned long lm93_vin_val_max[16] = {
 	1236, 1236, 1236, 1600, 2000, 2000, 1600, 1600,
-	4400, 6667, 3333, 2625, 1312, 1312, 1236, 3600,
+	4400, 6500, 3333, 2625, 1312, 1312, 1236, 3600,
 };
 /*
 static const unsigned long lm93_vin_val_nom[16] = {
