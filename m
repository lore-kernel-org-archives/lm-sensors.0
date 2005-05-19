From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Trying to find device chrontel 7009
Message-Id: <20031105203334.6eab5b78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > The LM80 is hard to detect, so it might not be LM80's. Load lm80,
> > run sensors (and sensors -s before that) and see if the values make
> > sense.
> 
> sensors output:
> flex scanner jammed

U-ho. That's something that happens when you are using a configuration
file (/etc/sensors.conf) that is newer than libsensors. Is that the case
here? Try using the right config file (copy it manually from lm_sensors'
etc/sensors.conf.eg) and see if it goes any better. If not, that means
that you have found a bug, and we'll start hunting it.

> I have lm_sensors 2.7.0. I downloaded 2.8.1 but got this problem
> while compiling:
> (...)
> Seems that you depend on different kernel header than 2.4.20?

Sure it does. You need to install an i2c version that at least matches
the version of lm_sensors you want to use. See our installation guide
here for installing 2.8.x since it's a bit tricky:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/

> i2cdump 1 0x44 b
> (...)

I don't know what this is.

> i2cdump 1 0x2e b
> (...)
> 30: 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 30 41 83
                                             ^^ ^^  ^
This is an Analog Devices ADM1030, revision 3. That's a hardware
monitoring chip. Unfortunately, we don't support it yet. We might add
support for it later though.

> i2cdump 1 0x2f b
> (...)

Don't know what it is either.

> Seems like you are right and only one of 0x2e and 0x2f is a real lm80.

Actually I now believe none of them is.

> maybe none of these devices is my chrontel so i will have to search
> on.

I downloaded the 7009's data sheet and it happens that is not designed
for the I2C interface. Why did you think you would find it here? To me,
it's obvious it can't be there. You have to look for it somewhere else.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
