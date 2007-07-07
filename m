From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 07 Jul 2007 07:26:42 +0000
Subject: Re: [lm-sensors] ADT7475
Message-Id: <468F4032.10006@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902193444.a259efdb.khali@linux-fr.org>
In-Reply-To: <20060902193444.a259efdb.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Joel McKee Cooper wrote:
> Greetings!
> 
> I've got this chip on my ASUS M2N-SLI motherboard and am willing to
> hack on the code a bit.  Any thoughts/decisions as to whether it
> should be it's own driver or added into the lm85?
> 

That would depend on how similar it is, if it can easily (without klutering up 
the driver) can be added to lm85, then thats a good idea,\. If it would become 
a bit messy a new driver might be a better idea.

Notice that a driver for the ADT7470 was just posted the list, maybe it would 
be better / easier to add ADT7475 support there?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
