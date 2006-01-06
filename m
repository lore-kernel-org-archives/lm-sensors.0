From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Fri, 06 Jan 2006 17:46:52 +0000
Subject: [lm-sensors] [-mm patch] fix W1_MASTER_DS9490_BRIDGE
Message-Id: <20060106174651.GB16266@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060106174101.GT12131@stusta.de>
In-Reply-To: <20060106174101.GT12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 06:41:01PM +0100, Adrian Bunk (bunk at stusta.de) wrote:
> W1_DS9490 was renamed to W1_MASTER_DS9490, but the entry in the 
> dependencies of W1_MASTER_DS9490_BRIDGE was forgotten.
> 
>
> Signed-off-by: Adrian Bunk <bunk at stusta.de>

You are 100% correct.
Thank you.

> --- linux-2.6.15-mm1-full/drivers/w1/masters/Kconfig.old	2006-01-06 18:17:23.000000000 +0100
> +++ linux-2.6.15-mm1-full/drivers/w1/masters/Kconfig	2006-01-06 18:17:53.000000000 +0100
> @@ -26,7 +26,7 @@
>  
>  config W1_MASTER_DS9490_BRIDGE
>  	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
> -	depends on W1_DS9490
> +	depends on W1_MASTER_DS9490
>  	help
>  	  Say Y here if you want to communicate with your 1-wire devices
>  	  using DS9490R USB bridge.

-- 
	Evgeniy Polyakov

