From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.4] I2C updates for 2.4.31-pre1 (3/3)
Message-Id: <20050501200340.51c339f2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050501185236.2f76a5ba.khali@linux-fr.org>
In-Reply-To: <20050501185236.2f76a5ba.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

Fix an iteration bug in the handling of i2c client module parameters.
The "force" module parameter is a list of adapter, address pairs, not
triplets. The current code would only handle the first, fourth, seventh
etc. pairs properly. I guess that nobody ever needed more than one pair,
or the bug would have been noticed way earlier. This bug was originally
fixed by myself in Linux 2.6.

http://marc.theaimsgroup.com/?l=linux-kernel&m1231616107325
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/i2c/i2c-core.c@1.66

--- linux-2.4.30-rc1/drivers/i2c/i2c-core.c.orig	2005-03-10 19:57:34.000000000 +0100
+++ linux-2.4.30-rc1/drivers/i2c/i2c-core.c	2005-03-27 19:09:46.000000000 +0200
@@ -851,7 +851,7 @@
 		   at all */
 		found = 0;
 
-		for (i = 0; !found && (address_data->force[i] != I2C_CLIENT_END); i += 3) {
+		for (i = 0; !found && (address_data->force[i] != I2C_CLIENT_END); i += 2) {
 			if (((adap_id = address_data->force[i]) || 
 			     (address_data->force[i] = ANY_I2C_BUS)) &&
 			     (addr = address_data->force[i+1])) {


-- 
Jean Delvare
