From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Nov 2010 09:35:11 +0000
Subject: Re: [lm-sensors] [PATCH 20/32] drivers/hwmon/pc87427.c: Use pr_fmt
Message-Id: <20101109103511.3cf94514@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com>
	<8a5f258d9b494988e1ca2ded006423d9cdab8e54.1287556801.git.joe@perches.com>
In-Reply-To: <8a5f258d9b494988e1ca2ded006423d9cdab8e54.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, 19 Oct 2010 23:51:44 -0700, Joe Perches wrote:
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/hwmon/pc87427.c |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
