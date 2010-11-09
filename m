From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:35:00 +0000
Subject: Re: [lm-sensors] [04/32] drivers/hwmon/applesmc.c: Use pr_fmt and
Message-Id: <20101109163500.GA14075@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e12d6edddfdcf543308dd81dfb6b7672f578bfb5.1287556801.git.joe@perches.com>
In-Reply-To: <e12d6edddfdcf543308dd81dfb6b7672f578bfb5.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Henrik Rydberg <rydberg@euromail.se>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:28AM -0000, Joe Perches wrote:
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
Applied, with Henrik's Ack as discussed earlier.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
