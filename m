From: slade@goembedded.com (slade@goembedded.com)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Temperature sensor support
Message-Id: <20040908170832.1669.qmail@webmail-2-5.mesa1.secureserver.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <04090718250100.01233@localhost.localdomain>
In-Reply-To: <04090718250100.01233@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The MAX1617A itself is actually supported by our "adm1021" driver for quite a
> long time now (since version 2.3.0 back in April 1999).
> 
I saw that but I was not sure about the SMBbus which you answered below.

> What is probably not is the SMBus master itself. Most bus drivers we are
> support chips found on x86 machines.
> 
Understood. That should not be much trouble.

> Better stick to our model so you integrate with the existing layout and
> benefit from existing userspace support.
> 
That is helpful. I agree and will do.

> What you need to do is to write a driver for your SMBus master chip, which
> respects the model we use. If your SMBus is bit-banging driven (and then
> most-likely I2C-compatible), take a look at i2c-voodoo3.c for an example (or
> any bus driver including i2c-algo-bit). If your SMBus is hardware-driver (and
> most probably not I2C-compatible) take a look at i2c-amd756.c instead (or any
> bus driver not including i2c-algo-bit).
> 
Very, very helpful. Thank again.

> Once your bus driver is working, load it and run "sensors-detect", which
> should scan it and find the MAX1617A on it.
> 
Gotcha.

Thank you for getting back so quickly!!

