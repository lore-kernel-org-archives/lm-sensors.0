From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 20 Oct 2010 09:54:46 +0000
Subject: Re: [lm-sensors] [PATCH 04/32] drivers/hwmon/applesmc.c: Use pr_fmt
Message-Id: <4CBEBC66.3080205@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com> <e12d6edddfdcf543308dd81dfb6b7672f578bfb5.1287556801.git.joe@perches.com>
In-Reply-To: <e12d6edddfdcf543308dd81dfb6b7672f578bfb5.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 10/20/2010 08:51 AM, Joe Perches wrote:

> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/hwmon/applesmc.c |   60 ++++++++++++++++++++-------------------------
>  1 files changed, 27 insertions(+), 33 deletions(-)


Minus the comments already provided, all good.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
