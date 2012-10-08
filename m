From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Oct 2012 15:36:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ina2xx: use module_i2c_driver to simplify the code
Message-Id: <20121008153628.GA11734@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPgLHd99+yWL1br_FgWbj=5vnjRWoAAqe9ME6LS45aCj=Ga-Wg@mail.gmail.com>
In-Reply-To: <CAPgLHd99+yWL1br_FgWbj=5vnjRWoAAqe9ME6LS45aCj=Ga-Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: khali@linux-fr.org, yongjun_wei@trendmicro.com.cn, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Oct 08, 2012 at 08:40:35PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Use the module_i2c_driver() macro to make the code smaller
> and a bit simpler.
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
