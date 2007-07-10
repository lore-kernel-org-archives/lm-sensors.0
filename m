From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jul 2007 13:35:39 +0000
Subject: Re: [lm-sensors] Call for 2.10.4
Message-Id: <20070710153539.142bad8d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625101648.511dc9c4@hyperion.delvare>
In-Reply-To: <20070625101648.511dc9c4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 08 Jul 2007 23:27:07 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Sun, 08 Jul 2007 23:11:27 +0200, Hans de Goede wrote:
> >> I would like to request an exception to the freeze to fix / improve the example 
> >> configuration in sensors.conf.eg for the f71882fg, to be more precise I would 
> >> like to replace the 2 ignore lines for fan2 and fan3 with 2 label lines, as you 
> >> requested. If allowed I will do this first thing tomorrow morning.
> > 
> > Sure, no problem. The f71882fg support is brand new so there is no risk
> > of introducing a regression. And this hardly counts as an exception
> > anyway - this is a bug fix, so not affected by the freeze rule.
> 
> Ah so this is a no new features freeze / only (serious / non controversial) 
> bugfixes freeze, not a hard freeze?

Yes. Given that we ask people to test and report problems, a hard
freeze would not make much sense. We really want to fix the problems
that are reported to us (or that we discover ourselves during testing.)
Also, updating the documentation is always welcome.

So call it a "cold SVN" if you think that the notion of SVN freeze
doesn't apply to our permissive policy ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
