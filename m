From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 10 Mar 2006 13:15:26 +0000
Subject: [lm-sensors] Proposal to individual alarm/beep sysfs files
Message-Id: <20060310141526.e10410da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060305231105.97f9085a.khali@linux-fr.org>
In-Reply-To: <20060305231105.97f9085a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> > +Old drivers provided a different, non-standard interface to alarms and
> > +beeps. These interface files are deprecated, but will be kept around
> > +for compatibility reasons:
> >  
> >  alarms		Alarm bitmask.
> >  		Read only.
> 
> Why deprecate these?  It is easy enough to leave the few extra files
> there.  Then, if some embedded app really needs that last 1-2k, they
> can chop out (by way of CONFIG_ option) all of the individual alarm
> files and save the space.  At any rate, it is useful to 'cat .../alarms'
> at a glance to see if it's nonzero.  Not every user needs the full
> sensors(1) & libsensors.

By "deprecate" I meant that I don't expect new drivers to provide that
file. For all the drivers which already exists, it's pretty clear to me
that we won't drop the "alarms" file, it's been around for so long now,
and none of us is willing to update support for all chips in
libsensors anyway. Maybe in a very long time, when everyone is using
2.6.17+ kernels and the future version of libsensors (which will only
rely on standard interface files), we'll offer a configuration option
to strip these non-standard files out of the drivers - but the
corresponding source code is likely to stay in there forever.

You seem to want new drivers to still include this chip-dependant
alarms file. I don't think it's that useful even for embedded designs.
You might always have some alarm stuck for an input you don't use, so a
non-zero "alarms" value might not be a problem. Then for valid alarms,
what to do depends on which alarm triggered, so further investigation
will be needed anyway. Thus Hans' reordered alarm files have much more
value here.

Now, if enough people ask for the alarms file to be back in new
drivers, why not. As you said, it's easy enough. But I'd prefer to see
if anyone actually asks for that feature before doing so.

Thanks,
-- 
Jean Delvare

