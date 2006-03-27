From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Mar 2006 17:03:58 +0000
Subject: [lm-sensors] [PATCH 2.6.16-mm1 1/3] rtc: m41t00 driver should
Message-Id: <20060327190358.742eafb3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324011846.GC9560@mag.az.mvista.com>
In-Reply-To: <20060324011846.GC9560@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Mark,

> The m41t00 i2c/rtc driver currently uses a tasklet to schedule interrupt-level
> writes to the rtc.  This patch causes the driver to use a workqueue instead.
> (...)
>  int
>  m41t00_set_rtc_time(ulong nowtime)
>  {
>  	new_time = nowtime;
>  
>  	if (in_interrupt())
> -		tasklet_schedule(&m41t00_tasklet);
> +		schedule_work(&set_rtc_time_task);
>  	else
> -		m41t00_set_tlet((ulong)&new_time);
> +		m41t00_set((void *)&new_time);

This cast is not needed.

>  
>  	return 0;
>  }

Thanks,
-- 
Jean Delvare

