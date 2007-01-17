From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 17 Jan 2007 21:03:59 +0000
Subject: [lm-sensors] [PATCH] W83793: ignore the temperature readings
Message-Id: <20070117220359.9d7c2038.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A77F63.5080808@assembler.cz>
In-Reply-To: <45A77F63.5080808@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gong,

On Tue, 16 Jan 2007 18:25:38 +0800, JGong at winbond.com wrote:
> >w83793: ignore the temperature readings when its channel is disabled,
> >ignore AMDSI readings.
> 
> >Signed-off-by: Gong Jun <jgong at winbond.com>
> >Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
> 
> In addition I have added the code to skip the unused temperature
> registers to speed up the update functions. Also it is tested on my
> motherboard.

You've been too generous in your changes:

> @@ -1445,9 +1491,12 @@ static void w83793_update_nonvolatile(st
>  		}
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(data->temp_mode); i++)
> +	for (i = 0; i < ARRAY_SIZE(data->temp_mode); i++) {
> +		if (!(data->has_temp & (1 << i)))
> +                        continue;
>  		data->temp_mode[i] >  		    w83793_read_value(client, W83793_REG_TEMP_MODE[i]);
> +	}
>  
>  	for (i = 0; i < ARRAY_SIZE(data->tolerance); i++) {
>  		data->tolerance[i] 
This change isn't correct, as temp_mode is a two-byte array, not 6. In
fact we can assume that at least a couple temperature channels will be
in use on every board so the test isn't really worth the effort.

Patch applied, with Rudolf's cleanups and documentation update.

Thanks,
-- 
Jean Delvare

