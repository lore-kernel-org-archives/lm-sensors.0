From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c 2.8.0 patches for bttv 0.9.x and saa7134
Message-Id: <20030803153024.7c058f04.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030803094915.GD30040@puariko.nirvana>
In-Reply-To: <20030803094915.GD30040@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> are there patches for bttv 0.9.x and saa7134 0.2.8? I package drivers
> for bttv/saa7134/ivtv as external kernel modules.
> 
> I found the ivtv patches at
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/ivtv-i2c-2.8.0.patch
> 
> And the bttv 0.7.x patches at
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/i2c-2.8.0-drivers-media-video.diff
> 
> but the latter are for the in-kernel bttv sources. Should they apply
> to the 0.9.x series also?

I didn't know there were another series. The patch for 0.7.x will not
apply to this series. I can make patches for the 0.9.x series if you
need them. Likewise, I can make a patch for the saa7134 module.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
