From: Jaromir Capik <jcapik@redhat.com>
Date: Fri, 26 Jul 2013 14:31:02 +0000
Subject: Re: [lm-sensors] [PATCH] Avoiding warnings when piping to sensors-detect
Message-Id: <375932844.7422415.1374849062126.JavaMail.root@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
In-Reply-To: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jaromir,

Hi Jean

> > Please, teplace the following line:
> > 
> > 	return <STDIN>;
> > 
> > with this:
> > 
> > 	return <STDIN> || '';
> > 
> > 
> > This would prevent the script from printing warnings about uninitialised
> > value. <STDIN> acts as uninitialised value when there are no more data
> > on the standard input. The modified expression returns empty string
> > instead.
> 
> Yes, I understand that. However I'm not sure we want to encourage
> people to use this.

> But I do agree that the warnings are ugly and should be avoided in all
> cases. My proposal would be to first detect when <STDIN> can't be read
> (eof(STDIN) should do) and bail out with an error message pointing the
> user to the new --auto parameter.
> 
> Would it be OK with you? Or do you prefer that we keep supporting the
> old way, even if it was never documented? If so, we could still print a
> warning but go on, and remove support for piping in a couple years,
> when everyone have updated their scripts.

I prefer to keep support for the old way -AND- write a message instructing
users to use the --auto switch instead. The message should be displayed
at the bottom of the listing. Such way is the least invasive one.
We'll not break the current solutions running with redirection while
encouraging users to use the new way. Preventing users from using /dev/null
as the input source would cause unwanted regressions in their current
solutions and we don't want to make them angry, right? :]

Please, let me know about your decision.

Thank you.

Regards,
Jaromir.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
