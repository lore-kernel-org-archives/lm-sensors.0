From: zwane@linuxpower.ca (Zwane Mwaikambo)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <Pine.LNX.4.61.0411292044380.9763@montezuma.fsmlabs.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Mark,

On Mon, 29 Nov 2004, Mark M. Hoffman wrote:

> I.e. the way I wrote it was correct but non-optimal?  How about this?
> It compiles & runs at least, and it looks correct to me.

Yes, the datum being protected can be accessed atomically without 
spinlocks.

> +	return xchg(&algo_data->status,0);
>  }
>  
>  static int i801_transaction(struct i2c_adapter *adap, int smbcmd)
> @@ -246,11 +237,8 @@ static irqreturn_t i801_isr(int irq, voi
>  	if (likely(status & I801_HST_STS_MASK_NORM)) {
>  		struct i2c_adapter *adap = dev_id;
>  		struct i2c_i801_algo_data *algo_data = adap->algo_data;
> -		unsigned long flags;
>  
> -		spin_lock_irqsave(&algo_data->lock, flags);
>  		algo_data->status = status;
> -		spin_unlock_irqrestore(&algo_data->lock, flags);
>  		wake_up_interruptible(&algo_data->waitq);

This needs to be done atomically via xchg too.

Thanks,
	Zwane
