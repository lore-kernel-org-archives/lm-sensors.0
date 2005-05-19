From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Asus P4C800-E Deluxe/Winbond W83627THF issue
Message-Id: <20050205185324.7d52c601.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502022021.06992.wik@blueyonder.co.uk>
In-Reply-To: <200502022021.06992.wik@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rik,

> Ok, I forced the uninstall then did a 'make clean' before attempting
> to  compile the 2.9.0 sensors pack as per the INSTALL file:
> 
> poochzilla:/usr/src/packages/SOURCES/lm_sensors-2.9.0 # make user
> Makefile:250: kernel/busses/i2c-ipmi.d: No such file or directory
> Makefile:250: kernel/busses/i2c-ali1535.d: No such file or directory
> Makefile:250: kernel/busses/i2c-ali15x3.d: No such file or directory
> Makefile:250: kernel/busses/i2c-amd756.d: No such file or directory
> .
> .
> .
> make: *** No rule to make target 
> `/lib/modules/2.6.8-24.11-smp/build/include/linux/modversions.h',
> needed by  `kernel/chips/xeontemp.d'.  Stop.
> poochzilla:/usr/src/packages/SOURCES/lm_sensors-2.9.0 #
> 
> The file that it appears to be complaining about does exist, here:
> /usr/src/linux-2.6.8-24.11/include/config/modversions.h
> 
> What am I doing wrong?

Wow, that's odd. "make" tries to compute dependencies for kernel
drivers, while it isn't supposed to do so when the target is "user". I
have no idea why it does this. Can't reproduce it here. Nobody reported
a problem with this so far.

> Am I guessing correctly that my filesystem isn't organised quite the
> way the Makefile is expecting it to be?
> 
> If so, then I can thank Novell/Suse for that...

Whatever the problme is, it's not related to the filesystem
organisation. Somehow, "make" doesn't behave the way we expect it to.
What version of make is it?

> How do I fix it?

No idea :(

> P.S. If you'd rather I not bother you with this noob stuff over email,
> I'd  gladly take it to an appropriate public forum if such a thing
> exists.

We have an IRC channel if you want. freenode::#linux-sensors.

-- 
Jean Delvare
