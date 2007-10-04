From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Oct 2007 15:23:45 +0000
Subject: Re: [lm-sensors] [PATCH 1/3 RESEND 2] hwmon/dme1737: cleanups
Message-Id: <20071004172345.7180eeb9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710012119s713699efhd479c6326c9dbcb@mail.gmail.com>
In-Reply-To: <191fb4ca0710012119s713699efhd479c6326c9dbcb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 1 Oct 2007 21:19:04 -0700, Juerg Haefliger wrote:
> This patch cleans up and prepares the dme1737 driver for support of the sch311x
> chips. (Almost) no functional changes.
> 
> - Replaced whitespaces with tabs.
> - Removed empty lines.
> - Added _i2c_ to names of functions that are strictly I2C related.
> - Added 4 new functions: dme1737_create_files, dme1737_remove_files,
>  dme1737_sio_enter, and dme1737_sio_exit.
> - Added error messages in case client attach/detach fails.

Not really, as you backed up (most of) these changes. Anyway...

> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

Note that I had to replace all occurrences of "class_dev" to
"hwmon_dev", otherwise this patch doesn't apply on top of "hwmon:
Convert from class_device to device" in Mark's tree.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
