From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 20 Nov 2014 09:19:30 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] sensors-detect: EMC14xx chip updates
Message-Id: <20141120101930.4a644cc6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416333599-12717-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1416333599-12717-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 18 Nov 2014 09:59:59 -0800, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    |  3 +++
>  prog/detect/sensors-detect | 26 +++++++++++++++++---------
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/CHANGES b/CHANGES
> index 62cfd24..505257f 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -21,6 +21,9 @@ SVN HEAD
>                    Show that NCT6102D/6104D/6106D are supported by nct6775 driver
>                    Show that NCT5573D is compatible to NCT6776F and has the same
>                    chip ID.
> +                  Document support for EMC1402, EMC1404, and EMC1424.
> +                  Detect new revisions of EMC14xx.
> +                  Add detection of EMC1422.

No trailing dots please.

Everything else looks good, please commit.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
