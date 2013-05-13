From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 13 May 2013 15:08:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fix error return code in abituguru_probe()
Message-Id: <20130513150818.GB4795@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPgLHd87mUGwSfX31YLLkL-+72AcrW6szwZiqbfqRZvfvFHBDA@mail.gmail.com>
In-Reply-To: <CAPgLHd87mUGwSfX31YLLkL-+72AcrW6szwZiqbfqRZvfvFHBDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: hdegoede@redhat.com, khali@linux-fr.org, yongjun_wei@trendmicro.com.cn, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, May 13, 2013 at 02:01:43PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
