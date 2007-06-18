From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 18 Jun 2007 19:58:05 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <4676E3CD.80708@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Mark,
> 
> You're speaking as if the motherboard config file database and its
> sensors-detect integration are never going to happen. I certainly hope
> they will, and this makes your point pretty moot IMHO. Ultimately, we
> want a configuration file for every motherboard, and we want it to be
> selected automatically based on DMI information. With this in place,
> appending the ID to the chip name doesn't buy us anything.
> 

Actually my students have posted a working version of this already. What we 
really need right now is for someone to take a good look at that!

Especially at the sensors-detect modifications. I'm afraid I'm not much use 
there as I don't speak much perl.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
