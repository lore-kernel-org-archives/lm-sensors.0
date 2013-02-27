From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Feb 2013 09:11:37 +0000
Subject: Re: [lm-sensors] [PATCH 3/7] hwmon: (pmbus/ltc2978) Fix peak attribute inizialization and clearing
Message-Id: <20130227101137.242bf1a7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361585975-5604-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1361585975-5604-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Feb 2013 15:14:04 -0800, Guenter Roeck wrote:
> On Tue, Feb 26, 2013 at 11:07:16PM +0100, Jean Delvare wrote:
> > IMHO it would make more sense to have this grouped with the other
> > similar initializations. Or left where it was originally...
> > 
> info->pages is only known here, so I would have to use the maximum number
> of pages as loop terminator if I move it up.

Oops, you're right, sorry for missing this. I should have guessed there
was a reason.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
