From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 25 Feb 2015 07:28:25 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Detect additional IDT temperature sensors
Message-Id: <20150225082825.40835f43@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424840782-27848-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1424840782-27848-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 Feb 2015 21:06:22 -0800, Guenter Roeck wrote:
> Loosen detection rules for TS3000/TSE2002 to detect additional
> chip revisions. Add detection of TSE2004 and TS3001.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    |  2 ++
>  prog/detect/sensors-detect | 21 +++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/CHANGES b/CHANGES
> index ed95b66..9237506 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -30,6 +30,8 @@ SVN HEAD
>                    Add detection of IT8780F
>                    Add detection of IT8731F and IT8732F
>                    Add detection of Intel 5500/5520/X58
> +                  Loosen detection rules for TS3000/TSE2002
> +                  Add detection of TSE2004 and TS3001
>  (...)

Looks good, please commit.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
