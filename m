From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: lm_sensors and 2.4.21 kernel patches
Message-Id: <20030709154148.458f351a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030709152306.690e38f1.happycactus@vene.ws>
In-Reply-To: <20030709152306.690e38f1.happycactus@vene.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I downloaded the kernel source patches for the 2.4.20 kernel, and
> tryed to patch my 2.4.21, obviously did not work correctly.

We are about to release a new version of i2c and lm_sensors, which will
work with the 2.4.21 kernel directly (except an incompatibility with
some video devices, but that's a quite different issue we are already
working on). So we won't make use of your patch, but that was nice to
you. Thanks for using our drivers!

> It is a Sis chipset, identified by sensors-detect as sis5595...

Many, many SiS chipsets are misdetected as SiS 5595, so I can't tell you
what you really have. Only the 5595 is supported by our drivers.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
