From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 May 2008 19:14:16 +0000
Subject: Re: [lm-sensors] [PATCH] Transition w83791d maintenance to Marc
Message-Id: <20080516211416.1557f514@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80805141236h4d32e3d1g914300019e9e8f63@mail.gmail.com>
In-Reply-To: <5bfe43f80805141236h4d32e3d1g914300019e9e8f63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles, hi Marc,

On Wed, 14 May 2008 12:36:23 -0700, Charles Spirakis wrote:
> I no longer have access to w83791d hardware. Fortunately, Marc Hulsman
> has graciously offered to take over driver maintenance for the
> w83791d. Enclosed is a patch to change the maintainer information.
> 
> Thanks Marc!

Great, thanks Marc for taking over, and thanks Charles for maintaining
the w83791d driver so far :)

Just one question:

> Transition the maintenance of the w83791d driver to Marc Hulsman.
> 
> Signed-off-by: Charles Spirakis <bezaur@gmail.com>
> 
> ---
>  MAINTAINERS |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -urpN linux-2.6.26-rc1-git3/MAINTAINERS linux-2.6.26-rc1-git3_w83791d/MAINTAINERS
> --- linux-2.6.26-rc1-git3/MAINTAINERS	2008-05-03 11:59:44.000000000 -0700
> +++ linux-2.6.26-rc1-git3_w83791d/MAINTAINERS	2008-05-13 23:09:01.000000000 -0700
> @@ -4387,8 +4387,8 @@ M:	johnpol@2ka.mipt.ru
>  S:	Maintained
>  
>  W83791D HARDWARE MONITORING DRIVER
> -P:	Charles Spirakis
> -M:	bezaur@gmail.com
> +P:	Marc Hulsman
> +M:	m.hulsman@tudelft.nl
>  L:	lm-sensors@lm-sensors.org
>  S:	Odd Fixes

Will Marc only take care of the "odd fixes" or will he be fully
maintaining the driver? In the latter case this line should be updated
accordingly.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
