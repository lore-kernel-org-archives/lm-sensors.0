From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: pca9540 driver question
Message-Id: <20040619093650.066fcc5d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406181758580.19803@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406181758580.19803@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> I am working on a board that has a PCA9541 I2C Mux, and is recognized
> by sensors-detect as the pca9540.  The driver loads fine, but I have 
> yet to really test it.

Just forget about it, it won't work. The PCA9540 and the PCA9541 are
completely different chips, according to the datasheets. The PCA9540
multiplexes two "slave" i2c busses on a single "master" i2c bus. The
PCA9541 does the exact opposite, i.e. it multiplexes one single "slave"
bus on two "master" busses. Not only that, but the register
configuration and commands are totally different, so there's no chance
the pca9540 driver will work for you.

The PCA9540 is really hard to detect, which easily explains why your
PCA9541 was midetected as one. That said, I just noticed that the
detection code in sensors-detect was not correct, and fixed it. I also
noticed that the detection code in the driver could be slightly
improved, and I did that as well. I doubt it will prevent the
misdetection in your case though.

> I guess my question is what was what
> functionality was the driver attempting to provide?  Does it actually
> allow for the phillips arbitration protocol when trying to talk to any
> sensors on the I2C bus, or does it only show what channel is selected
> at the time?  I looked in the code, and I could not see how it was
> actually allowing for the arbitration of the bus, but I very well
> could have missed something.

It is a really simple driver that just gives the user a manual control
over the multiplexer. There were plans to integrate such chips at a
lower level in the i2c core so that it is transparent to the user:
  http://archives.andrew.net.au/lm-sensors/msg04238.html
  http://archives.andrew.net.au/lm-sensors/msg05047.html
But it was never completed, so I decided to write that simple driver so
that people can control the chip manually in the meantime. But actually
I'm not even sure it was ever used. We had no feedback so far.

As you pointed out, manually switching the multiplexer at the wrong time
(when i2c bus isn't idle) is likely to cause trouble. The driver is
definitely meant as a temporary solution (which basically means it'll
probably be used for another two years or so before a better solution is
implemented ;)).

-- 
Jean Delvare
http://khali.linux-fr.org/
