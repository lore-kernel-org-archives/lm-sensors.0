From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Jun 2006 19:45:11 +0000
Subject: [lm-sensors] [PATCH] hwmon w83792d add data lock to all store
Message-Id: <20060601214511.3b454f57.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <447D3714.6070506@winbond.com.tw>
In-Reply-To: <447D3714.6070506@winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> > > I add the lock to all store functions in this patch, please can
> > > you check?
> > 
> > It's OK except in store_pwmenable where you would leave with the lock
> > held on incorrect input value.
> > 
> > Your patch also lacked your signed-off-by line, and a proper summary...
> 
> Sorry, maybe i heat my head too heavily last time :(
> Can you check this one, thanks :)

No problem. I applied it with just one fix:

>  	default:
> -		return -EINVAL;
> +		break;
>  	}

This made the default case pretty useless so I dropped it altogether.

Thanks,
-- 
Jean Delvare

