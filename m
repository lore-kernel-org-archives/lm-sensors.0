From: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: bt869 driver
Message-Id: <20050130090935.GB25497@bytesex>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050129234511.5dc19d3b.khali@linux-fr.org>
In-Reply-To: <20050129234511.5dc19d3b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> for Linux 2.4 and gives control of the video out parameters through
> procfs.

> People are asking for a Linux 2.6 port for quite some time now. I
> believe that such a driver would better live in drivers/media/video than
> drivers/i2c/chips, and I guess that the standard video-out drivers have
> a completely different interface (sysctl instead of procfs?).

Hmm, the drivers in drivers/media/video/ usually do video _capture_,
although some of them also support video output using the v4l2 API.

The other video-out drivers are the framebuffer drivers in
drivers/video/.

The BT869 seems to fit none of these categories through, seems to be
neither a video4linux nor a framebuffer driver from the description, it
seems to just export some config stuff via /proc.

What exactly does the BT869?  Handle the TV-out of the voodoo3?  What is
the point of that driver?  Any reason why this couldn't simply be done
by the X-Server which drives the voodoo3?  Is it somehow related to the
voodoo framebuffer driver maybe?  At the moment I somehow miss the big
picture, the driver alone looks pretty useless to me ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
