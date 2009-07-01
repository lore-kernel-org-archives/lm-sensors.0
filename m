From: "George Spelvin" <linux@horizon.com>
Date: Wed, 01 Jul 2009 07:03:59 +0000
Subject: Re: [lm-sensors] How to un-ignore a sensor?
Message-Id: <20090701070359.9966.qmail@science.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090629211323.32695.qmail@science.horizon.com>
In-Reply-To: <20090629211323.32695.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> Um... okay.  Is that a universal solution?  Debian ships a larger config
>> file that does include some "ignore" lines.  It does seem useful to
>> have an overridable default.

> Which version of lm-sensors do the ship? The change occurred in version
> 3.1.0.

3.1.1.  Would you like a copy of the tarball?

>> Are there plans for some more flexible include or conditional
>> mechanism to allow segregating site-local edits?

> This was implemented in lm-sensors 3.1.0 (and fixed in 3.1.1 for some
> filesystems.)

Is that the "/etc/sensors.d" thing?  I suppose if you moved *all* of the
ignore statements into there and had some sort of symlink thing.

What I was thinking was more a way to supply a board name, which would
reference a chip config file, that would include a base chip configuration
and customize it.

Many people could just specify a board name.  Or add a new alias for an
existing chip config file.  Only a few would have to customize a chip
config file (to reflect the creative new way the mobo has wired up the
super-I/O chip), and creating a new one would be quite rare.

>> Okay, I'll poke at it if I'm motivated, but remember your priorities.
>> It seems that there are a lot of duplicated strings ("temp3_max"), so
>> if the overhead can be can be made small enough, interning them would
>> save memory.

> I fear I don't quite follow you here. Which strings are duplicated
> exactly, and what do you mean by "interning"?

A lot of the sensor names are duplicated a lot in different chipsets.
I used "temp3_max" as an example, although "in1" is another one.

"interning" is to build a single global reference-counted string table so
all copies of a given string point to a single copy.  (This is *separate*
from the possibility of per-chip hash tables.)  This has the useful
property that later string compare reduces to a pointer compare.

As long as the number of copies of each string is large enough (say,
an average of two) that eliminating the duplicate copies saves more
space than the hash table plus reference counts add, it's a net space
savings.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
