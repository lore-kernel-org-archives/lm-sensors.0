From: david-b@pacbell.net (david-b@pacbell.net)
Date: Tue, 12 Jul 2005 19:50:12 +0000
Subject: [lm-sensors] at24c i2c EEPROM driver
Message-Id: <20050712174847.89A9BBF3DE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111737.11097.david-b@pacbell.net>
In-Reply-To: <200507111737.11097.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Date: Tue, 12 Jul 2005 15:54:42 +0200 (CEST)
> From: "Jean Delvare" <khali@linux-fr.org>
>
> Hi David,
>
> On 2005-07-12, David Brownell wrote:
> > I ran into one too many board with an I2C EEPROM that Linux handled poorly,
> > and got a hack attack.
>
> Could you please define "handled poorly"?

In the case of the board with an AT24C1024, no kernel support at all.
(That's got 2-byte addressing.)  I wanted to put U-Boot on that, and
have some way to access the leftover space, so the NOR flash (at a
whopping 2 MBytes!) had more space available for Real Stuff.

For the AT24C04, it was misdetected as two chips (by "eeprom"), and
there was no write support.


> You are not the first one complaining about the limitations of the simple
> eeprom driver.

Those weren't exactly the words I used.  In public, anyway.  :)


>	So far we have been able to work around them, typically
> by using user-space tools to program the eeproms. The question is
> whether your case is different or not. Is eeprog not sufficient for your
> needs?
>
> http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/prog/eepromer

Interesting, it might be worth mentioning that in the Kconfig helptext
for the "eeprom" driver.  I did some googling, and that never came up.
(Mention that along with the fact that "eeprom" only handles chips of up
to about 16 Kbits, and misdetects many of those as multiple chips ... )

I've got a few applications in mind.  If I stay un-demanding, "eeprog"
could suffice -- though clearly it'd be slower.  The moment I want
other kernel drivers to use that state, it wouldn't be enough.


> If you followed the story of Ben Gardner's max6875 driver, you must
> realize that drivers for I2C devices in the 0x50-0x57 range should be
> VERY careful not to accidentally write to an innocent EEPROM. The
> I2C/SMBus protocols make it happen very easily, unfortunately.

Didn't follow that, but I'm fully aware of the issue.  That's why I
set this driver up to use only static configuration, no probing.

It's unrealistic to expect the kernel to defend against user error,
but it's highly appropriate to expect it not to misconfigure.


> If your driver is to replace the eeprom driver (you will have to convince
> me it is needed and safe), then it better replace it completely on all
> systems. Let's not duplicate such a simple functionality.

I only noted that such a thing was a possibility.  For the moment,
I've met my own goals with respect to this driver.  Anyone wanting
to take that next step now has a better tool to start with.  :)


The main thing I'd put on the agenda if anyone were were to pursue
that route would be how to provide a decent static declaration of
boards' I2C configuration, to prevent needing to probe things that
don't probe well.  Such a thing might be done as part of updating
the I2C stack for better driver model support, whenever time for
such a thing becomes available.

For example, the "platform_bus" is often prepared, in board-specific
setup code, with a platform_device for each device that's present,
plus platform_data with information needed by the driver (like what
GPIOs it uses on this board).  That'd be a useful model for this
case:  "at address N on this bus there is/may-be a B Kilobit EEPROM
to expose as read-only".

I'll follow up on your code comments in a separate email/thread;
thanks for the feedback!

- Dave

