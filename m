From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c 2.8.0 patches for bttv 0.9.x and saa7134
Message-Id: <20030803172600.GF30040@puariko.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030803094915.GD30040@puariko.nirvana>
In-Reply-To: <20030803094915.GD30040@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 03, 2003 at 03:30:24PM +0200, Jean Delvare wrote:
> 
> > are there patches for bttv 0.9.x and saa7134 0.2.8? I package drivers
> > for bttv/saa7134/ivtv as external kernel modules.
> > 
> > I found the ivtv patches at
> > http://www.ensicaen.ismra.fr/~delvare/devel/i2c/ivtv-i2c-2.8.0.patch
> > 
> > And the bttv 0.7.x patches at
> > http://www.ensicaen.ismra.fr/~delvare/devel/i2c/i2c-2.8.0-drivers-media-video.diff
> > 
> > but the latter are for the in-kernel bttv sources. Should they apply
> > to the 0.9.x series also?
> 
> I didn't know there were another series. The patch for 0.7.x will not
> apply to this series. I can make patches for the 0.9.x series if you
> need them. Likewise, I can make a patch for the saa7134 module.

Yes, please, I would appreciate that very much. These drivers can be
found at

     http://bytesex.org/bttv/ and http://bytesex.org/saa7134/

I am still in the process of merging i2c/lm_sensors 2.8.0 into the
Red Hat kernel. When I'm finished I'd like to build ivtv/bttv/saa7134
kernel modules for that kernel.

Thanks!
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030803/952c9c6c/attachment.bin
