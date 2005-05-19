From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] asb100 bug
Message-Id: <20040411040439.GA17920@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi nymisi, Greg:

* Nyeste Mih?ly <nymisi@freemail.hu> [2004-01-27 16:02:04 +0100]:
> Hi!
> 
> I reported a bug of asb100 chip at: 
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket39
> 
> The reply was the follow:
> 
> "Is there a BIOS option you can disable, e.g. Asus "COP",
> "QFAN", or some such?  My guess is that the BIOS is
> somehow interfering with the asb100 driver.  Otherwise
> I don?t know how this could happen.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Yeah, I wrote that.

"You do that, you go to the box, you know.  Two minutes by
yourself, and you feel shame, you know." - Denis the goalie

Greg, please apply this fix (vs. 2.6.5):


--- linux-2.6.5/drivers/i2c/chips/asb100.c.orig	2004-04-10 23:58:36.005741695 -0400
+++ linux-2.6.5/drivers/i2c/chips/asb100.c	2004-04-10 23:58:15.000000000 -0400
@@ -467,7 +467,7 @@
 		data->reg[nr] = TEMP_TO_REG(val); \
 		break; \
 	} \
-	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr), \
+	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr+1), \
 			data->reg[nr]); \
 	return count; \
 }



-- 
Mark M. Hoffman
mhoffman@lightlink.com
