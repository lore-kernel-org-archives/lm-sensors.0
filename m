From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 12 Jun 2007 17:40:30 +0000
Subject: Re: [lm-sensors] dme1737 and sch311x similarities
Message-Id: <466EDA8E.10009@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706120929k2b63b7afy25e5e92b2dec756b@mail.gmail.com>
In-Reply-To: <191fb4ca0706120929k2b63b7afy25e5e92b2dec756b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> All,
> 
> I looked through the SMSC sch311x datasheet and discovered that the HW
> monitoring capabilities of the two chips are nearly identical. The
> sch311x is missing some of the optional features like fan4 and pwmA
> and pwmB and registers are accessed through the LPC interface rather
> than an SMBus interface as is the case for the dme1737.
> So if I were to enhance the dme1737 driver to support the sch311x
> family this would imply that sch311x owners would also need to load
> i2c modules which aren't really necessary/used in this case.
> On the other hand, two separate drivers means a lot of code redundancy...
> 
> Any thoughts on which way to go? Personally I prefer a single driver,
> way easier to maintain.
> 

I say go for the single driver approach,

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
