From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 04 Aug 2005 22:03:36 +0000
Subject: [lm-sensors] Re: [patch] pc87360 de-macro and code shrink
Message-Id: <20050804220312.101afb38.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E87A0F.8060709@divsol.com>
In-Reply-To: <42E87A0F.8060709@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> > just to follow up,  rc4-mm1 has
> > 
> > struct sensor_device_attribute{
> >         struct device_attribute dev_attr;
> >         int index;
> > };
> > struct sensor_device_attribute_2 {
> >         struct device_attribute dev_attr;
> >         u8 index;
> >         u8 nr;
> > };
> 
> I never noticed that, looks like it originated in this patch:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/013104.html.
> 
> Is sensor_device_attribute_2 useful to enough drivers (>1) to justify
> putting it in hwmon-sysfs? Otherwise maybe its better off just being
> defined by that driver itself...

It is virtually useful to any hardware monitoring driver having several
limits for one kind of sensors, and several sensors that kind. For
example, if you have a device having:

in0_input in0_min in0_max
in1_input in1_min in1_max
in2_input in2_min in2_max
in3_input in3_min in3_max

then you can easily use a two-dimension array to store the register
values, and use nr=0 for input, nr=1 for min and nr=2 for max.

You could argue that this can also be done using one single index and
some arithmetics. That's true, and we might end up doing that, however
it might make the drivers' code less clear. At any rate, this structure
doesn't cost anything to drivers not using it, so I have no problem with
it being in a common header. Let's see if people converting drivers want
to use it. I think we need so some more drivers converted (if possible
by different persons) before we can decide which structure is the best -
if it happens that one single structure can fulfill every drivers'
needs.

> > Ive used the 1st sda in my latest patch-set, are these structs
> > 'stable' ?
>
> Is anything stable in the kernel? I don't expect it to disappear
> anytime soon though.

And if it does, it'll be replaced by something else, and the person
doing that will have to convert all the structure users.

> > .index is still there, with more room than is useful for
> > file-entries in a sysfs dir-node.
> > Any reason not to shorten the index, to 'reserve' another short ?
> 
> Hmm..that's an interesting proposition, what is the limit for the
> number of sysfs attributes in a directory? It certainly doesn't make
> any sense to use an int if a short will suffice for even the maximum.

Agreed, I had that in mind when the structure was introduced. I was just
(and am still) waiting to see more drivers converted before the
structures are changed to fit the needs better.

-- 
Jean Delvare
