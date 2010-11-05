From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 05 Nov 2010 03:09:23 +0000
Subject: Re: [lm-sensors] [PATCH 8/8] hwmon: applesmc: Update copyright
Message-Id: <20101105030923.GG28308@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se>
 <1288511434-5662-9-git-send-email-rydberg@euromail.se>
In-Reply-To: <1288511434-5662-9-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Sun, Oct 31, 2010 at 03:50:34AM -0400, Henrik Rydberg wrote:
> With the preceding patches, git blame assigns about half of
> the file to the present author. Add a line to the copyright
> to reflect this.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/hwmon/applesmc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index c09cd2e..7ae37eb 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -4,6 +4,7 @@
>   * computers.
>   *
>   * Copyright (C) 2007 Nicolas Boichat <nicolas@boichat.ch>
> + * Copyright (C) 2010 Henrik Rydberg <rydberg@euromail.se>
>   *
>   * Based on hdaps.c driver:
>   * Copyright (C) 2005 Robert Love <rml@novell.com>
> -- 


Hi Henrik,

overall excellent cleanup. 

One suggestion - since you did that much rework, it would be nice if you could fix
the remaining few checkpatch errors in the file as well (and possibly the warnings).

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
