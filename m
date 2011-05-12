From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 May 2011 09:42:03 +0000
Subject: Re: [lm-sensors] [PATCH] Add detection of EMC2300 to sensors-detect
Message-Id: <20110512114203.6904494f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305037766-17323-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1305037766-17323-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 May 2011 15:29:26 +0100, Steve Glendinning wrote:
> EMC2300 is already detected, but is reported as EMC6D103S.  These
> two are register compatible and it's not actually possible to
> distinguish between them by registers so this patch changes the
> sensors-detect script to report it's found "EMC6D103S or EMC2300".
> 
> Both are supported by the same lm85 driver, so this patch makes
> it more obvious to anyone grepping the source that EMC2300 is
> supported.
> 
> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
> ---
>  prog/detect/sensors-detect |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
