From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 20 Aug 2006 10:44:47 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <44E83D1F.3000608@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <446DF157.80805@t-online.de>
In-Reply-To: <446DF157.80805@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harald,


> AFAICS the values measured by the sensor chips are pretty
> far away from reality, as it seems. The mapping to real
> temperatures, and voltages is done in the sensors tool
> in user space.
> 
> But: Ain't this extremely hardware dependent? Looking at the
> same sensor built into several different mainboards of different
> manufacturers, I would guess that the range for the measured
> temperatures or voltages can vary alot, depending upon some
> external resistors, the position of the chip on the main
> board, etc. Every second board needs its own sensors.conf,
> does it?
> 

Well same board should have same sensors.conf. But it is upon manufacturer to
wire it as they like. This is the reason for sensors.conf

The driver exports the voltage value measured on ADC pin, but this voltage needs
scaling because for example 5V needs to be in range of 0-2.048V The scaling
depends on hardware used (two resistors) and there are many ways how to fit 5V
into this range.

Temperatures sometimes needs some offsets to add or even more complicated formulas.

> Or is there some kind of standard, at least for the major
> chips?

Board manufacturer may follow the recommendations found in datasheet for that
particular chip. I belive more standards will show when the PECI and SST will
become more popular for intel chips.

Regards
Rudolf

