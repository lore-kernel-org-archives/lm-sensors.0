From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:28:20 +0000
Subject: Re: [lm-sensors] [02/32] drivers/hwmon/abituguru3.c: Use pr_fmt and
Message-Id: <20101109162820.GA13531@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <b613356834d854a5abb68637981c3c72d6e96822.1287556801.git.joe@perches.com>
In-Reply-To: <b613356834d854a5abb68637981c3c72d6e96822.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Alistair John Strachan <alistair@devzero.co.uk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:26AM -0000, Joe Perches wrote:
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> Added a few static strings to standardize logging messages.
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
