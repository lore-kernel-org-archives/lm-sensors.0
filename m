From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 06 Jan 2006 07:38:32 +0000
Subject: [lm-sensors] the issue about config bus and proc bus number
Message-Id: <20060106083832.71a000ce.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3174569B9743D511922F00A0C94314230D826E12@TYANWEB>
In-Reply-To: <3174569B9743D511922F00A0C94314230D826E12@TYANWEB>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Raphael,

> I come from Tyan Computer. Right now, I'm doing the configuration file for
> Tyan S4882D and S4881. I used the SuSE Professional 10.0, kernel is 2.6.13.
> lm-sensor version is 2.9.1.
> 
> As both of these two board, have PCA9556 multiplexer as I2C Switch, I loaded
> the dirver "i2c-amd756-s4882", then I can see all the busses and hwm chips.

It's great that the same driver works unmodified for these two new
boards :) Can you tell us the difference between the S4882D, S4881 and
the original S4882? I'm curious.

> The issue is I could not make configured bus number in configuration files
> match the proc ones.
> 
> Following is claimed bus in my configuration file, actually, I checked the
> source code, it should be same in proc.
> 
> bus "i2c-0" "SMBus AMD8111 adapter at c0e0" "Unavailable from sysfs"
> 
> bus "i2c-1" "SMBus 8111 adapter (CPU0)" "Unavailable from sysfs"
> 
> bus "i2c-2" "SMBus 8111 adapter (CPU1)" "Unavailable from sysfs"
> 
> bus "i2c-3" "SMBus 8111 adapter (CPU2)" "Unavailable from sysfs"
> 
> bus "i2c-4" "SMBus 8111 adapter (CPU3)" "Unavailable from sysfs"

I think you are hitting an already known bug, which was found and fixed
in CVS in September 2005 by Karsten Petersen:

Working file: lib/data.c
(...)
revision 1.13
date: 2005/09/10 09:29:35;  author: khali;  state: Exp;  lines: +10 -7
(Khali) Fix bus matching mechanism which had always been broken for Linux
2.6. Original patch from Karsten Petersen.

So please give a try to lm_sensors CVS instead of 2.9.1 and confirm
that it fixes your problem. If not, we'll investigate.

> (btw, I don't know why the algorithm is "Unavailable from sysfs", as source
> code, it should be "Non-I2C SMBus adapter", but after traced the code, I got
> the former.)

Algorithm information was never exported from Linux 2.6 kernels, which
is why all user-space tools were saying "Unavailable from sysfs". As it
turns out that algorithms are an implementation detail user-space
doesn't actually care about, the algorithm names were even dropped in
Linux 2.6.14. I think we should now remove any reference to algorithm
names in our user-space tools so as to not confuse the users.

Note that it is still possible to differenciate between an I2C adapter
and an SMBus adapter (and also dummy adapters) from their capabilities
bitvector. This is what i2cbusses.c (which is used in i2cdetect,
i2cdump, i2cset and i2cget) does in CVS version (since September 2005.)

We should start thinking of a new numbered release of lm_sensors, as
soon as we're done with the migration to Subversion. I'd like this next
release to be 2.10.0, as there are a few major changes this time, in
particular the PEC support rewrite, and the fact that libsensors now
requires libsysfs. Also, libsensors probably deserves to be numbered
3.1.0 because of the latter.

-- 
Jean Delvare

