From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Jun 2007 07:59:40 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070619095940.19895ddc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sat, 16 Jun 2007 21:50:20 +0200, Hans de Goede wrote:
> Mark M. Hoffman wrote:
> > There is another way to look at it: the uguru3 is not a single chip, it is a
> > *family* of chips.  With that model, we would end up with a compromise between
> > your positions that has precedent in other drivers.
> > 
> > I.e. Append the motherboard ID to the chip name, and also use that to create
> > the needed sysfs files.  Voila, you don't need "label" sysfs files anymore
> > because you can put a section in sensors.conf for each variant of uguru3.
> > 
> > It's not that I'm against the label files per se.  But IMHO this suggestion
> > is the closest fit to the existing model of operation.
> 
> I could do that, actually making the ID available in some way to userspace is a 
> good idea, however I'm still in favor of the fooX_label approach because:
> 
> 1) The driver will need the table it currently has no matter what, to determine
>     which inputs the model / this specific member of the family has, and at
>     which addresses these inputs reside and what type they have.

Agreed to some extent, but see below.

>     Since the table is already there, I might as well at the labels there and
>     have all info in a single place = less maintainance / no sync problems

Not agreed. A few posts before in this thread, you were writing: "its
not like Abit does a new motherboard every month", to explain that it
wasn't a problem that adding support required patching the kernel. And
now you explain that putting everything in the kernel (rather than
having a part in user-space) is better for exactly the opposite reason.
That's not fair.

Quite frankly, once the user has gone through the pain of upgrading
his/her kernel, I doubt that changing a user-space configuration file
will frighten him/her much.

> 2) With dyn chip support in place (soon hopefully) a newer kernel with support
>     for new motherboards added to the table, will just work without requiring
>     userspace updates. When the labels are in sensors.conf userspace will need
>     updating too, and if sensors.conf has been edited, it will require manual
>     intervention / editing  even.
> 
>     More in general if other drivers, for example CPU / chipset internal
>     sensor temp drivers get added, they can have foo#_label sysfs entries too,
>     and the new dyn chip support libsensors will do the right thing.
> 
>     Atleast Fedora, and probably other distro's update the kernel way more often
>     then userspace tools.

Even if the labels and scaling are done in user-space, the user-space
tools will not need to be upgraded to support a new motherboard! All
that will be needed is a configuration file for that new motherboard -
as is the case for every other motherboard out there. In the future,
this will be automated, but even today, downloading a configuration file
from the lm-sensors.org wiki is a trivial task (again, especially
compared to patching and recompiling your kernel.)

So I just can't see any major problem with having the labels and
scaling in configuration files. As far as I can see, these
configurations file could even be generated automatically from
abit's .ini file, so the maintenance burden would be next to zero.

> If the above solution is what it takes to gets the driver integrated, then 
> maybe I can agree, 

Mark's proposal (append ID to device name) isn't needed if we have
everything in the driver, and it's not needed if we have a part in the
driver and the rest in user-space. So it's not going to help us decide
ourselves either way.

>                     but I see big pain (mainly for me) in having to maintain the 
> needed table partly in the driver and partly in sensors.conf, since the driver 
> will need a table anyways, why not put all the info in one place?

First of all, the current version of libsensors doesn't support
driver-provided labels yet. So your proposal implies that we implement
this first, otherwise your driver will not work properly.

One reason (not to put everything in the driver) is to keep the driver
small. Currently, the description table in your abituguru3 driver
accounts for more than 55% of the total driver size [2]. Most of the
size is for the labels and scaling factors as far as I can see.

Also, sysfs files have a cost. I find it funny that you were arguing
against individual alarm files a few months ago because you didn't want
too many sysfs files to be created, and now you want to create a label
file for every input.

Lastly, note that users will need a configuration file anyway, if they
want to set limits, or ignore some input, or change labels because the
driver-provided ones don't please them.

> I've feeling we're arguing about 2 different things at once here, so here is a 
> try to split them:
> 
> 1) do we want foo#_label sysfs entries for devices were we can give a sensible
>     label to userspace, like cpu temp drivers

Note that my original intention with foo#_label sysfs entries was
slightly different. My plan was to use them only when the driver can
give a sensible label _and_ user-space can't. In the case of the k8temp
driver, for example, we decided _not_ to create label files, because
these labels would have been always the same, so user-space can do it
just as well.

The use case I had in mind was the IT8716F chip, where two of the input
voltage channels can be routed to either regular Vin pins, or to the
chip's own power supply pins. In the latter case, the driver knows the
labels, but user-space doesn't. Right now the information is printed in
the logs, but I thought that label files (with libsensors support)
would make it more convenient for the users. But I'm not even sure any
longer, after all we still need a configuration file for each
motherboard anyway, so we could just pick such extra information from
the logs when we write the configuration file.

> 2) if we agree that we want / will allow 1), is it ok for the uguru3 driver to
>     generate foo#_label sysfs entries using the contents of an uguru3 register
>     which addresses a lookup table with the actual info.

At this point I decided to take a look at the actual data table in your
driver. I noticed the following things (please correct me if I
overlooked something):
* Ports 0 to 15, when used, are always used for voltages.
* Ports 16 to 23 are never used.
* Ports 24 to 31, when used, are always used for temperatures.
* Ports 32 to 39, when used, are always used for fans.
* Scaling factors for temperatures are always "1, 1, 0", i.e. no
  scaling.
* Scaling factors for fans are always "60, 1, 0", i.e. scaling from
  per-second to per-minute.

This means that the only valuable information in your table is:
* Which ports are in use.
* The labels.
* The scaling factors for voltages (and even then I see that the offset
  value is always 0).

If we admit that the labels and voltage scaling factors could live in
user-space as well, this leaves us with a single information for each
motherboard: the ports in use, which is basically a 40 bit field. Add
16 bits for the device ID, round up to 8 bytes due to possible alignment
constraints, multiply by the 15 motherboards supported by your driver,
this means that the whole table would fit in 120 bytes. Compare this to
the 13 kB or so that your current table is taking, that's a huge
difference.

Another advantage if a motherboard record is just a 16-bit ID and a
couple bit fields, is that these can be easily provided as module
parameters. This means that a user has an alternative to kernel
recompilation if his/her brand new Abit motherboard is not yet
supported by the abituguru3 driver in his/her kernel. I believe that
this is a significant benefit compared to the current implementation,
as far as user experience is concerned.

So, as a summary: I don't think that moving the labels and the voltage
scaling factors to user-space is a problem for maintenance, and in fact
I believe that it would make your driver more simple, and and more
user-friendly.

Now, I voluntarily put myself in a situation where I can't prevent you
from doing things the way you like. This means that you can just ignore
what I said if you think I'm wrong. And I'm not going to insist either
- it's not like I care that much. I am probably not going to ever use
your driver myself anyway, as I don't have Abit motherboards.


[1] Measured on x86_64. I compiled your driver and ran size:
$ size drivers/hwmon/abituguru3.o
   text    data     bss     dec     hex filename
  22400     414      16   22830    592e drivers/hwmon/abituguru3.o
Then I commented out all the entries but one (to prevent the compiler
from optimizing things away):
$ size drivers/hwmon/abituguru3.o
   text    data     bss     dec     hex filename
   9695     414      16   10125    278d drivers/hwmon/abituguru3.o

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
