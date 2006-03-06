From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Mar 2006 10:54:49 +0000
Subject: [lm-sensors] Proposal to individual alarm/beep sysfs files
Message-Id: <xh3O2xd2.1141642489.3583940.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060305231105.97f9085a.khali@linux-fr.org>
In-Reply-To: <20060305231105.97f9085a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hans,

Now I remember that you posted a sysfs interface update proposal some
times ago, which I failed to review... I'm sorry about that, I'll try
to gove it a try this week. Whatever, thanks for joining this one
discussion.

On 2006-03-06, Hans de Goede wrote:
> > The original discussion was between per-type files versus per-channel
> > files. I think we agreed that individual files were better, allowing a
> > much cleaner implementation. Per-type files would require us to reorder
> > all bits when the chip has them in a random order (which is most often
> > the case, unfortunately). With per-channel files, we just have to
> > extract the correct bit, which is easy. We can even use the same
> > callback for all alarms, as demonstrated at the end of this post.
> > (...)
> > So my new suggestion is to have per-limit alarm files for chips which
> > implement things that way. This makes every alarm file a boolean. The
> > only drawback I can think of is that we'll end up with many more sysfs
> > files defined in each driver. However, the size increase seems to be
> > acceptable, thanks to the dynamic sysfs callbacks and the array of
> > attributes which we can use now.
> >
> >Fault conditions and beep masks can be handled exactly the same way.
>
> I still vote for having one file per type of alarm. All you need is an
> array which contains the correct masks per sensor type for the alarm reg
> and then a loop which contructs a new virtual alarm reg , by masking the
> real alarm reg with the values in the array and storing the true/false
> results linear in a new mask.

I thought that way in the first place, and actually my recently merged
f71805f driver does this. However, there are two reasons for which I no
more think this was a good idea:

1* How do you handle the case where a given channel has several possible
alarm conditions, as described above? Take a look at the lm90 driver and
LM90 or ADM1032 datasheet for a concrete example. I would welcome a
patch to the lm90 driver demonstrating how you would implement your
proposal for this driver.

2* The code doing that would probably be horrible and hard to check and
maintain. I admit I did not even give it a try, as it looked too
frightening right away ;) Do you want to do it? Please propose a patch
to the w83627hf driver, implementing the alarm interface the way you
want (while still keeping the old "alarms" file in place.) We'll see
what it looks like.

> I think having a zillion files in sysfs is a bad idea, besides the
> obvious driver size this also requires a kobject per file, which is a
> refcount ed object and thus not so light.

My experiments show that the driver size really isn't a problem. I
should have posted actual numbers with my proposal, but forgot, sorry
about that. I'll provide exact figures this evening. From my memory,
for a driver with an original size of around 11 kB (all of f71805f, lm63
and lm90 fall into that category) the size increase was below 0.5 kB. As
long as we can use a single callback for all sysfs files, I don't
expect the driver size to be a problem.

Now, the memory consumption is a different issue. I don't quite know how
to evaluate the generated overhead. Can you help with this? Does lsmod
show how much total memory a driver uses? I don't think so. If we
can't measure this overhead easily, maybe we can at least evaluate it.
How large is a kobject typically? Or, even more importantly, how much
memory does every additional sysfs file consume?

> Either way we need a standard and we need it yesterday.

Absolutely...

I'll try to convert more drivers to see if there are any more different
cases which need to be taken into account. In fact, ideally I would
convert them *all* before submitting my proposal again, but I'm not
sure if I'll have the time to actually do that. Others are welcome to
propose concrete patches and actual numbers for alternative
implementations so that we can compare all proposals on a technical
ground.

Thanks,
--
Jean Delvare

