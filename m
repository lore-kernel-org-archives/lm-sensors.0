From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 12 Dec 2014 09:04:36 +0000
Subject: Re: [lm-sensors] [PATCH v4] sensors-detect: Add code to detect TMP400 and TMP435
Message-Id: <20141212100436.0a3321e5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418307248-1533-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1418307248-1533-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 11 Dec 2014 06:14:08 -0800, Guenter Roeck wrote:
> Also strengthen chip detection for other TMP4xx chips,
> and update driver support status for TMP431 and TMP432.
> 
> Write new function for various TMP4xx chips and separate
> from lm90 detection.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4: Rename tmp4xx_detect -> tmp401_detect
>     Rename limit1/2/3 -> rtemp/rhigh/rlow
>     Strenghten TMP451 detection
> v3: Move chip detection for various TMP4xx chips to its own function
>     Add TMP400 detection
> 
> The new detection function was tested with TMP401, TMP411A, TMP431, TMP432,
> TMP435, and TMP451.
> 
>  CHANGES                    |   2 +
>  prog/detect/sensors-detect | 127 ++++++++++++++++++++++++++++++---------------
>  2 files changed, 88 insertions(+), 41 deletions(-)

Looks good, please commit.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
