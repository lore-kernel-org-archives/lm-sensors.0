From: socialhacker@socialhacker.com (anton)
Date: Mon, 21 Nov 2005 09:38:50 +0000
Subject: [lm-sensors] it87.c fan_div patch
Message-Id: <Pine.LNX.4.21.0511210218160.2818-200000@sterling.propagation.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


	Hi, I just got lm_sensors (v2.9.2) up and running on my Shuttle
(SN41G) and am loving it.  In setting things up I found what I think is a
bug in the it87_fan_div setting code.  I've included a patch vs. TOT
CVS.  What was happening was that the check to make sure the third fan's
divisor was either 2 or 8 was using the wrong member of the it87 data
structure.  This was causing the if to always fail and thus always force
the divisor to 2.

	Let me know what you think.

	Thanks again,
		Anton V. Staaf (http://www.socialhacker.com/)
-------------- next part --------------
? fan_div.anton.11.21.2005.patch
Index: kernel/chips/it87.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/it87.c,v
retrieving revision 1.37
diff -u -p -r1.37 it87.c
--- kernel/chips/it87.c	30 Oct 2005 11:52:13 -0000	1.37
+++ kernel/chips/it87.c	21 Nov 2005 08:41:06 -0000
@@ -1019,7 +1019,7 @@ void it87_fan_div(struct i2c_client *cli
 		old = it87_read_value(client, IT87_REG_FAN_DIV);
 		if (*nrels_mag >= 3) {
 			data->fan_div[2] = DIV_TO_REG(results[2]);
-			if( data->fan[2]!=3 ) {
+			if( data->fan_div[2]!=3 ) {
 				data->fan_div[2] = 1;
 				old = (old & 0xbf);
 			} else {
