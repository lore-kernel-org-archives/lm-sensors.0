From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 17 May 2010 07:46:21 +0000
Subject: Re: [lm-sensors] Simple fan question
Message-Id: <20100517074621.GA14520@ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272518506.24542.163.camel@pasglop>
 <20100429105740.6e3b7716@hyperion.delvare>
 <1272581806.24542.185.camel@pasglop>
In-Reply-To: <1272581806.24542.185.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi!

> Right.
> 
> Now, maybe the best option is to have instead:
> 
> 	fan[1-*]_discrete_value
> 		Discrete value
>                 RW
> 
> 	fan[1-*]_supported values
>                 List of supported discrete values
>                 RO

Hmm, for 100 different values, that will get ugly. What about simple
fan_max file with values 0..fan_max being valid?

IIRC thinkpads have 8-or-so possible discrete cases...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
