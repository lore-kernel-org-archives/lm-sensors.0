From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Jul 2013 12:58:38 +0000
Subject: Re: [lm-sensors] [PATCH] Avoiding warnings when piping to sensors-detect
Message-Id: <20130726145838.261d4096@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
In-Reply-To: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jaromir,

On Fri, 26 Jul 2013 06:01:30 -0400 (EDT), Jaromir Capik wrote:
> > Hmm, as far as I can see this solves the same problem as this patch of
> > mine I posted some months ago:
> > http://marc.info/?l=lm-sensors&m5091022118747&w=2
> > 
> > The only reason why I did not commit it yet is that I was waiting for
> > feedback, but the original requester never provided it :(
> > 
> > If my patch works for you and your users then I'll just apply it.
> 
> I was unable to apply your patch directly, but
> I believe it must work correctly.

Maybe the list archive corrupted it. I have made it available at:
http://khali.linux-fr.org/devel/lm-sensors/sensors-detect-implement-auto-mode.patch

> Having a switch is always better than piping.
> However, I know about users who already built their
> solution with redirection and that's why I'd like to
> propose one tiny modification of your patch in order
> to make it more robust for cases like that.
> 
> Please, teplace the following line:
> 
> 	return <STDIN>;
> 
> with this:
> 
> 	return <STDIN> || '';
> 
> 
> This would prevent the script from printing warnings about uninitialised
> value. <STDIN> acts as uninitialised value when there are no more data
> on the standard input. The modified expression returns empty string instead.

Yes, I understand that. However I'm not sure we want to encourage
people to use this. --auto has the advantage that we could decide to
change the behavior based on feedback, maybe adding different
sub-options for different use cases or diverging from the interactive
defaults. OTOH piping is out of our control and will just use the
default answer to all interactive questions.

But I do agree that the warnings are ugly and should be avoided in all
cases. My proposal would be to first detect when <STDIN> can't be read
(eof(STDIN) should do) and bail out with an error message pointing the
user to the new --auto parameter.

Would it be OK with you? Or do you prefer that we keep supporting the
old way, even if it was never documented? If so, we could still print a
warning but go on, and remove support for piping in a couple years,
when everyone have updated their scripts.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
