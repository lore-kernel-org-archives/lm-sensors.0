From: Michael Lawnick <ml.lawnick@gmx.de>
Date: Wed, 15 Jul 2009 05:41:30 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two
Message-Id: <4A5D6C0A.7030903@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>	<4A5CB908.4060404@cam.ac.uk> <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>
In-Reply-To: <528f13590907141358w17869b6fq450bf223e4f54687-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

alfred steele said the following:
> To sum it up, the intention is code
> reusablity in the sense that if we move to a different part which sits
> on the I2c bus, we need not have to modify the kernel driver, just
> keep the complexity  in the userspace.

I'd say this is just the wrong way round:
Design goal should be to keep application as is and just load another
driver on H/W change + changing access path in some config file.

Just my 2 cents

Michael

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
