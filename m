From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Sep 2006 19:15:25 +0000
Subject: [lm-sensors] issue with clearing alarms
Message-Id: <20060926211525.1c9b2f32.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450312F6.4030500@gmail.com>
In-Reply-To: <450312F6.4030500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Looking again, I see a point of confusion at least, and a possible problem.
> It may be one of interpretation, but is worth checking, and possibly 
> documenting.
> 
> The *not-yet-read* property pertains to the scan done by update_device(),
> since thats what reads all sensors the driver supports.
> But its easy to misconstrue not-yet-read as a property on the individual 
> alarms.
> 
> More importantly, any single read of any property will clear unrelated 
> alarms.

You are 100% correct. Things are as you describe, by driver design.

> So, with the usual caveats (Ive done something wrong, immature code, etc)
> I see a few possibilities:
> 
> 1 - Document the fact - tell users not to do that.
>     this isnt unreasonable, and far simpler..

The user can't do anything. The ones we need to tell are the
application authors. The end user looks at the temperatures in his nice
GUI, and doesn't decide what is read and when. At best he/she can
select the global refresh rate, and that's about it.

> 2 - sensors-deamon locks the directory to preclude loss of alarms (is 
> this possible ? bad idea ?)

Which daemon?

> 3 - dunno

4 - don't care:

What's the point in spending efforts to make sure that the application
will see the one-time alarm, while you have absolutely no way to know
if the user will see it? Unless the application keeps the alarm on
until the user clicks to confirm that he/she did see the alarm... This
doesn't sound very friendly.

All GUIs I know of do not present the alarm data at all, by the way.
Could be because libsensors doesn't make their access very friendly at
the moment... But it could also be because end users don't care - they
can simply compare the measurement to the limits, or even judge the
measurement by themselves. The alarm bits are redundant.

Furthermore, I don't expect any application to actually do selective
reads. I expect them to read all the values at once, and our drivers
will work just fine in that case. Do you know of any exiting
application that does otherwise?

In the real world, one-time alarms don't matter. I don't get why chip
designers almost all did implement alarms that way. Their main use
right now is for us to write and debug drivers.

So, as much as I agree that there is a flaw in our design, I'd say
fixing it isn't worth the effort.

-- 
Jean Delvare

