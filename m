From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:25:55 +0000
Subject: Re: [lm-sensors] [01/32] drivers/hwmon/abituguru.c: Use pr_fmt and
Message-Id: <20101109162555.GA13340@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <26de47ba1bd7356e5b4c2490a3377bc2860007a4.1287556801.git.joe@perches.com>
In-Reply-To: <26de47ba1bd7356e5b4c2490a3377bc2860007a4.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:25AM -0000, Joe Perches wrote:
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
