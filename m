From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-matroxfb
Message-Id: <20030718143116.563c7b62.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710182523.4ceef8fa.khali@linux-fr.org>
In-Reply-To: <20030710182523.4ceef8fa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark, how went your trip in France?

> > The problem I encountered is that scanning the I2C bus of my Matrox
> > Mystique is very, very slow. As slow as lasting 30 minutes where
> > scaning other devices last a few seconds only. The problem shows
> > when sensors-detect is run, or when i2c-detect is run on the bus as
> > well.
> 
> I saw it mentioned (maybe on LKML) that this driver has an overly long
> I2C bus timeout - something like 30 seconds or so.  That's silly.
> 
> I have an ancient Millenium II to test with, if anyone needs.

I have been operating some tests WRT this topic, and here are some
random thoughts about it.

First, the timeout isn't 30 seconds. It is set to "100" in a unit I
believe is hundreds of seconds, so it is one second. This is bad because
it doesn't use HZ as it should. It is more than other drivers I have see
which use HZ/2 (that is, 50) for timeout. But that's only double,
nothing to yield after.

I tried to run i2cdump on my Matrox Mystique, first with timeout0,
second with timeoutP. It took 8s for each address scanned in the first
case, 4s for each address scanned in the second case. This shows that
the timeout is the value that makes it slow, but this also raise another
problem. I would have expected the average scan time to be exactly the
timeout value. And it is eight times higher.I checked the i2cdump code
and it only calls i2c_smbus_read_byte_data() once for each address.

I searched the web for a solution and found that loading the
i2c-algo-bit module (which i2c-matroxfb is using) with bit_test=1 solves
the problem.

I will lead the same kind of experiments on the rivatv module, since it
does the same as i2c-matroxfb. If the conclusions are different, it
means that there is something to fix in the i2c-matroxfb driver. If the
conclusions are the same, it means that we could consider doing the
bit_test=1 for i2c-algo-bit the default. I don't know if it can have
side effects. Well, I see at least one, which is that the test is made
at the time the client module is loaded. So if the user loads the module
at a time he/she has no compliant monitor, and changes that afterwards,
he/she will still have his/her I2C bus disabled. I doubt it is a major
issue, this isn't the kind of thing that is likely to happen very often.

Another easier possibility is to add some code to sensors-detect to load
i2c-algo-bit with bit_test=1 right before we load i2c-matroxfb, but it
will fail if the i2c-algo-bit is already loaded for some reason. We
could at least tell the user that scanning the i2c-matroxfb bus can be
slow, so he/she can skip it is he/she wants.

Comments welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
