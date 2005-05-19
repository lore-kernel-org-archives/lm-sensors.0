From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [2.6 patch] make W1_DS9490_BRIDGE available
Message-Id: <1101140456.9784.0.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041122155102.GD19419@stusta.de>
In-Reply-To: <20041122155102.GD19419@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 16:51 +0100, Adrian Bunk wrote:
> It seems noone noted that due to a typo, the W1_DS9490_BRIDGE option 
> didn't have any effect.

hugh, you are right.
I have applied it to my tree, thank you.

> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/Kconfig.old	2004-11-22 14:34:13.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/Kconfig	2004-11-22 14:34:21.000000000 +0100
> @@ -30,7 +30,7 @@
>  	  This support is also available as a module.  If so, the module 
>  	  will be called ds9490r.ko.
>  
> -config W1_DS9490R_BRIDGE
> +config W1_DS9490_BRIDGE
>  	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
>  	depends on W1_DS9490
>  	help
-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041122/7780d18a/attachment.bin
