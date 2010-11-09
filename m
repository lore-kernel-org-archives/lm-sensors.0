From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:58:31 +0000
Subject: Re: [lm-sensors] [29/32] drivers/hwmon/vt8231.c: Use pr_fmt and
Message-Id: <20101109165831.GA17807@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2f9af9098da1daa404968edb93ae4387f81ec1a2.1287556801.git.joe@perches.com>
In-Reply-To: <2f9af9098da1daa404968edb93ae4387f81ec1a2.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Roger Lucas <vt8231@hiddenengine.co.uk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:53AM -0000, Joe Perches wrote:
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
