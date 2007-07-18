From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Wed, 18 Jul 2007 19:27:17 +0000
Subject: Re: [lm-sensors] No longer reviewing random hwmon patches
Message-Id: <200707182127.17117.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070718201409.1c1077d0@hyperion.delvare>
In-Reply-To: <20070718201409.1c1077d0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Mittwoch 18 Juli 2007 20:14 schrieb Jean Delvare:
> Hi all,
> 
> Twice in the past 2 weeks, I have been criticized for being too
> demanding in my hwmon patch reviews. I have been told that I was
> wasting developers' time and taking the fun away from them. Well, I am
> also no longer having fun reviewing patches when I am "rewarded" this
> way. Not that reviewing patches is really fun to start with, you
> usually don't receive much thank nor praise, but receiving criticism is
> going one step too far.

I absolutely agree. And I don't think you're wasting anybodies time.
I remember when you sent me back my max6650 patch 16 times. I still
think that this was no waste of time. It is now clean code which follows
a clean concept. A waste of time would have been to merge my first
version. It would have wasted the time of an unknown number of unknown
programmers in the future, who would have to deal with bad code
and violations of the hwmon sysfs specifications.

So, as I said before, I thank you for _your_ time and that you
made it possible for me to contribute a piece of _good_ code so
_my_ time was not wasted.  

> 
> It has been suggested that I should review patches differently and
> accept more divergence from what I consider the right way. This isn't
> going to happen, sorry. Given that I am not paid for the job, nobody
> gets to tell me which patches I should review and how. But I also don't
> want to cause contributors to leave the project.

If a "contributor" wants to leave because his crappy code is rejected,
I say: Good riddance! hwmon is a subsystem where most of the people
don't have the hardware to test a driver, so bugs can stay there for
a long time. That's why I find it especially important to have strict
reviews before something gets merged.

> 
> As a consequence, I have decided to change my behavior with regards to
> the patches which are posted to the lm-sensors list. I will no longer
> review random patches. 

I understand your point of view.

> I will only review patches meeting any of the 
> following conditions:
> * I asked for that patch.
> * The patch is for a hwmon driver I am maintaining.
> * The author explicitly asked me to review his/her work, and I feel
>   like it.
> * Mark asked me to review the patch.
> 
> Hopefully this will prevent further tensions from arising.
>

Actually, I think this is a big loss for hwmon. I'd still be glad if
you reviewed my patches (there will be more soon).

Thanks,
Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
