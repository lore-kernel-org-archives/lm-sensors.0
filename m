From: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: bt869 driver
Message-Id: <20050203105715.GI10602@bytesex>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050129234511.5dc19d3b.khali@linux-fr.org>
In-Reply-To: <20050129234511.5dc19d3b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> In a nutshell, you set up the video card by getting X going in a  
> video-compatible mode-line, and then you tell the BT869 the format  
> (e.g. resolution, broadcast standard, etc.).

Ah, ok.  That really sounds like the X-Server would be the right place
to setup that.  The X-Server doing one part of the setup, the driver
another part and the user must care about doing that in the right order
is a bit hackish.

Given that x.org is more open than xfree86 it should be easier to get
bt859 support into the X-Server these days, I'd suggest to try to go
that route ...

> That said, I don't know how many folks are using this driver vs.  
> something else like nvtv.

nvtv does the same, but from userspace (using /dev/i2c maybe)?

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
