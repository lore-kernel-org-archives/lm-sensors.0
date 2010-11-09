From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Nov 2010 09:21:48 +0000
Subject: Re: [lm-sensors] [PATCH 15/32] drivers/hwmon/it87.c: Use pr_fmt and
Message-Id: <20101109102148.0bb0a283@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com>
	<ca9c0c999e7108d20fab9d4be3b310736bbdd7a6.1287556801.git.joe@perches.com>
In-Reply-To: <ca9c0c999e7108d20fab9d4be3b310736bbdd7a6.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, 19 Oct 2010 23:51:39 -0700, Joe Perches wrote:
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/hwmon/it87.c |   30 ++++++++++++++----------------
>  1 files changed, 14 insertions(+), 16 deletions(-)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
