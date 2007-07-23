From: =?utf-8?q?Hans-J=C3=BCrgen_Koch?= <hjk@linutronix.de>
Date: Mon, 23 Jul 2007 07:36:57 +0000
Subject: Re: [lm-sensors] drivers/hwmon/lm93.c: array overruns
Message-Id: <200707230936.58135.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070723005453.GS26212@stusta.de>
In-Reply-To: <20070723005453.GS26212@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Am Montag 23 Juli 2007 02:54 schrieb Adrian Bunk:
> The Coverity checker spotted the following array overruns
> in drivers/hwmon/lm93.c:
> 
> <--  snip  -->
> 
> ...
> struct lm93_data {
> ...
>         struct {
>                 u8 min;
>                 u8 max;
>         } temp_lim[3];
> ...
> };
> ...
> static void lm93_update_client_common(struct lm93_data *data,
>                                       struct i2c_client *client)
> {
> ...
>         for (i = 0; i < 4; i++) {
>                 data->temp_lim[i].min >                         lm93_read_byte(client, LM93_REG_TEMP_MIN(i));
>                 data->temp_lim[i].max >                         lm93_read_byte(client, LM93_REG_TEMP_MAX(i));
>         }
> ...
> 
> <--  snip  -->

This patch should fix it. Thanks a lot, Adrian!

----
This fixes an array overflow bug. We have 4 pairs of min/max temperature 
limits, not 3.

Signed-off-by: Hans J. Koch <hjk@linutronix.de>

--
Index: linux-2.6.23-rc/drivers/hwmon/lm93.c
=================================--- linux-2.6.23-rc.orig/drivers/hwmon/lm93.c	2007-07-23 09:22:56.000000000 +0200
+++ linux-2.6.23-rc/drivers/hwmon/lm93.c	2007-07-23 09:29:37.000000000 +0200
@@ -234,7 +234,7 @@
 	struct {
 		u8 min;
 		u8 max;
-	} temp_lim[3];
+	} temp_lim[4];
 
 	/* vin1 - vin16: low and high limits */
 	struct {




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
