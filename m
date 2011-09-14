From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 14 Sep 2011 05:33:24 +0000
Subject: Re: [lm-sensors] General API and documentation discussion
Message-Id: <20110914053324.GA5769@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315948191.2018.20.camel@tellur>
In-Reply-To: <1315948191.2018.20.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 13, 2011 at 05:09:50PM -0400, Lucas Stach wrote:
> Hello all,
> 
> weeks ago I proposed a patch to introduce a new hwmon-core interface to
> have the sysfs handling centralised and getting a stable in-kernel API
> for the hwmon drivers. This should also lead to resolving the now
> unclear situation with regard to hwmon/thermal driver cooperation, but
> more to this at a later time as it's not the point here.
> 
> This old patch I proposed was kind of hacky and I didn't receive a lot
> of feedback, but I got some ideas to improve the code. I'm now in the
> process of reworking my patch to be more maintainable.
> 
I kind of recall that I wasn't sure about it ... it just "didn't look nice",
whatever that means. "kind of hacky" might be a good description.

> Along the way I noticed some mismatches between the API as presented by
> libsensors and the documentation in kernel. One example is the sysfs
> entry "fan_max" which is mentioned in the kernel documentation, but is
> not seen in the libsensors fan_matches subfeatures table. I think a
> hwmon-core with all the sysfs handling is a great place to stabilize the
> API between kernel and userspace and to do so I want to know who I
> should trust, kernel doc or libsensors code?
> 
My priorities would be

1) Documentation/hwmon/sysfs-interface
2) Code in drivers/hwmon

libsensors is just an application and not expected to implement everything,
even though it would be great if it did. But you can't argue that a system call
should go away just because glibc doesn't implement it.

If there are discrepancies, it would be good to have a table listing what
those are. sysfs-interface is not (necessarily) perfect, and there are lots
of non-standardized attributes used by various hwmon drivers. Also,
sysfs-interface is not cast in stone; just look at its history. If I catch
a non-standard attribute in a driver I am working on, and if I happen to have
some spare time, I look around and check if it is used by multiple drivers.
If it is, it may make sense to add it to the ABI, and update drivers to use
it if applicable. One example I remember is update_interval.

If an attribute is defined in sysfs-interface but not supported by libsensors,
and especially if it is supported by some drivers, I am sure Jean will be happy
to accept a patch for libsensors (if he finds the time to review it after digging
through all the patches I already sent to him ;). fanX_max is a really good
example here, since it is supported by several drivers.

Similar, if there happens to be an attribute supported by libsensors and by
some hwmon drivers which is _not_ defined in sysfs-interface, it would be useful
to know so we can address the issue (that would really be something that should
be fixed). On the other side, if there should be an attribute defined in
sysfs-interface but not implemented by any driver, it would be useful to know
to be able to decide if it should be kept or not.

In summary, again, nothing is cast in stone. First priority should be to do
what makes sense, not what is written in some specification.

> Could we please sort this out whether the kernel doc is incorrect and
> does not reflect actual interface or if sensors code needs some
> additions to reflect API exposed by the kernel? I would really like to
> help here and I'm willing to spend some time with stabilizing interface
> and documentation, but as a newcomer it is hard to make a sense out of
> all this conflicting information. I think a stable API both in and out
> of kernel is beneficial to all hwmon drivers and systems interfacing
> with them.
> 
> On a side note I could not find any API entries in libsensors for
> handling trip points which are mentioned in the kernel doc, but I think
> this is another issue as we really should handle trip point support as a
> cooperation of hwmon and a thermal driver.
> 
That is really a tricky and sensitive issue. So far the relationship is strictly
thermal -> hwmon, since hwmon by itself has a passive role. Fan handling with
its trip point settings are pretty much at the edge of things, and probably
acceptable because the actual _action_ associated with it is implemented in HW.
We have just started talking about if and how to handle interrupts, sysfs notifications,
and uevents.

One of the key question here is if the kernel should do anything besides notifying
applications. Seems to me the real action should be in userland, not in the kernel.
But then maybe I am missing some essential use cases, where the action would _have_
to be in the kernel. If so, we'll have to think really carefully about any to-be-defined
APIs.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
