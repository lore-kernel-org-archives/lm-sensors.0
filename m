From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: libsensors for linux 2.6
Message-Id: <3FB7EBF7.B485B1FE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116144447.6ac271ca.khali@linux-fr.org>
In-Reply-To: <20031116144447.6ac271ca.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> > But I think this approach is good for now. Another hour of modifying
> > lib/chips.c and it will be done. But if you're getting ready to
> > change the standard names and/or magnitudes I better hold off...
> 
> Not sure how long it will take nor if it will be done now. I would like
> it to be decided as soon as possible bug Greg's opinion differs, it
> seems.
> 
> > Helpful hint: the more names stay the same as they were before the
> > less typing there will be (inx, inx_min, inx_max....). Unfortunately
> > pretty much everything is different now.
> 
> The simple fact that we switched to a one file per value philosophy
> makes it fundamentaly different, isn't it?
> 

But there's an entry in chips.c for each value, not just for each file.
And there is a name for each value too. This was the name presented to
the
userspace tools, not a /proc file name, so it's dangerous to
assume this is a sysfs name... but that's what I did for now, again
to minimize typing. Exceptions are added with the new sysname value.

So for sysfs we open up the file listed in the new struct entry
(sysname)
and use the first (only) value.
And we ignore the other stuff that binds entries together
to form multiple values in one file.

So maybe it's fundamentally different, maybe not. But since there's
already an entry per value,
it's pretty easy to add the sysfs file name. That would be it if only
the magnitudes
were the same as before. Since it isn't, we have to add a sysfs
magnitude.

> > The reason it's called "in_input1" instead of "in1" escapes me.
> 
> Probably in order to match the above mentioned philosophy. In1 is an
> entity, not a value. As an entity, it has several values: measurement
> (here called input) and limits. I guess that having all files named
> after a common scheme (${entity-name}_${value-name}${N} here) is of
> great value when it comes to obtaining a chipset-independant library
> and/or user-space tools interface.
> 
> That said, I would have named that file in1_input, not in_input1,
> because it makes it visualy obvious that all in1_* correspond to the
> same entity, while it isn't that obvious (to me at least) that all in_*1
> values belong to a family.
> 
> > One problem I ran into:
> >
> > For temp_xxx, sysfs_interface says divide by 1000 but actually it's
> > 100(for w83781d anyway)
> 
> I knew it. See my answer to Danny's post earlier in this thread.
> After a quick look, the it87 driver seems to be OK.
> 
> Greg, can you confirm that the retained unit it the thousandth (and not
> hundredth) of degree Celcius?
> 
> Mark, are you using a w83781d or similar chip under 2.6.0-testX? If you
> do, I would like you to confirm that the hysteresis and over
> temperatures are swapped.
> 

I'm running test8 and they don't look swapped to me.

# for i in temp*
> do
> echo $i
> cat $i
> done
temp_input1
3100
temp_input2
3750
temp_input3
0
temp_max1
12700
temp_max2
6000
temp_max3
6000
temp_min1
6000
temp_min2
5000
temp_min3
5000
