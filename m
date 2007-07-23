From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 23 Jul 2007 00:54:53 +0000
Subject: [lm-sensors] drivers/hwmon/lm93.c: array overruns
Message-Id: <20070723005453.GS26212@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?utf-8?Q?Hans-J=C3=BCrgen?= Koch <hjk@linutronix.de>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

The Coverity checker spotted the following array overruns
in drivers/hwmon/lm93.c:

<--  snip  -->

...
struct lm93_data {
...
        struct {
                u8 min;
                u8 max;
        } temp_lim[3];
...
};
...
static void lm93_update_client_common(struct lm93_data *data,
                                      struct i2c_client *client)
{
...
        for (i = 0; i < 4; i++) {
                data->temp_lim[i].min                         lm93_read_byte(client, LM93_REG_TEMP_MIN(i));
                data->temp_lim[i].max                         lm93_read_byte(client, LM93_REG_TEMP_MAX(i));
        }
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
