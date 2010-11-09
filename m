From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:49:39 +0000
Subject: Re: [lm-sensors] [21/32] drivers/hwmon/pcf8591.c: Use pr_fmt and
Message-Id: <20101109164939.GA16546@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e021d63730a851db5af583961145f95217f1787d.1287556801.git.joe@perches.com>
In-Reply-To: <e021d63730a851db5af583961145f95217f1787d.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:45AM -0000, Joe Perches wrote:
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
