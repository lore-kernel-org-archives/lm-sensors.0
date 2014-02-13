From: Laszlo Papp <lpapp@kde.org>
Date: Thu, 13 Feb 2014 11:29:12 +0000
Subject: Re: [lm-sensors] [RFC PATCH] hwmon: (max6650) Convert to be a platform driver
Message-Id: <CAOMwXhNBvZcEDLdMq1PzcF5r3uoJ3grH_RGgbAf+OEEbye0KjA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392281438-31836-1-git-send-email-lpapp@kde.org>
	<20140213095817.GD32508@lee--X1>
	<20140213111530.2a2b4982@endymion.delvare>
	<CAOMwXhML8LvDCzmk1ZVT+7cARj9C3VtxERWBgOPM9vTc6qQXZQ@mail.gmail.com>
	<CAOMwXhOv-as1W69wcSno49jEXsXWZZ7odnu8og-vgnDwRTJ4sA@mail.gmail.com>
	<1392289652.29672.26.camel@chaos.site>
In-Reply-To: <1392289652.29672.26.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <jdelvare@suse.de>
Cc: Lee Jones <lee.jones@linaro.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

I will try hard to concentrate on the technical and fruitful stuff in
the reply...

On Thu, Feb 13, 2014 at 11:07 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Laszlo,
>
> Le Thursday 13 February 2014 =E0 10:46 +0000, Laszlo Papp a =E9crit :
>> On Thu, Feb 13, 2014 at 10:38 AM, Laszlo Papp <lpapp@kde.org> wrote:
>> > On Thu, Feb 13, 2014 at 10:15 AM, Jean Delvare <jdelvare@suse.de> wrot=
e:
>> >> Any change to the max6650 driver should go on top of his patch series
>> >> to avoid conflicts:
>> >>
>> >> http://lists.lm-sensors.org/pipermail/lm-sensors/2014-February/041223=
.html
>> >
>> > As far as I can see, that patch set was not even tested, so how can it
>> > go in? I was told that any patch should be _runtime_ tested, too.
>> > Fwiw, I do not have time to test those personally, he would need to
>> > find someone else if that requirement really holds true.
>
> I find it _very_ funny that you dare to complain here, when you sent a
> totally untested patch no later than 2 days ago:
>
> http://lists.lm-sensors.org/pipermail/lm-sensors/2014-February/041180.html
>
> There's no way that patch can work.
>
> And, actually, Guenter's patches have been reviewed and tested by
> myself, to some degree (I don't have access to a physical MAX6650 or
> MAX6651 chip so I used an emulation, which I think was good enough given
> the nature of the changes.)

If you read the thread carefully, I did test the change several times,
but not after every minor change. I even apologized for my mistake of
not testing after every minor change. I am not sure what I could do
about it, but let me know if you have an idea.

>> > I would not really like to fix bugs appearing in that code to get my
>> > features in.
>
> I have no idea what you mean here.

The fact that the series is quite intrusive, and most of it seems to
be unnecessary for getting the features done. Hence, it can contain
bugs which I potentially need to debug in _real_ hardware environment
for hours or even days.

>> Also, since my change has been around for 2-3 months now, I would
>> really prefer not to be forced to rewrite it again from scratch.
>
> I'm sure Gunter would have preferred if you could write proper patches
> so he wouldn't have to do it himself.

This is not how an open source community works in my opinion, but see below.

> Seriously, nobody here cares about your personal preferences. You said
> you want some significant changes done to the max6650 driver, it takes
> many steps to get there, either you take them, or you can leave right
> now. If you're not going to listen to (and subsequently obey) people who
> have been working on this project for years and are well-known and
> respected by the vast majority of their peers, then bye bye.
>
>> Surely, you can wait with those, more or less, cosmetic non-runtime
>> tested changes?
>
> I see you once again failed to read (or understand) something I repeated
> many times already. One of these changes (the one moving the hwmon
> attributes from i2c device to hwmon device) is _mandatory_ to get your
> own changes accepted. Guenter did you an immense favor by writing these
> patches, so if anything you should be very grateful to him.

I submitted a change for trying to address the _real_ issue a couple
of days ago _right after_ the suggestion. You can check the times, it
was literally within a couple of hours. Then, someone submits the same
with better content. This is what I meant by not how a community
works. You can leave comments for others, and then they can increase
their expertise.

The patch set is very likely to contain bugs because it is a
significant re-factoring, whereas I focused on as minimal changes as
possible to get the feature reliably in.

Please help me to be involved, and not excluded. It will be hard for
me to feel helpful, and the inherent consequence is that my project
will not work with the kernel project which, I think, we both would
like to avoid.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
