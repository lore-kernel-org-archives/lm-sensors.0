From: francois.barre@siemens.com (BARRE Francois)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: Implemeting an SMBus device to control Fan Speed ?
Message-Id: <EFEF4C473088B847B64CD953D2A6A10401B08EF1@sdso14a.par.siemens.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

	I have a VIA Nehemiah M10k which is not able to set Fan Speed
Control, and I had a look on chips which would be able to achieve that. 
	Microchip releases such devices :
http://www.microchip.com/1010/pline/analog/anicateg/thermal/dcfan/tc6xx/tc66
4/, which is able to set a PWM for a fan and read the RPM by a
self-inductante system (FanSense technology...).

	I am trying to buy a few ones and test them, but I guess I will have
to implement a new smbus device. 
	Did anyone have such experience, and could provide me some wise
advices ? Especially how could I deal with multiple SMBus slave devices
sharing the same address ?
	Is anyone interested in having a fan speed control ?

	Thanks for advance,

PS : I would like to subscribe to this ML, how should I proceed ?
