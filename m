From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 19 Jun 2007 12:27:32 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070619122732.GA27782@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Hans:

* Jean Delvare <khali@linux-fr.org> [2007-06-18 20:31:33 +0200]:
> Hi Mark,
> 
> On Sat, 16 Jun 2007 11:14:36 -0400, Mark M. Hoffman wrote:
> > Finally, back to the thread that resulted in change of maintainers, but not
> > yet any merged code. ;)
> 
> Naah, it was a _coincidence_.
> 
> > There is another way to look at it: the uguru3 is not a single chip, it is a
> > *family* of chips.  With that model, we would end up with a compromise between
> > your positions that has precedent in other drivers.
> 
> I can't really think of any precedent in other drivers.

lm85.c:

  40 I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);

(...)

1251         if (!(kind = adt7463 && (data->vid & 0x80)))
1252                 if ((err = device_create_file(&new_client->dev,
1253                                         &dev_attr_in4_input))

> > I.e. Append the motherboard ID to the chip name, and also use that to create
> > the needed sysfs files.  Voila, you don't need "label" sysfs files anymore
> > because you can put a section in sensors.conf for each variant of uguru3.
> > 
> > It's not that I'm against the label files per se.  But IMHO this suggestion
> > is the closest fit to the existing model of operation.
> 
> You're speaking as if the motherboard config file database and its
> sensors-detect integration are never going to happen. I certainly hope
> they will, and this makes your point pretty moot IMHO. Ultimately, we
> want a configuration file for every motherboard, and we want it to be
> selected automatically based on DMI information. With this in place,
> appending the ID to the chip name doesn't buy us anything.
> 
> The idea of a sensors.conf.eg file with all chip configurations in it
> comes from 1999 or so, we've all seen how broken it is nowadays (and
> this has nothing to do with the abituguru3 driver.) Designing drivers
> today based on a poor design decision taken 8 years ago doesn't sound
> particularly smart.

Look at that strawman burn!  *Nobody* here is denying that libsensors needs an
upgrade.  It'd be nice if both of you stopped bitching about it.

> So, no, I don't think that appending the ID to the device name makes
> much sense, sorry.

I withdraw the proposal: what doesn't make sense is to maintain the info in
two different places.  That would result in the worst of both worlds.

Elsewhere in this thread... I agree with Jean that pulling a new config file
for a new board will get support to people w/ new boards more quickly.  Not
all distros update as frequently as Fedora.  This would require the driver
to go ahead and create all possible sysfs files in case it didn't recognzize
the board, and let userspace sort it out.  And then it is logical to wonder:
as long as we're already doing *that*, why put any tables in the driver at
all?

Nonetheless, I'm still OK w/ Hans' approach here, because ultimately he is
going to be the one maintaining it.  And really, kernel code is not written
on stone.  If it becomes clear that this approach sucks, we'll change it.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
