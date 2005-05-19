From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: checksum in (i2c) eeprom driver
Message-Id: <SFhEWFpz.1102668141.6379450.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <41B8ED64.9020805@verizon.net>
References: <lNsWdTVB.1102596784.6279250.khali@localhost>
In-Reply-To: <lNsWdTVB.1102596784.6279250.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@Stimpy.netroedge.com
Cc: Deepak Saxena <dsaxena@plexity.net>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>


On 2004-12-10, Mark Studebaker wrote:

> IMHO the eeprom driver is more of a demonstration driver than one of
> great and obvious value, so achieving consensus on the value of
> sub-features (checksum, Vaio) is difficult, and performace concerns are
> secondary.

This has certainly been true when the driver was first written and then
maintained as a driver of the lm_sensors project, and was only used for
memory module EEPROMs. However, we now start seeing more different
natures of EEPROMs (proprietary on laptops, ethernet devices to name
only two of them) for which the eeprom driver can be useful. Remember
that a number of people even asked for write support in the driver (and
this might as well happen in the future).

> So I don't see any value removing the code. If you want to make it
> super-clean shouldn't the Vaio stuff come out too?
> But I'm sure you'll disagree...

I would be happy to remove all Vaio stuff if there were no security
concern in doing so. Unfortunately it happens that Vaio EEPROMs contain
passwords in a very lightly encoded form and I thought that we didn't
want every user of the system to be able to read it. If there is a
better way to achieve the same goal, I'd gladly hear about it. I can
also get rid of the test altogether if a majority of people think it's
not necessary to hide the machine password from users - after all, only
a limited number of machines are Vaio laptops, of which a limited number
actually have a system password set, of which a limited number have more
than one user, of which a limited number have untrusted users.

The value of removing the code is, unsurprisingly, to reduce the amount
of code to maintain and the amount of memory used by the driver when
loaded. I am also trying to comply with the kernel rules about what
belongs to the kernel-space and what belongs to the user-space.

Thanks,
--
Jean Delvare
