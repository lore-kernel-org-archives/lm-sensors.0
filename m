From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Temperature sensor support
Message-Id: <20040908075716.M47363@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <04090718250100.01233@localhost.localdomain>
In-Reply-To: <04090718250100.01233@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> We are developing a board that uses a 64-bit MIPS Linux 2.4-20 real-time
> kernel and has a MAXIM MAX1617A temp sensor hanging on a SMBbus.
> 
> We hav some code that runs as a character-ish driver for the BIOS already.
> 
> I am curious what it would we would could do to support your group 
> to get your lm_sensor code running our platform soon?
> 
> It does not look like it currently does support this (please 
> correctly me if I am wrong).

The MAX1617A itself is actually supported by our "adm1021" driver for quite a
long time now (since version 2.3.0 back in April 1999).

What is probably not is the SMBus master itself. Most bus drivers we are
support chips found on x86 machines.

> Our schedule is very tight, although the driver would not be terribly
> difficult to write, so it would be wonderful to have your code base support
> it. We are thinking of a proc_fs file that shows temp stats or just 
> a simple modular character driver that reads the temp when requested.

Better stick to our model so you integrate with the existing layout and
benefit from existing userspace support.

What you need to do is to write a driver for your SMBus master chip, which
respects the model we use. If your SMBus is bit-banging driven (and then
most-likely I2C-compatible), take a look at i2c-voodoo3.c for an example (or
any bus driver including i2c-algo-bit). If your SMBus is hardware-driver (and
most probably not I2C-compatible) take a look at i2c-amd756.c instead (or any
bus driver not including i2c-algo-bit).

Once your bus driver is working, load it and run "sensors-detect", which
should scan it and find the MAX1617A on it.

-- 
Jean Delvare
http://khali.linux-fr.org/
