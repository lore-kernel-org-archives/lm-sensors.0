From: Jaromir Capik <jcapik@redhat.com>
Date: Fri, 26 Jul 2013 10:01:30 +0000
Subject: Re: [lm-sensors] [PATCH] Avoiding warnings when piping to sensors-detect
Message-Id: <496833531.7275762.1374832890632.JavaMail.root@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
In-Reply-To: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean.

> Hi Jaromir,
> 
> On Thu, 25 Jul 2013 12:49:51 -0400 (EDT), Jaromir Capik wrote:
> > The attached patch fixes <STDIN> handling when the user
> > input is taken from /dev/null.
> > I know this way of generating the config is undocumented
> > and therefore unsupported, but it seems people use it
> > that way as the script doesn't support running in
> > batch mode.
> > 
> > The patch was created for 3.3.4, but can be directly
> > applied on the latest sources too.
> > 
> > Please, merge the fix.
> 
> Hmm, as far as I can see this solves the same problem as this patch of
> mine I posted some months ago:
> http://marc.info/?l=lm-sensors&m5091022118747&w=2
> 
> The only reason why I did not commit it yet is that I was waiting for
> feedback, but the original requester never provided it :(
> 
> If my patch works for you and your users then I'll just apply it.

I was unable to apply your patch directly, but
I believe it must work correctly.
Having a switch is always better than piping.
However, I know about users who already built their
solution with redirection and that's why I'd like to
propose one tiny modification of your patch in order
to make it more robust for cases like that.

Please, teplace the following line:

	return <STDIN>;

with this:

	return <STDIN> || '';


This would prevent the script from printing warnings about uninitialised
value. <STDIN> acts as uninitialised value when there are no more data
on the standard input. The modified expression returns empty string instead.

Regardless of the fact, that users should not use it that way,
it's more safe/correct.

Thanks in advance.

Regards,
Jaromir.

--
Jaromir Capik
Red Hat Czech, s.r.o.
Software Engineer / BaseOS

Email: jcapik@redhat.com
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
IC: 27690016 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
