From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814533933@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1081981453446@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.27, 2004/04/12 15:17:01-07:00, mhoffman@lightlink.com

[PATCH] I2C: fix asb100 bug

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


 drivers/i2c/chips/asb100.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:31 2004
+++ b/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:31 2004
@@ -468,7 +468,7 @@
 		data->reg[nr] = TEMP_TO_REG(val); \
 		break; \
 	} \
-	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr), \
+	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr+1), \
 			data->reg[nr]); \
 	return count; \
 }

