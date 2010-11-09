From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:57:43 +0000
Subject: Re: [lm-sensors] [28/32] drivers/hwmon/vt1211.c: Use pr_fmt and
Message-Id: <20101109165743.GA17453@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <d95988253a87f5d8367607266ab92792f90ffd34.1287556801.git.joe@perches.com>
In-Reply-To: <d95988253a87f5d8367607266ab92792f90ffd34.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Juerg Haefliger <juergh@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:52AM -0000, Joe Perches wrote:
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 

Applied, with a minor change. checkpatch.pl complains about line lengths
around lines 1336 and 1342. I used the original split instead of the one-line
text.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
