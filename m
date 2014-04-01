From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 01 Apr 2014 06:27:03 +0000
Subject: Re: [lm-sensors] [PATCH] misc: (ds1682) replace obsolete simple_strtoull() with kstrtoull()
Message-Id: <20140401082703.6782c30c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1395864664-16404-1-git-send-email-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <1395864664-16404-1-git-send-email-sebastien.bourdelin@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, jerome.oufella@savoirfairelinux.com

Hi Sebastien, 

On Wed, 26 Mar 2014 16:11:04 -0400, Sebastien Bourdelin wrote:
> simple_strtoull() is obsolete, use the newer kstrtoull() instead.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
>  drivers/misc/ds1682.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> (...)

You are sending this patch to the wrong list. The ds1682 driver has
nothing to do with lm-sensors. Please use ./scripts/get_maintainer.pl
to figure out who this patch should be sent to.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
