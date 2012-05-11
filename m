From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 May 2012 21:10:09 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (it87) Convert to use devm_kzalloc
Message-Id: <20120511231009.738daa2c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  8 May 2012 19:31:53 -0700, Guenter Roeck wrote:
> This makes the code a bit simpler and smaller.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)

You'll have to adjust this patch as it is killing label ERROR2 which is
still in use now that patch "hwmon: (it87) Create voltage attributes
only if voltage is enabled" was updated.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
