From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Oct 2005 23:07:42 +0000
Subject: [lm-sensors]
Message-Id: <20051027230835.16d4c80c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mauro,

> From V4L side of view it would be better if we wait until 2.6.17 for
> the newer I2C core, since, our goal to 2.6.15 is to include, with
> experimental status, several newer boards like: em28xx based USB boards
> (already on V4L tree), WinTV PVR USB2, ivtv and maybe usbvision. 2.6.16
> should be reserved for bug fixing these devices and cleaning up USB
> stuff.

You may decide that there will be no new v4l driver in 2.6.16, the
choice is up to you, but you can't force other maintainers to stop any
non-bugfix change for 6 or 8 week.

And there is nothing like "the newer I2C core". There are continuous
changes happening.

> IMHO, it is not a good idea to change I2C interface during the
> merging stuff (since lots of efforts should be made to fix
> incompatibitilies and having them all using almost the same
> CodingStyle).

You know, i2c changes don't only affect media/video drivers. They also
affect i2c bus drivers, including framebuffer I2C/DDC support, almost
all hardware monitoring drivers, and a number of platform-specific
drivers. I can't wait for all these areas to stop their development
before I submit a change to the i2c core.

I don't see how "lots of efforts" would be needed to deal with this.
Almost all changes will trigger a warning or compilation error if a
given driver wasn't updated accordingly, so we'll notice soon enough.
And most fixes after that are one-liners. It is also well known that
you have to pay particular attention to new drivers because they might
slip through mass changes. This ain't specific to the media/video
drivers, nor to i2c.

> We have to take care with this... otherwise some patches will break the
> other's patches.

This happens all the time, and there's nothing to be afraid of. Broken
patches can be fixed. If this is a problem for you, I suspect you are
not using the adequate tools.

(Subliminal hint: quilt rocks.)

Thanks,
-- 
Jean Delvare
