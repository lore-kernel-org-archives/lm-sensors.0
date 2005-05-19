From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH] bmcsensors 2.9.0 compile fix
Message-Id: <41D559C0.3040408@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041230172920.GE10397@neu.nirvana>
In-Reply-To: <20041230172920.GE10397@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

my bad, thanks :)

Axel Thimm wrote:
> Hi,
> 
> there are two "sd->" structure deferences missing.
> 
> Thanks.
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ./kernel/chips/bmcsensors.c
> =================================> RCS file: /home/cvs/lm_sensors2/kernel/chips/bmcsensors.c,v
> retrieving revision 1.20
> diff -u -d -r1.20 bmcsensors.c
> --- ./kernel/chips/bmcsensors.c	4 Dec 2004 21:18:34 -0000	1.20
> +++ ./kernel/chips/bmcsensors.c	30 Dec 2004 14:25:25 -0000
> @@ -297,7 +297,7 @@
>  	}
>  
>  	/* swap lim1/lim2 if m < 0 or function is 1/x (but not both!) */
> -	if(m < 0 && sd->linear != 7 || m >= 0 && sd->linear = 7) {
> +	if(sd->m < 0 && sd->linear != 7 || sd->m >= 0 && sd->linear = 7) {
>  		tmp = sd->lim1;
>  		sd->lim1 = sd->lim2;
>  		sd->lim2 = tmp;
