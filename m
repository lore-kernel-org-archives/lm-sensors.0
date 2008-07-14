From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Jul 2008 16:22:47 +0000
Subject: Re: [lm-sensors] [lm_sensors legacy PATCH] Rename free_expr() to
Message-Id: <20080714182247.1ce3c1a0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1216042083-11676-1-git-send-email-vsu@altlinux.ru>
In-Reply-To: <1216042083-11676-1-git-send-email-vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergey,

On Mon, 14 Jul 2008 17:28:03 +0400, Sergey Vlasov wrote:
> The free_expr() function is no longer static in lib/init.c (it is also
> used in lib/conf-parse.y), and therefore must be renamed according to
> the libsensors naming conventions.
> 
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> ---
>  lib/conf-parse.y |    6 +++---
>  lib/init.c       |   12 ++++++------
>  lib/init.h       |    2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)

You're correct, good catch. I have applied your patch to the legacy
branch, and something equivalent to the 3.x branch. Thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
