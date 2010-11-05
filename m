From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 05 Nov 2010 03:07:45 +0000
Subject: Re: [lm-sensors] [PATCH 7/8] hwmon: applesmc: Simplify feature
Message-Id: <20101105030745.GF28308@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se>
 <1288511434-5662-8-git-send-email-rydberg@euromail.se>
In-Reply-To: <1288511434-5662-8-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Sun, Oct 31, 2010 at 03:50:33AM -0400, Henrik Rydberg wrote:
> Given the dynamic node construction method, the setup of the
> accelerometer, light sensor and keyboard backlight sysfs nodes
> can be simplified. This patch does not contain any logic changes.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Hi Henrik,

only one minor comment.

> ---
>  drivers/hwmon/applesmc.c |  168 ++++++++++++++++++++-------------------------
>  1 files changed, 75 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 4ba20ec..c09cd2e 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c

[ ... ]

> +static struct applesmc_node_group info_group[] = {
> +	{ "name", applesmc_name_show },
> +	{ "key_count", applesmc_key_count_show },
> +	{ "key_at_index", applesmc_key_at_index_show, applesmc_key_at_index_store },

Finally a checkpatch warning - line longer than 80 columns.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
