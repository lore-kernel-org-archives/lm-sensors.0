From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 17 Feb 2006 18:13:58 +0000
Subject: [lm-sensors] [PATCH 1/1 RESEND 2] i2c: add BroadCom HT-1000 to
Message-Id: <20060217191358.f1491350.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1F9Wda-0008Gs-00@devix>
In-Reply-To: <E1F9Wda-0008Gs-00@devix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

> @@ -66,7 +66,8 @@ this driver on those mainboards.
>  The ServerWorks Southbridges, the Intel 440MX, and the Victory766 are
>  identical to the PIIX4 in I2C/SMBus support.
>  
> -A few OSB4 southbridges are known to be misconfigured by the BIOS. In this
> -case, you have you use the fix_hstcfg module parameter. Do not use it
> -unless you know you have to, because in some cases it also breaks
> -configuration on southbridges that don't need it.
> +A few OSB4 (and probably HT-1000 too) southbridges are known to be 
> +misconfigured by the BIOS. In this case, you have you use the 
> +fix_hstcfg module parameter. Do not use it unless you know you have to, 
> +because in some cases it also breaks configuration on southbridges 
> +that don't need it.

What makes you think that "probably HT-1000 too"? You are the only
tester so far as far as I know, and you did not need the fix_hstcfg
module parameter, did you?

That left apart, your patch is fine by me.

Thanks,
-- 
Jean Delvare

