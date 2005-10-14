From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 14 Oct 2005 21:51:55 +0000
Subject: [lm-sensors] [PATCH] hwmon - lm78, lm85  sparse fixes
Message-Id: <20051014202054.005a536d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051013102407.GA31018@home.fluff.org>
In-Reply-To: <20051013102407.GA31018@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> lm78.c and lm85.c have a number of items declared static
> then implemented without the static on them. The following
> patch fixes the sparse errors below
> 
>   CHECK   drivers/hwmon/lm78.c
> drivers/hwmon/lm78.c:483:5: warning: symbol 'lm78_detect' was not declared. Should it be static?
>   CHECK   drivers/hwmon/lm85.c
> drivers/hwmon/lm85.c:1010:5: warning: symbol 'lm85_attach_adapter' was not declared. Should it be static?
> drivers/hwmon/lm85.c:1017:5: warning: symbol 'lm85_detect' was not declared. Should it be static?
> drivers/hwmon/lm85.c:1239:5: warning: symbol 'lm85_detach_client' was not declared. Should it be static?
> drivers/hwmon/lm85.c:1249:5: warning: symbol 'lm85_read_value' was not declared. Should it be static?
> drivers/hwmon/lm85.c:1279:5: warning: symbol 'lm85_write_value' was not declared. Should it be static?
> drivers/hwmon/lm85.c:1308:6: warning: symbol 'lm85_init_client' was not declared. Should it be static?

Correct, applied, thanks.

-- 
Jean Delvare
