From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Mar 2010 09:57:18 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: remove the deprecated adt7473 driver
Message-Id: <20100305105718.4a680b3c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305082008.5273.22938.sendpatchset@localhost.localdomain>
In-Reply-To: <20100305082008.5273.22938.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amerigo Wang <amwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Amerigo Wang <amwang@redhat.com>, lm-sensors@lm-sensors.org

On Fri, 5 Mar 2010 03:16:33 -0500, Amerigo Wang wrote:
> 
> adt7473 driver is obsoleted by adt7475 driver. And it is scheduled
> to be removed in Feb 2010.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: WANG Cong <amwang@redhat.com>
> 
> ---
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 0349790..8debdd6 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -449,12 +449,6 @@ Who:	Alok N Kataria <akataria@vmware.com>
>  
>  ----------------------------
>  
> -What:	adt7473 hardware monitoring driver
> -When:	February 2010
> -Why:	Obsoleted by the adt7475 driver.
> -Who:	Jean Delvare <khali@linux-fr.org>
> -
> ----------------------------
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
