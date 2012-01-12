From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jan 2012 20:48:10 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm63) Add support for update_interval sysfs attribute
Message-Id: <20120112214810.41fbc860@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326223430-3297-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326223430-3297-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Jan 2012 17:47:32 -0800, Guenter Roeck wrote:
> The update interval is configurable on LM63 and compatibles. Add support for it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Simplify UPDATE_INTERVAL macro
>     Range limit value passed to lm63_set_convrate
>     Change type of 'kind' variable to enum chips
>     Add 'unlikely' to new if statement
> 
>  drivers/hwmon/lm63.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 90 insertions(+), 2 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
