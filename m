From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jun 2007 18:37:53 +0000
Subject: Re: [lm-sensors] dme1737 and sch311x similarities
Message-Id: <20070614203753.18dd33a3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706120929k2b63b7afy25e5e92b2dec756b@mail.gmail.com>
In-Reply-To: <191fb4ca0706120929k2b63b7afy25e5e92b2dec756b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg, Hans,

On Tue, 12 Jun 2007 19:40:30 +0200, Hans de Goede wrote:
> Juerg Haefliger wrote:
> > I looked through the SMSC sch311x datasheet and discovered that the HW
> > monitoring capabilities of the two chips are nearly identical. The
> > sch311x is missing some of the optional features like fan4 and pwmA
> > and pwmB and registers are accessed through the LPC interface rather
> > than an SMBus interface as is the case for the dme1737.
> > So if I were to enhance the dme1737 driver to support the sch311x
> > family this would imply that sch311x owners would also need to load
> > i2c modules which aren't really necessary/used in this case.
> > On the other hand, two separate drivers means a lot of code redundancy...
> > 
> > Any thoughts on which way to go? Personally I prefer a single driver,
> > way easier to maintain.
> 
> I say go for the single driver approach,

Agreed. It may sound suboptimal, but OTOH the SMSC SCH311x isn't very
popular so it doesn't really matter. And this won't be the first driver
like this: take a look at the w83781d and lm78 drivers, they support
ISA and I2C access to the chips, so you depend on the i2c stack even if
you use only the ISA access.

A different approach was taken for the ams driver, which also support
two access methods, but support is in separate files, which can be
selected (or not) through Kconfig.

The ideal way would be separate kernel modules, so that you don't have
to exclude options at compilation time, and still don't have to load
i2c-core if you don't need it. But it's probably more work than is
worth. If someone really cares, he/she gets to do it. In the meantime,
an hybrid driver will be much better than no support at all.

BTW, Juerg, a driver had been contributed for this chip some times ago:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-July/016961.html
Not sure if you were aware of this, so I thought I'd mention it. If you
work on this, please also update the Devices page on the wiki
accordingly.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
