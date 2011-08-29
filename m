From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 29 Aug 2011 15:08:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm90) Fix warnings
Message-Id: <1314630531.2796.148.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110829133835.3b8fb7f2@endymion.delvare>
In-Reply-To: <20110829133835.3b8fb7f2@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-08-29 at 07:38 -0400, Jean Delvare wrote:
> With some configuration option combinations, we get the following
> warnings:
> 
> drivers/hwmon/lm90.c: In function 'lm90_detect':
> drivers/hwmon/lm90.c:1114: warning: 'chip_id' may be used uninitialized
> in this function
> drivers/hwmon/lm90.c:1114: warning: 'reg_config1' may be used
> uninitialized in this function
> drivers/hwmon/lm90.c:1114: warning: 'reg_convrate' may be used
> uninitialized in this function
> drivers/hwmon/lm90.c:1187: warning: 'reg_emerg2' may be used
> uninitialized in this function
> drivers/hwmon/lm90.c:1187: warning: 'reg_status2' may be used
> uninitialized in this function
> 
> We can solve these easily by reading the register values first and
> checking for errors later. These errors should be very rare, even in
> the case of failed detection, so this change has no impact on
> performance. And this makes checkpatch.pl happier.
> 
> Reported-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
