From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 08 Sep 2012 00:28:01 +0000
Subject: Re: [lm-sensors] [PATCH 0/1] Add lm-sensors support for it8771 (Asus E350M1-I).
Message-Id: <20120908002801.GA15445@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347060881-14106-1-git-send-email-kelly@silka.with-linux.com>
In-Reply-To: <1347060881-14106-1-git-send-email-kelly@silka.with-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 07, 2012 at 05:34:40PM -0600, Kelly Anderson wrote:
> Signed-off-by: Kelly Anderson <kelly@silka.with-linux.com>
> 
> Kelly Anderson (1):
>   Add lm-sensors support for it8771 (Asus E350M1-I).
> 
>  drivers/hwmon/it87.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
Hi Kelly,

both in one message (Signed-off is part of the commit log), please, and

WARNING: line over 80 characters
#87: FILE: drivers/hwmon/it87.c:64:
+enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
it8782,

Just a note for next time - no need to resend. We'll need to sort out what
to do with the patch, ie if we want to take the risk of applying it without
technical documentation.

In this context - how does the fan output look like in your system ? Does it
make sense ? Also, can you control the fan speed with the pwm attributes,
and do the pwmX_auto_point4_XXX attributes report reasonable information ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
