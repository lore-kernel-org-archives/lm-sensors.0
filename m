From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Feb 2009 08:16:27 +0000
Subject: Re: [lm-sensors] Chassis intrusion detection
Message-Id: <20090217091627.7e5ec8ef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f188924b0901240908g1fde798fsfaba824938e9dc03@mail.gmail.com>
In-Reply-To: <f188924b0901240908g1fde798fsfaba824938e9dc03@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

On Tue, 17 Feb 2009 02:29:04 +0100, Fred . wrote:
> On Mon, Feb 16, 2009 at 10:39 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi Fred,
> >
> > On Sun, 15 Feb 2009 14:19:37 +0100, Fred . wrote:
> >> Why does 'libsensors' not have support support for chassis intrusion?
> >
> > Because libsensors builds on top of a standardized sysfs interface, and
> > said interface doesn't include chassis intrusion at the moment. So the
> > first step would be to define such a standard interface at sysfs level,
> > then make sure all drivers implement it properly, and only then it
> > will be possible to add support in libsensors.
> Okay, could you tell the sysfs guys to define a standard interface the
> sysfs level, or cooperate with them on that or something, I don't know
> how to talk to them.

There is no such thing as "the sysfs guys". We (the lm-sensors group)
take care of everything, from sysfs interface definition to kernel
driver code to library code down to "sensors".

> > The f71882fg driver doesn't support chassis intrusion detection at the
> > moment (although the chip can do it, if wired properly, as you found
> > out yourself already.)
> When will it support that?
> The PDF datasheet should include the necessary information needed for
> implementing that.
> Source: http://www.fintek.com.tw/files/productfiles/F71882_V028P.pdf

When the driver author (Hans, Cc'd) decides to add this feature. Which
is unlikely to happen before it is standardized.

> >> The 'sensors' tool is supposed to mention chassis intrusion. Does it
> >> always do this, or only if its supported, or only if its triggered and
> >> is in alarm mode?
> >
> > sensors 3 goes on top of libsensors 3 which doesn't support chassis
> > intrusion detection.
> But I have seen in many tickets on the lm-sensors website people who
> posted their logs,
> and they indicate a presence chassis intrusion support.
> Source: http://www.lm-sensors.org/ticket/2334
> How come?

These are reports of lm-sensors 2, when there was no standard interface
and each driver could thus implemented whatever feature they wanted.

And now let's please stop this parallel threads discussion, which is
only wasting everyone's time and adding to confusion.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
