From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Jun 2016 03:15:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) use proper type for update_interval
Message-Id: <20160608031517.GA8195@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1465112143-15337-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1465112143-15337-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 05, 2016 at 09:35:43AM +0200, Wolfram Sang wrote:
> The code handles this variable always as unsigned, so adapt the type.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
