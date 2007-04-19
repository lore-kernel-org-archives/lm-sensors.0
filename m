From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Apr 2007 18:35:55 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <20070419203555.0f6f060a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Tue, 17 Apr 2007 16:52:27 -0400, Jeffrey J. Kosowsky wrote:
> OK. Well since now almost all lines are rewritten (or at least
> re-tabified), I am going to just include the full revised file and
> circumvent any diff issues also that way.

OK. I've reverted some reformatting though, it's important that changes
are easily visible, and changing the coding style every now and then
really doesn't help history.

> > >  	SENSORS="temp1 temp2 temp3 in0 in1 in2 in3 in4 in5 in6"
> > 
> > Not related with your patch, but this list should be extended, we have
> > chips with up to temp6 and up to in10. Same for the fan list above, I
> > think we have up to fan7.
> 
> OK. But this would also require changing sens_day.cgi, sens_week.cgi,
> summ_week.cgi.

Ah, yes, good point. Let's forget about it for now then.

> Ideally, it would be great if the scripts would look at
> /sys/class/hwmon/hwmonN/device/*input to see what the available inputs
> are and then use that to determine what to store in and later retrieve
> from the round robin database.

Ideally, these scripts should not read the values directly from sysfs
in the first place, but should go through libsensors (using a binary
helper, ideally "sensors"), so that all the user configuration
in /etc/sensors.conf is honored. And libsensors would indeed scan sysfs
for usable sensor inputs automatically. But this goes far beyond just
fixing a few scripts - what we're talking about here is a complete
redesign and rewrite.

> NOTE: you may also need/want to update the copyright portion but I am
> not sure what the right way to do it is...

Well that's really up to you, you're the one working on updating this
script.

> -RRDPATH=/usr/local/rrdtool/bin
> +RRDPATH=/usr/bin

While I agree that the original value didn't make much sense, shouldn't
we simply rely on the $PATH to find the rrdtool binary instead of
hard-coding a directory? Also, this change should be reflected in the
Makefile and README files, and in the sens_create_rrd script, otherwise
it is inconsistent.

>  > I've made a complete review of the chip statement section, hopefully
>  > it's better now:
>  > http://lm-sensors.org/changeset/4370
> 
> One more thing. Perhaps this is covered in your updated manpages, but
> in the ones I have, I could not find any reference to
> /sys/class/hwmon/. Had I known about this, it probably would have
> saved much of this thread since the whole problem I had initially was
> due to the non-fixed numbering of the sensors in the
> /sys/bus/i2c/devices tree. So, if this is not currently in the
> manpages, it may be helpful to add.

/sys/class/hwmon is indeed not mentioned anywhere in the manual pages.
But /sys/bus/i2c/devices is not mentioned either, so how did you get
there? It looks to me like the primary cause of your problem is that
the code itself was outdated. Now that you fixed that, it should be
fine.

These sysfs interfaces should normally always be accessed through
libsensors and not directly, so I don't think we really want to
document them in manual pages, other than, maybe, the FILES section of
libsensors.3 (which doesn't exist yet.)

> Finally, I wonder whether long term, it pays to revisit some of the
> programs in the prog branch to see if they are still needed and
> relevant. Some seem to be hidden and underutilized jewels while others
> may be redundant or even obsolete (like grab_busses.sh). For example,
> it seems to me that the sens_update.rrd approach has a lot of overlap
> with the rrd functionality embedded in sensord (which can even be used
> to generate cgi files). I continue to use the cgi scripts in the rrd
> directory since I like them better but it might be a good idea to
> think of unifying them in the future. Again, I am just a newbie here
> so I may be missing something...

You are right, some of the programs are unmaintained and outdated. And
possibly some are redundant. We might improve the situation by dropping
or merging some of the tools, although in this case, both sensord and
sens_update_rrd are unmaintained anyway. But I tend to believe that
programs which are heavily used (such as sensors or fancontrol) get
updated rather quickly. Programs which aren't updated, are probably not
very much used. This is how the open-source model works: evolution.

The key issue here is that maintaining programs takes time, and this is
a scarce resource. Nobody seems to be interested in doing this. If you
want to help with that, you're welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
