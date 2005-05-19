From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: bt869 driver
Message-Id: <20050130110713.653dd702.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050129234511.5dc19d3b.khali@linux-fr.org>
In-Reply-To: <20050129234511.5dc19d3b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gerd,

> Hmm, the drivers in drivers/media/video/ usually do video _capture_,
> although some of them also support video output using the v4l2 API.
> 
> The other video-out drivers are the framebuffer drivers in
> drivers/video/.
> 
> The BT869 seems to fit none of these categories through, seems to be
> neither a video4linux nor a framebuffer driver from the description,
> it seems to just export some config stuff via /proc.

I assume you mean the bt869 *driver*, not the BT869 chip. You're right,
it doesn't follow any standard nor fit in any video subsystem. I think
it was a hack by Philip Edelbrock to get the things up and working
quickly. Since he was used to sensor drivers, he naturally wrote the
bt869 driver in the exact same way.

> What exactly does the BT869?  Handle the TV-out of the voodoo3?

Yes, that's how I understand it.

> What is the point of that driver?

Allow people to configure the chip by writing to procfs. As I understand
it, you can change things like resolution, TV standard, video connector
and a few other things. The doc here says it all:
http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/doc/chips/bt869

> Any reason why this couldn't simply be done by the X-Server which
> drives the voodoo3?

Agreed, that's where it would belong IMHO.

> Is it somehow related to the voodoo framebuffer driver maybe?

Could be too. Wouldn't be the first time that X and a framebuffer driver
have concurrent implementations of a feature. That said, this would
require the framebuffer driver to implement the Banshee/Voodoo3 on-board
I2C bus support (just like our independent i2c-voodoo3 does). Same goes
for an hypothetical support in a X-server driver, btw.

Do we have examples of framebuffer drivers handling i2c video-out chips
already?

> At the moment I somehow miss the big picture, the driver alone looks
> pretty useless to me ...

Well it was used with i2c-voodoo3 so far, by people with Banshee/Voodoo3
boards which wanted a way to enable and somehow control the on-board
video-out chip. With neither the X driver nor the framebuffer driver
handling it, I can understand why the i2c-voodoo3 and bt869 drivers were
implemented and used.

It would probably be great to merge i2c-voodoo3 in the tdfxfb driver at
some point. If nothing else, it'd give the framebuffer driver access to
the DDC channel of the boards, which helps framebuffer configuration if
I'm not mistaken. Also this would solve the PCI resource conflict
between both drivers.

At any rate, I don't think that the bt869 driver as we know it should be
ported to Linux 2.6. I can't believe it is the only video-out chip out
there, and no other board has a similar driver so there must be a
different way to get the job done.

I also wonder if the BT869 chip was ever seen on non-banshee/voodoo
boards.

Thanks,
-- 
Jean Delvare
