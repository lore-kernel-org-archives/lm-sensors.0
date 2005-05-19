From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: New chip driver development plan to Lm_sensors
Message-Id: <20041223044444.GA5263@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
In-Reply-To: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Chunhao:

* Huang0@Winbond.com.tw <Huang0@Winbond.com.tw> [2004-12-23 09:51:24 +0800]:
> I have some questions about VRM.
> 
> I find such codes in w83781d_init_client() of w83781d.c:
> data->vrm = (type = w83791d) ? 90 : 82;
> That's to say, if the chip is w83791d, the driver w83781d fix
> the value of VRM into 90.
> In my driver of 792, I also fix the value of VRM into 90,
> Is that right?
> 
> Since I'm not very familiar with VRM, Could you give me a general
> introduction to it when you are free?

When we (lm_sensors people) talk about VRM, we are talking specifically
about the interpretation of the VID lines; i.e. the formula for converting
from 4-6 binary inputs to a voltage.  Intel has many standards for the
processor VRM, the latest of which can be found here:

	http://developer.intel.com/design/Xeon/guides/302731.htm

The vrm value for w83791d in the w83781d driver is not *fixed* to 90,
it is merely *initialized* to that.  The user is free to change this
value.  You may wonder why the user is allowed to change it at all,
when the value obviously depends on what type of processor is present.
Well, in the 2.6 kernel we made some moves in that direction: see
drivers/i2c/i2c-sensor-vid.c.

So to answer your immediate question ... from the recently posted 792
datasheet, it looks like VRM 9.0 and 10.0 are supported.  You'll
want to pick one of these as a default, but still allow the user to
choose the other one.

Wait a sec... just read the 792 datasheet a little more closely.  That
part also supports some sort of VID *outputs* as well.  That could be
downright dangerous to fool around with.  I wonder what you're planning
to do with that?  I'll have a look at your driver at some point.

Now for my own question to you: I have a w83791sd on my mainboard.
Will you publish a better datasheet for that one?  The datasheet that
is currently available on your website doesn't have enough info to
create a driver.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
