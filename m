From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Sep 2009 08:11:59 +0000
Subject: Re: [lm-sensors] Problems with DG45ID sensors
Message-Id: <20090912101159.2584e949@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <11d69f10909101520u10eae0bfhe137338e336e186c@mail.gmail.com>
In-Reply-To: <11d69f10909101520u10eae0bfhe137338e336e186c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 11 Sep 2009 23:04:56 -0300, Igor Santos wrote:
> # sensors-detect revision 5760 (2009-07-24 15:52:28 +0200)
> > # Board: Intel Corporation DG45ID
> >
> > This program will help you determine which kernel modules you need
> > to load to use lm_sensors most effectively. It is generally safe
> > and recommended to accept the default answers to all questions,
> > unless you know what you're doing.
> >
> > Some south bridges, CPUs or memory controllers contain embedded sensors.
> > Do you want to scan for them? This is totally safe. (YES/no):
> > Silicon Integrated Systems SIS5595... No
> > VIA VT82C686 Integrated Sensors... No
> > VIA VT8231 Integrated Sensors... No
> > AMD K8 thermal sensors... No
> > AMD K10 thermal sensors... No
> > Intel Core family thermal sensor... Success!
> > (driver `coretemp')
> > Intel AMB FB-DIMM thermal sensor... No
> > VIA C7 thermal and voltage sensors... No
> >
> > Some Super I/O chips contain embedded sensors. We have to write to
> > standard I/O ports to probe them. This is usually safe.
> > Do you want to scan for Super I/O sensors? (YES/no):
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `National Semiconductor'... Yes
> > Found `Nuvoton WPCD377I Super IO'
> > (no hardware monitoring capabilities)

This is the chip that was improperly detected as an LM96000 (driver
lm85) beforehand. So this problem is fixed in sensors-detect now. Not
sure about the lm85 driver itself.

> (...)
> I've read the bug report you linked me after the part where someone talks
> about my motherboard. Looks like they did some research and just ended on an
> empty point.

Not really. The conclusions are pretty clear.
1* The WPCD377I doesn't include sensors. So what appeared to be
   supported by the lm85 driver, isn't.
2* The sensors on all these Intel board series are in the ICH, but we
   do not support this yet.

So at this point, no hardware monitoring on your board, until we
finally get support for AMT/HECI. This is tracked in:
http://www.lm-sensors.org/ticket/2134

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
