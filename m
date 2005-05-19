From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: probe order for 2.6 sensor chips
Message-Id: <20030811233318.0941bdf8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811204839.GA18442@kroah.com>
In-Reply-To: <20030811204839.GA18442@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Someone just filed an interesting 2.6 bug:
> 	http://bugme.osdl.org/show_bug.cgi?id66
> 
> It pertains to the order of the i2c sensor drivers being loaded.  Is
> there some documentation somewhere that details which drivers need to
> be placed before the others?

No such document exist yet AFAIK.

> Right now I'm just using the alphabetical order for link priority,
> but this is probably wrong as this report has determined :)
> 
> Any thoughts as to the correct order?

First note: some drivers cannot possibly be detected, so building them
into the kernel will result in a mess. The mess will be full if these
drivers are loaded before the others (preventing the regular driver to
handle the chip), and limited if these drivers are loaded after the
others (exporting bad values).

Second note: proper operation of our modules sometimes require module
parameters. Since all our drivers have common parameter names, having
them all in the kernel will not allow for passing such a parameter to
only one of them. So our drivers are really meant to be compiled as
modules, not to be built into the kernel.

The problem here is a bit different. Some chips have multiple addresses.
Generally, the extra addresses emulate other chips. So one can use the
other driver for these address, or use the first driver to handle all
addresses (generally what you want to do). So loading the multiple
addresses chips should be done first, so that the other drivers can't
pretend to handle the chip.

Grep'ing doc/chips tells that there is only one driver having multiple
addresses: w83781d. However I know that ddcmon has a similar mechanism,
so there are at least two. So a preliminary list of "high priority"
modules follows:

w83781d
ddcmon

And a list of "low priority" modules now (undetectable ones):

ltc1710
pcf8574
pcf8591

Additionally, there's smbus-arp, but I'm not too sure about this one,
and it shouldn't intefere with other drivers anyway, so you can leave it
apart.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
