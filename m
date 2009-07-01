From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Jul 2009 17:02:44 +0000
Subject: Re: [lm-sensors] How to un-ignore a sensor?
Message-Id: <20090701190244.073c9961@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090629211323.32695.qmail@science.horizon.com>
In-Reply-To: <20090629211323.32695.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George,

On 1 Jul 2009 03:03:59 -0400, George Spelvin wrote:
> >> Um... okay.  Is that a universal solution?  Debian ships a larger config
> >> file that does include some "ignore" lines.  It does seem useful to
> >> have an overridable default.
> 
> > Which version of lm-sensors do the ship? The change occurred in version
> > 3.1.0.
> 
> 3.1.1.  Would you like a copy of the tarball?

Tarball of what?

The default configuration file which comes with lm-sensors 3.1.1 is:
http://www.lm-sensors.org/browser/lm-sensors/tags/V3-1-1/etc/sensors.conf.default

See for yourself, this file doesn't contain any "ignore" statement. If
Debian ships something different, there's nothing I can do about it, go
tell them they should not.

> >> Are there plans for some more flexible include or conditional
> >> mechanism to allow segregating site-local edits?
> 
> > This was implemented in lm-sensors 3.1.0 (and fixed in 3.1.1 for some
> > filesystems.)
> 
> Is that the "/etc/sensors.d" thing?

Yes it is. Put all your local configuration changes there and you're
done. This of course assumes that the default configuration file
contains no non-overridable statements (and in particular no ignore
statement - which is why removed them all.)

>                                      I suppose if you moved *all* of the
> ignore statements into there and had some sort of symlink thing.

I have no clue what you're talking about.

> What I was thinking was more a way to supply a board name, which would
> reference a chip config file, that would include a base chip configuration
> and customize it.
> 
> Many people could just specify a board name.  Or add a new alias for an
> existing chip config file.

We have long term plans for that, but the idea would be to implement
it outside of the library, rather than inside it. A configuration
tool would identify the board, search for a known configuration file,
and if one is found, copy it to /etc/sensors.d.

Moving the board identification into libsensors would require a lot
more changes as far as I can see. For example, it would require that we
extend the configuration file language with more directives, so that
the user can override the library's decision. Maybe you want to modify
the file configuration parser... me, this is the last part of
libsensors I like to touch ;)

> Only a few would have to customize a chip
> config file (to reflect the creative new way the mobo has wired up the
> super-I/O chip), and creating a new one would be quite rare.

You live in a fantasy world ;) Out of the several thousand PC mainboards
out there, we have configuration files for 100, top. And no two
mainboards out there have the exact same configuration. With the amount
of configuration files we have today, most users would still have to
manually configure their chip, and only a few lucky ones would have a
working system out of the box.

Of course, over time we can have the hope that the database of good
configuration file grows and the balance shifts. But this will take
time _and_ a good infrastructure for users to contribute, which we do
not have yet.

> >> Okay, I'll poke at it if I'm motivated, but remember your priorities.
> >> It seems that there are a lot of duplicated strings ("temp3_max"), so
> >> if the overhead can be can be made small enough, interning them would
> >> save memory.
> >
> > I fear I don't quite follow you here. Which strings are duplicated
> > exactly, and what do you mean by "interning"?
> 
> A lot of the sensor names are duplicated a lot in different chipsets.
> I used "temp3_max" as an example, although "in1" is another one.
> 
> "interning" is to build a single global reference-counted string table so
> all copies of a given string point to a single copy.  (This is *separate*
> from the possibility of per-chip hash tables.)  This has the useful
> property that later string compare reduces to a pointer compare.
> 
> As long as the number of copies of each string is large enough (say,
> an average of two) that eliminating the duplicate copies saves more
> space than the hash table plus reference counts add, it's a net space
> savings.

Ah, OK, I see what you mean now. I can't remember seeing an
implementation of this. I understand this makes sense sense when
handling a large amount of data you _need_ to keep. When it comes to
libsensors, I'm not sure it applies. For one thing, we do not have that
much data. Running "sensors" through valgrind with different
configuration files, I obtain the following memory allocation numbers:

* sensors.conf.eg:		210,007 bytes allocated
* sensors.conf.default:		175,233 bytes allocated
* custom config file:		137,553 bytes allocated
* no configuration file:	145,650 bytes allocated

This is the total amount of memory allocated, not the peak of memory
consumption, and not all is for the configuration file handling, but
this still shows that out of the ~73 kB of memory that used to be
allocated for the previous default configuration file, we have saved
almost half already (~35 kB) by switching to a smaller default
configuration file. There's only ~38 kB left to win. That's not much,
and honestly, if you care that much about memory, you probably want to
delete the default configuration file right away, and only use a custom
one. So, generally speaking, I don't think there's much point in
optimizing libsensors to better handle large configuration files,
because we do not want to have large configuration files anyway, for
performance reasons.

Anyway, if you want to look into reducing the amount of memory used by
libsensors, or make it faster, you're very welcome. But you'll have to
prove the benefit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
