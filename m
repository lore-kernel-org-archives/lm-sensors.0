From: b-gruber@gmx.de (Berni)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors && bt869
Message-Id: <848372088.20040105160759@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guten Tag Jean Delvare,

am Freitag, 2. Januar 2004 um 14:02 schrieben Sie:

JD> [Don't forget to CC: the mailing-list on replies]

I wasn't at home when I wrote this, so i forgot that. Sorry!

JD> I don't know. I'd suggest you copy your source file in
JD> linux/drivers/i2c/chips, and edit linux/drivers/i2c/chips/Makefile (add
JD> a line like "obj-m += bt869.o"). Then configure a fake kernel with as
JD> least options as possible (but don't forget to at least enable
JD> i2c-core). Then compile your kernel and see what happens.

JD> That doesn't look very immediate nor professional, I admit, but that's
JD> how I do and it works ;) If anyone has a better way of testing new
JD> drivers, let us know.

I tried this (kernel 2.6.0), but I can't figure out the reason for the
following two problems:

1.  For text-output, the new functions like dev_info, dev_dbg and so on
should be used as I read. However a line like
dev_info(&client->dev, "probing address %d .\n", address);
always produces the error that "client" is undeclared. A also tried
"adapter" instead of "client" but with the similar result. In the
lm83.c it's used the same way, but there, the problem does not exist.
Do you have any idea on that?

2. When I get to the device creation I also get problems with
undeclared variables. However, this line
device_create_file(&new_client->dev, &dev_attr_output_norm);
sounds right for me.

Perhaps I just forgot one line anywhere which would solve those two
problems...


Bernhard Gruber
mailto:b-gruber@gmx.de
