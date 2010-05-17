From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 May 2010 08:14:07 +0000
Subject: Re: [lm-sensors] Simple fan question
Message-Id: <20100517101407.193b93f2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272518506.24542.163.camel@pasglop>
	<20100429105740.6e3b7716@hyperion.delvare>
	<1272581806.24542.185.camel@pasglop>
	<20100517074621.GA14520@ucw.cz>
In-Reply-To: <20100517074621.GA14520@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, lm-sensors@lm-sensors.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Pavel,

On Mon, 17 May 2010 09:46:21 +0200, Pavel Machek wrote:
> Hi!
> 
> > Right.
> > 
> > Now, maybe the best option is to have instead:
> > 
> > 	fan[1-*]_discrete_value
> > 		Discrete value
> >                 RW
> > 
> > 	fan[1-*]_supported values
> >                 List of supported discrete values
> >                 RO
> 
> Hmm, for 100 different values, that will get ugly. What about simple
> fan_max file with values 0..fan_max being valid?

If you have 100 different values, you can map them to the standard
0..255 range of pwm[1-*] files.

> IIRC thinkpads have 8-or-so possible discrete cases...

Correct. And even these would map nicely to the 0..255 range IMHO.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
