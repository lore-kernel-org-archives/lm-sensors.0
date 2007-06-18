From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jun 2007 12:13:13 +0000
Subject: Re: [lm-sensors] Quick Question about latest IBM thinkpads!
Message-Id: <20070618141313.4e92260a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <524002.68161.qm@web82504.mail.mud.yahoo.com>
In-Reply-To: <524002.68161.qm@web82504.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique, hi Leon,

On Sun, 17 Jun 2007 12:13:05 -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 16 Jun 2007, leon moss wrote:
> > I was just wondering if the lm-sensors will still
> > break the latest IBM thinkpads I am thinking about
> > getting a T61. I remember all of the other issues that
> > have been reported from other thinkpad users at
> > earlier models but I just wanted to see if you may
> > have known about the new T61's.
> 
> Don't run sensors-detect on thinkpads, all you will find *IF* you are very
> lucky, is the clock generator (*never* mess with it) and the SPD eeproms in
> the RAM modules (dmidecode will tell you all about your RAM in a thinkpad,
> anyway).

I don't even see these on my T60p's SMBus.

> All of a recent thinkpad's sensors are not reachable by the main CPU.  Use
> the ibm-acpi/thinkpad-acpi and tp_smapi drivers to talk to them.  And if you
> did not do it yet, go to http://thinkwiki.org to learn about your thinkpad
> and its drivers.  There is not much on the T61 in there yet, so feel free to
> help improve it.
> 
> Thinkpad-acpi will export the sensors through the hwmon layer in 2.6.23,
> btw.  I'd imagine lm-sensors userspace will be able to talk to it, then.

For the stable branch of lm-sensors, explicit support will be needed. If
you plan to merge support in the 2.6.23 kernel, it would probably be a
good thing to merge the user-space support now, so that it makes it into
the next release (2.10.4) and is available when kernel 2.6.23-rc1 is
released.

> Just don't do sensors-detect on a thinkpad. It is useless, although AFAIK it
> won't touch the broken vital-product-data eeprom that bricked thinkpads
> anymore.

For what it's worth, sensors-detect didn't break my Thinkpad T60p. A
recent version even found the CPU-embedded sensors (Intel Core Duo
T2600) which are supported by Rudolf Marek's coretemp driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
