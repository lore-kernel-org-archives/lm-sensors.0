From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 06 Aug 2013 19:14:05 +0000
Subject: Re: [lm-sensors] [PATCH] support tmp112
Message-Id: <20130806191405.GA8246@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <28DAD847AEFDD344B2D3802E7670BEE116B91384@DNCE04.ent.ti.com>
In-Reply-To: <28DAD847AEFDD344B2D3802E7670BEE116B91384@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 06, 2013 at 04:47:45PM +0000, Felten, Lothar wrote:
> > Hi Lothar,
> >
> > Signed-off is still at the end :)
> That was me, I can fix that :)
> 
> >
> > Also, looks like your mailer replaced all tabs with spaces, or your editor is set to do the same.
> > checkpatch result is 'total: 5 errors, 8 warnings, 52 lines checked'
> I ran checkpatch.pl, my editor is ok but outlook is probably not a good mail program.
> I changed some settings... let's see...
> 
Same problem. In general, trying to send patches through outlook is a really bad
idea; outlook always believes to know better and screws up e-mail. Actually, if
your outgoing e-mail is through an exchange server, the exchange server may
be the culprit (same reason as with outlook - it believes that it knows better
than its users).

Best is really to send it with "git send-email". If that doesn't work, try to
send it through another mailer. Last resort might be to send it as attachment.
The latter may be neccesary if the exchange server causes the problem.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
