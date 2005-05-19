From: happycactus@vene.ws (HappyCactus)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: lm_sensors and 2.4.21 kernel patches
Message-Id: <20030709154543.471976a7.happycactus@vene.ws>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030709152306.690e38f1.happycactus@vene.ws>
In-Reply-To: <20030709152306.690e38f1.happycactus@vene.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 Jul 2003 15:41:48 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > I downloaded the kernel source patches for the 2.4.20 kernel, and
> > tryed to patch my 2.4.21, obviously did not work correctly.
> 
> We are about to release a new version of i2c and lm_sensors, which
> will work with the 2.4.21 kernel directly (except an incompatibility
> with some video devices, but that's a quite different issue we are
> already working on). 

ok, I will wait for it ;)

> So we won't make use of your patch, but that was
> nice to you. Thanks for using our drivers!

No problems, I believe in Open Source and I try to do what I can.

> > It is a Sis chipset, identified by sensors-detect as sis5595...
> 
> Many, many SiS chipsets are misdetected as SiS 5595, so I can't tell
> you what you really have. Only the 5595 is supported by our drivers.

Yes, I read the howto/faq and I notice that. no problem, I did not mean
to disturb you with this issue.
Just for your information, i could send you a lspci or other information
you need on the chipset I have (it's a rocky 3705 EV industrial SBC)...
just if it is of any use for you.

Best Regards and Thank you!

HappyCactus
