From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:37:40 +0000
Subject: Re: [lm-sensors] [06/32] drivers/hwmon/asus_atk0110.c: Use pr_fmt
Message-Id: <20101109163740.GA14733@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <506bc745e46020fb99159fd73288d3b0202c99cf.1287556801.git.joe@perches.com>
In-Reply-To: <506bc745e46020fb99159fd73288d3b0202c99cf.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Luca Tettamanti <kronos.it@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:30AM -0000, Joe Perches wrote:
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
Applied.

On a side note, I let the long lines go through as long as checkpatch doesn't complain.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
