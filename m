From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Jan 2013 20:55:09 +0000
Subject: Re: [lm-sensors] Help to make lm-sensors work with an Asus TUSL2-C
Message-Id: <20130111215509.3d5b5a38@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50DB2017.8010403@tiscali.it>
In-Reply-To: <50DB2017.8010403@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 11 Jan 2013 10:59:30 -0800, Guenter Roeck wrote:
> On Fri, Jan 11, 2013 at 07:03:39PM +0100, Mauro Molinari wrote:
> > Il 08/01/2013 14:50, Jean Delvare ha scritto:
> > >>Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> > >>Found unknown chip with ID 0x5953
> > >>      (logical device 9 has address 0x290, could be sensors)
> > >
> > >Very strange, I wouldn't expected an unknown Super-I/O chip on such an
> > >old board. Can you find the chip's name by visual inspection of the
> > >board or from the documentation?
> > 
> > Hi Jean!
> > I looked at the mainboard again as you suggested. The Super I/O chip
> > is a Winbond W83627GF-AW.
> > 
> I think that may be W83627SF, not GF. Datasheet is on the web.
> If so, it does not support hardware monitoring.
> 
> From superiotool source:
> 
> 	{0x595, "W83627SF", {   /* TODO: Not yet in sensors-detect */
> 
> I guess that explains why sensors-detect doesn't recognize it.

The W83627GF seems to exist as well and it is entirely possible that
both have the same ID. The lack of "H" in the names indicates the lack
of hardware monitoring function in these chips.

I have added detection to sensors-detect. Even if the chip has no
hardware monitoring features, identifying it is good, as it clarifies
the situation.

Mauro, feel free to try:
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

It should now detect your Super-I/O chip. But the change is informative
only, it won't change the driver list for your board.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
