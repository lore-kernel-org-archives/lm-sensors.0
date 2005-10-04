From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 04 Oct 2005 21:37:12 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051004213643.68871c78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

> I got sick of waiting for someone else to do it, and ported the Myson
> MTP008 chip driver to the Linux 2.6 kernel.  I have successfully compiled
> and loaded the module on a Tyan Thunder LE ServerWorks dual P3 motherboard
> with two of these chips.
> 
> The module source code is here:  http://www.sericyb.com.au/mtp008.c

Great :)

> Here are patches against Linux 2.6.12 and 2.6.13:
> 
> http://www.sericyb.com.au/linux-2.6.12-mtp008.patch.bz2
> http://www.sericyb.com.au/linux-2.6.13-mtp008.patch.bz2

There have been quite a few changes since then. Could you please
provide a patch against 2.6.14-rc2-mm2 or at least 2.6.14-rc3?

Some times ago, Helge Bahmann had been working on a similar port. I did
not answer to him back then (my bad, too busy, sorry Helge), but maybe
you can work together to have the best code possible and extended
testing as well? I guess that Andrew's version is a better starting
point as Helge's version is older and so many things have changed since.

One thing which has changed is the introduction of the dynamic sysfs
callbacks, which your port doesn't seem to take benefit of. It would be
great if you could modify the code to use these, as it makes it
possible to get rid of many macros, making the code much more readable
(and reviewable), and it also makes the driver smaller in memory. See
drivers/hwmon/it87.c in any recent Linux tree as an example of how this
can be done.

Also make sure you read Documentation/CodingStyle and that you follow
the guidelines. This will make my work easier. Once you have something
to show, post it here (preferably inline in your mail, that's the
easier to review) and I'll try to review it quickly.

Thanks,
-- 
Jean Delvare
