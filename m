From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c 2.8.0 patches for bttv 0.9.x and saa7134
Message-Id: <20030803193252.56f8bbad.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030803094915.GD30040@puariko.nirvana>
In-Reply-To: <20030803094915.GD30040@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I didn't know there were another series. The patch for 0.7.x will
> > not apply to this series. I can make patches for the 0.9.x series if
> > you need them. Likewise, I can make a patch for the saa7134 module.
> 
> Yes, please, I would appreciate that very much. These drivers can be
> found at
> 
>      http://bytesex.org/bttv/ and http://bytesex.org/saa7134/

OK, done :) [1] Untested, tell me how it works.

> I am still in the process of merging i2c/lm_sensors 2.8.0 into the
> Red Hat kernel. When I'm finished I'd like to build ivtv/bttv/saa7134
> kernel modules for that kernel.

If you had difficulties merging i2c 2.8.0, it would mean that there are
changes that have been made to i2c drivers or subsystems in Red Hat's
kernel. If some of them are of interest to us and should be integrated,
please let us know!



[1] OK, I admit, I made the patches before you asked ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
