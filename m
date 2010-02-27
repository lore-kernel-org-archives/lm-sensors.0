From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 27 Feb 2010 10:58:59 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support
Message-Id: <20100227115859.4cae40c4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265804313-28132-1-git-send-email-giometti@linux.it>
In-Reply-To: <1265804313-28132-1-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rodolfo,

On Wed, 10 Feb 2010 13:18:33 +0100, Rodolfo Giometti wrote:
> The drivers has been splitted up into two parts:
> 
> * drivers/mfd/w83627hf-core.c 	   - detects the chip and define proper
>   				     platform devices into mfd support
> 
> * drivers/hwmon/w83627hf.c	   - implements the driver for hwmon
>   				     functionality only
> 
> Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> ---
> 
> Jean, can you please take a look at this patch? It should apply over
> your last patch.

Are you sure you sent the latest version of your patch? It doesn't
apply on top of 2.6.33, there are 6 FAILED on drivers/hwmon/w83627hf.c.
I will try fixing them myself if I must, but if you happen to have an
updated version already...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
