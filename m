From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 09:03:54 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] libsensors4: Optimize
Message-Id: <20070722110354.2fafcfca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070716152534.1755ba05@hyperion.delvare>
In-Reply-To: <20070716152534.1755ba05@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 20 Jul 2007 07:46:24 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Thanks for the review. I've committed the patches now. I hope to have
> > time for more interface cleanups during the next week-end.
> 
> As promised, I've done some testing of the current svn with these patches 
> integrated, everything still seems to work fine.

Great, thanks.

> > My next victim will probably be sensors_get_ignored(), I see no valid
> > reason why each application has to care about ignore statements when
> > libsensors itself could hide the ignored chip features to start with.
> > I'm just not sure if the features should be skipped when the
> > application asks for the feature list, or even earlier, not inserted in
> > the feature list when walking the sysfs device directories.
> 
> Since both the config file loading and the sysfs reading happens only once, 
> there is no advantage to delaying the hiding to the moment the applications 
> asks for the feature list (If sensors.conf would/could be rescanned at that 
> moment, that would be an argument to delay the hiding).

sensors.conf _can_ be rescanned at any time. It doesn't make sense for
"sensors", but it would make sense for GUI applications. That being
said, we have a single function (sensors_init) to initialize the list of
chips, the list of features, and do the configuration file parsing, so
we still have full control on the order in which we want to do it. So
your point is completely valid nevertheless.

> Thus this then purely becomes a question of where can it be implemented the 
> cleanest, assuming that the current sensors.conf parsing code skips sections 
> for not detected chips, doing this when parsing sysfs creates a chicken and egg 
> problem, thus I think it would be best to handle the ignores when the apps asks 
> for the feature list.

I don't think we skip unused sections of sensors.conf, no. Mark, you
are more familiar with that code than I am, can you please confirm?
This would be a possible optimization, and a valuable one with the
current fat default sensors.conf file we provide. But OTOH I think we
agree that we want to take a different road in the future, with
dedicated configuration files, so I'm not sure it's worth the effort.

If we really want to do this optimization, this wouldn't really be a
chicken-and-egg problem. We can sequence the actions the following way:
* Read the list of chips from sysfs.
* Parse sensors.conf, skipping unused sections.
* For each chip, read the list of features from sysfs, skipping ignored
  ones.
This would mean reorganizing the code a bit, but nothing impossible.

Anyway, I don't really care about the performance at this point, only
about the library API. I'll move the handling of ignore statements
wherever it is easier now, so that applications no longer have to care
about this. We can always optimize later.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
