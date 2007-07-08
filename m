From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2007 21:24:04 +0000
Subject: Re: [lm-sensors] Call for 2.10.4
Message-Id: <20070708232404.4bcdf554@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625101648.511dc9c4@hyperion.delvare>
In-Reply-To: <20070625101648.511dc9c4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good evening Hans,

On Sun, 08 Jul 2007 23:11:27 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > We've seen many commits in the last week, in particular thanks to Hans
> > de Goede, so there will be a lot of good things in this 2.10.4 release.
> > I've just committed the last patches I had pending myself, so I declare
> > the lm-sensors trunk frozen in SVN. I'll do as much testing as possible
> > next week, and I invite everyone else to do so as well.
> > (...)
> 
> I would like to request an exception to the freeze to fix / improve the example 
> configuration in sensors.conf.eg for the f71882fg, to be more precise I would 
> like to replace the 2 ignore lines for fan2 and fan3 with 2 label lines, as you 
> requested. If allowed I will do this first thing tomorrow morning.

Sure, no problem. The f71882fg support is brand new so there is no risk
of introducing a regression. And this hardly counts as an exception
anyway - this is a bug fix, so not affected by the freeze rule.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
