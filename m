From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 May 2007 06:23:40 +0000
Subject: Re: [lm-sensors] Any chances to get THMC50 driver into 2.6.22?
Message-Id: <20070528082340.4fc06c4e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4649ac914ece8@wp.pl>
In-Reply-To: <4649ac914ece8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Wed, 23 May 2007 20:03:41 +0200, Krzysztof Helt wrote:
> Jean Delvare wrote:
> > For example, Rudolf Marek just posted a patch adding support for the
> > IT8726F:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019767.html
> > It should be fairly easy to review. Of course I'll end up doing it if
> > nobody picks it shortly, but it's probably a good one to get started.
> 
> I looked at the changes and I do not see anything wrong. It just additions
> of constants and if clauses extensions.  The only "trick" is that it8726
> identifies the driver as it8716 but it may be ok if they both have exactly
> the same functionality. In short words: it is only addition of the new chip
> id and nothing more.

OK, thanks for the review. Next time, please reply to the post in
question, it makes it easier for me to track how much attention a given
patch received. And Cc'ing the list (as I am doing now) is always
preferred, so that others know what's going on.

> >> B. laptop: sis630 + max1617 (adm1021? driver) + unknown ITE chip (id: ea19).
> >> I got 2 temperatures (CPU & MB) but no fan control. I suppose this ITE chip
> >> controls the fan (do you know where I can find manual for it?).
> > 
> > Are you sure it is an ITE chip? ID 0xea doesn't sound like an ITE chip
> > at all, more like National Semiconductor. The earlier versions of
> > sensors-detect might have been confusing in that respect, please check
> > again with a recent version.
> 
> I am not sure. It is detected as ITE chip as well. It may be the NS chip, though. 

Older versions of sensors-detect would list all possible manufacturers,
which was admittedly confusing. The version in SVN will only list the
correct manufacturer.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
