From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Feb 2009 17:28:20 +0000
Subject: Re: [lm-sensors] [PATCHv2] MAINTAINERS: switch hdaps to Frank Seidel
Message-Id: <20090217182820.1ac46c01@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49980A67.7030403@suse.de>
	<49982084.80609@f-seidel.de>
In-Reply-To: <49982084.80609@f-seidel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frank Seidel <frank@f-seidel.de>
Cc: Frank Seidel <fseidel@suse.de>, linux kernel <linux-kernel@vger.kernel.org>, rlove@rlove.org, lm-sensors@lm-sensors.org

Hi Frank,

On Sun, 15 Feb 2009 15:02:44 +0100, Frank Seidel wrote:
> From: Frank Seidel <frank@f-seidel.de>
> 
> As Rovert Love doesn't any more seem to be realy
> active on hdaps driver i'll happily take it over.
> 
> Signed-off-by: Frank Seidel <frank@f-seidel.de>
> ---
>  MAINTAINERS |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1905,10 +1905,10 @@ W:	http://gigaset307x.sourceforge.net/
>  S:	Maintained
>  
>  HARD DRIVE ACTIVE PROTECTION SYSTEM (HDAPS) DRIVER
> -P:	Robert Love
> -M:	rlove@rlove.org
> -M:	linux-kernel@vger.kernel.org
> -W:	http://www.kernel.org/pub/linux/kernel/people/rml/hdaps/
> +P:	Frank Seidel
> +M:	frank@f-seidel.de
> +M:	lm-sensors@lm-sensors.org
> +W:	http://www.kernel.org/pub/linux/kernel/people/fseidel/hdaps

It looks like you accidentally created directory hsdpa instead of hdaps?

>  S:	Maintained
>  
>  GSPCA FINEPIX SUBDRIVER
> 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
