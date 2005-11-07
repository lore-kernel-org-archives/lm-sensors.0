From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 07 Nov 2005 10:37:15 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <7ZUUre65.1131355442.3087250.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Roger,

On 2005-11-06, Roger Lucas wrote:
> One question I have is regarding the "1 mV" calibration, and this returns
> me to a general comment/question with the LM-Sensors system:
>
> The LM-Sensors system appears to be based on what the sensors chips are
> on the motherboard, rather than what the motherboard is.  From the "probe
> and find out what I have" concept, this is reasonable, but it does cause
> a LOT of problems for users who are less educated.  Many of the sensors
> devices are wired up in different ways on different motherboards, with
> (for example) a voltage input being used for a 12v rail monitor on one
> motherboard and a 5v rail monitor on another. The motherboard
> manufacturer is completely at liberty to wire a device in any way
> they choose.

Completely true.

> This therefore makes a sensors.conf file really a motherboard-specific
> rather than a device specific file.  If you use the configuration file
> according to the device that you have, rather than the motherboard that
> you have, then you run a very high risk of reporting nonsense to a user,
> or (arguably worse) reporting information that looks correct but is
> actually wrong.

True again.

Keep in mind that the folks originally running the project were
passionates with good electronics knowledge. Back then, most users also
had the same profile. This explains a number of technical choices which
turned out not to be suitable for average users. In a way, the project
is the victim of its own success. It is also victim of the increase of
the number of hardware monitoring chips and the exponential growth of
the number of motherboard, each with its own specifics.

We're trying to fix these issues as time permits (e.g. the drivers do no
more set arbitrary limits, and they tend not to reset chips anymore) but
there's still a lot left to do.

> Following this through, when you request that the driver report the
> voltage detected in mV, I am _hoping_ that you are asking for the
> voltage at the pin of the device, rather than the voltage that the
> device happens to be ultimately connected to on this particular
> motherboard?  Reporting the voltage at the device pin is the only
> consistent behaviour that I can see for a motherboard-independent device
> driver.

Yes, of course. Drivers are written for chips. All the rest belongs to
userspace (libsensors or whatever).

> If the above makes sense, then would there be any interest in building
> some kind of database of known good sensors.conf files for specific
> motherboards?

There have been 472 people complaining of the lack of such a database
already. A dozen of these said they would build one. Two of these
actually did. One is already dead, one is available at
http://lm-sensors-db.berlios.de/ but doesn't actually work.

We rejected the idea that we would include the configuration files one by
one in the lm_sensors project as people send them, because it would be
too much work. An external, web-based system where people could post and
retrieve their configuration files would be prefered. But we are still
in need of one which would work.

It might be discussed what to do with the sensors.conf.eg file. It
started as a small file when there were only a couple supported chips,
and motherboard manufacturers were following the chip maker's
recommendations on wiring. Now the file is quite large, and has lots of
conditionals (expressed as comments) to try and help users to get a
working configuration file. according to their hardware. I agree that it
isn't suitable for the average user.

Maybe we should stop installing this file to /etc/sensors.conf
automatically. As you say, It's probably better not to have a
configuration file than to have a bad one. However, this still a good
base for people to start tinkering, so we probably can't get rid of it
unless we actually have a database with configuration files for the most
popular boards.

> I would suggest that the output of "LSHW" or a similar utility is used
> to obtain unique identifying details for the motherboard, and then this
> used to determine the appropriate motherboard conf file.  A simple web
> page with known motherboards on it and their associated .conf would be a
> very good start.  New motherboards could then be added by people with
> their matching .conf file.

We would probably use the DMI fields for board identification (using
dmidecode, which is more standard than lshw I think). However, the
difficult part is to gather the data. What you call "a simple web
page" won't work. We want something the average user can freely
contribute to, with a minimum maintenance workload from us. Briefly:

* Any user can add a configuration file. He/she must pick from a list of
motherboard makers, or add one if his/her aint in the list. Then he/she
types the name of his/her motherboard and uploads his file. Ideally we
would do a brief content check to make sure nobody uploads crap.

* Any user can update (overwrite) a configuration file. We probably need
to backup older files just in case though.

* We need an administration interface to fix about anything (manufacturer
or board name, broken configuration statements) and even delete files if
needed.

* Users should have the possibility to alert us if they think something
is wrong.

* Not sure how to deal with duplicates. We probably want one single
configuration file per board, but it might be hard to enforce.

Note that there still is a problem with the fact that not all users of
the same board will use the same fans, so fan limits (and, to some
extent, temperature limits) depend on the user. The configuration files
are still templates. If we want to ultimately install them
automatically, we will probably need to enforce the fact that
configuration files should not set limits for fans and temperatures, nor
ignore statements for fans. These configuration files should essentially
contain label and compute statements.

This ain't simple, else this would have been done already. But if you
want to work on this (preferably *after* we are done with the vt8231
port ;)) you're very welcome.

--
Jean Delvare
