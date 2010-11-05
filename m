From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 05 Nov 2010 16:48:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4261) Fix error message format
Message-Id: <1288975722.22931.202.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101105155929.39a5412f@endymion.delvare>
In-Reply-To: <20101105155929.39a5412f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2010-11-05 at 10:59 -0400, Jean Delvare wrote:
> adapter->id is deprecated and not set by any adapter driver, so this
> was certainly not what the author wanted to use. adapter->nr maybe,
> but as dev_err() already includes this value, as well as the client's
> address, there's no point repeating them. Better print a simple error
> message in plain English words.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
