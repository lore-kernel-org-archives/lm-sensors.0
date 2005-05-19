From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Trouble with i2c and bttv
Message-Id: <3F0A2058.5040807@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307042024.55272.tim.boneko@web.de>
In-Reply-To: <200307042024.55272.tim.boneko@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

What I mean is that we need to be prepared
to followup the i2c layer patch with the bttv fixup relatively quickly,
(you don't want the i2c patch to go in late in a release cycle either)
and the fixup may take some time, so in practice you may want to get started
on the fixup before you send in the i2c patch.



Jean Delvare wrote:
>>no, I think we need to send it all at once, it's a stable kernel
> 
> 
> I misexpressed myself. I mean we need to first have our patch (I2C layer
> + kernel drivers modifs) to be accepted before even having to help
> non-kernel modules (such as the zoran one which I'm using) convert their
> modules so that they will work with the new kernel.
> 
> BTW, I need a new-I2C-layer patch for the kernel before I can change the
> zoran driver and test it. I guess that using our mkpatch script with
> I2C-cvs should do it?
> 
> (This actually means that beginning with the zoran driver isn't the more
> logical thing to do, but since this is the only module I'll be able to
> test, better that way.)
> 
