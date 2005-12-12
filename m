From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Dec 2005 18:09:58 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic card temperature
Message-Id: <20051212190958.4698b034.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399BE92.9020705@mathematica.scientia.net>
In-Reply-To: <4399BE92.9020705@mathematica.scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christoph,

> > You can try:
> > 1) load i2c-rivatv (or whatever driver for the i2c nvidia bus)
>
> Is this going to be available for 2.6.x kernels?

It is supposed to be already, except that the exact name is "rivatv",
not "i2c-rivatv".

http://rivatv.sourceforge.net/

Alternatively, you should be able to gain control of the nVidia I2C
busses using the in-kernel-tree rivafb or nvidiafb framebuffer drivers.
Make sure to enable "DDC support" in either case.

-- 
Jean Delvare

