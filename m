From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Oct 2010 16:24:42 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: (lm90) Add support for
Message-Id: <20101007182442.4b100e65@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286464011-14356-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286464011-14356-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 7 Oct 2010 08:06:51 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v4 changes:
> - Use higher shift value in update interval calculation to further reduce
>   rounding errors.
> - Use DIV_ROUND_CLOSEST instead of manual rounding.
> 
> v3 changes:
> - Removed unnecessary constant.
> - Improved update interval calculation to avoid rounding error.
> 
>  drivers/hwmon/lm90.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 92 insertions(+), 5 deletions(-)
> 

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
