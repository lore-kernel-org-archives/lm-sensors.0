From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:54:03 +0000
Subject: Re: [lm-sensors] [27/32] drivers/hwmon/via686a.c: Use pr_fmt and
Message-Id: <20101109165403.GA17267@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <d6f213984afeaa0f07fe39d0849c8d80fac85661.1287556801.git.joe@perches.com>
In-Reply-To: <d6f213984afeaa0f07fe39d0849c8d80fac85661.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:51AM -0000, Joe Perches wrote:
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
