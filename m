From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: Implemeting an SMBus device to control Fan Speed ?
Message-Id: <4051022A.8000207@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <EFEF4C473088B847B64CD953D2A6A10401B08EF1@sdso14a.par.siemens.fr>
In-Reply-To: <EFEF4C473088B847B64CD953D2A6A10401B08EF1@sdso14a.par.siemens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We support PWM in at least 8 drivers (grep pwm kernel/chips/*.c),
you should pick one of them to start from if you want to write a driver.

See the Philips PCA954x devices for a method of multiplexing multiple
i2c busses onto a single bus.

But that could get messy.
You may have an easier time of it using a chip with multiple PWM outputs,
and for which we have an existing driver.

mds



BARRE Francois wrote:
> Hello all,
> 
> 	I have a VIA Nehemiah M10k which is not able to set Fan Speed
> Control, and I had a look on chips which would be able to achieve that. 
> 	Microchip releases such devices :
> http://www.microchip.com/1010/pline/analog/anicateg/thermal/dcfan/tc6xx/tc66
> 4/, which is able to set a PWM for a fan and read the RPM by a
> self-inductante system (FanSense technology...).
> 
> 	I am trying to buy a few ones and test them, but I guess I will have
> to implement a new smbus device. 
> 	Did anyone have such experience, and could provide me some wise
> advices ? Especially how could I deal with multiple SMBus slave devices
> sharing the same address ?
> 	Is anyone interested in having a fan speed control ?
> 
> 	Thanks for advance,
> 
> PS : I would like to subscribe to this ML, how should I proceed ?
> 
> 
