From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 27 Aug 2006 20:22:31 +0000
Subject: [lm-sensors] Question on driver maxilife.c - how to compile for
Message-Id: <20060827222231.f356ec44.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608271418.06601.dieter.jurzitza@t-online.de>
In-Reply-To: <200608271418.06601.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guten Abend Dieter,

> within the lm-sensors source tree there is a list of drivers that cannot be 
> found in the kernel tree.
> However, I think my HP-Workstation would need the "maxilife" driver to work. 
> Could someone be so kind to tell me how to compile this as a module for 
> linux-2.6?
> The INSTALL - File  says "FOR 2.5/2.6 KERNELS, do not attempt to compile the 
> modules in this package. Use the drivers ...". 

The missing drivers have simply not be ported to Linux 2.6 yet, either
because we didn't have the time, or because nobody asked. This includes
the maxilife driver (nobody asked AFAIR).

Don't attempt to use the drivers from the lm_sensors tree with a Linux
2.6 kernel, it really won't work - too many things have changed between
2.4 and 2.6 kernels.

What makes you think you have a maxilife chip? This is a rare chip, we
don't even detect it in sensors-detect, and the driver seems to be
a bit... messy. I doubt this chip would be found in any recent system.

-- 
Jean Delvare

