From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: lm-sensors
Message-Id: <3C61EE92.392A5D31@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It is probably on an I2C bus for which we do not support the driver.
See FAQ.

> A&A Computer Solutions wrote:
> 
> hey!
> 
> I have a Fullyes 82440LX motherboard, with a pentiumII 300MHz.
> I compiled i2c and lm-sensors with no problems (I guess).
> But unfortunately there is a problem :)
> 
> On my motherboard there is an gl518sm sensor chip,
> which should be supported.
> Unfortunately sensors-detect only detects an eeprom, but not the
> gl518sm chip.
> When I modprobe gl518sm, it nicely adds the module,
> but then a "sensors -a" results in an: sensors not found!
> 
> can you help please?
> if you need more info, just ask me,
> and I'll be happy to send it.
> 
> greetz,
> Anne
