From: jeff.kosowsky@verizon.net (Jeffrey J. Kosowsky)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: Following up on ticket: 1108
Message-Id: <16027.13438.200420.709847@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
References: <15975.35668.184684.840621@consult.pretender>
In-Reply-To: <15975.35668.184684.840621@consult.pretender>
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote at about 14:30:18 -0400 on Sunday, April 13, 2003:
 > * Jeffrey J. Kosowsky <jeff.kosowsky@verizon.net> [2003-03-28 12:24:59 -0500]:
 > The ASB100 chip (unlike others supported by w83781d module) requires a
 > working I2C bus driver.  The w83781d module will not even detect your ASB100
 > without it.  (Ticket answerers please keep this in mind.)
 > 
 > Asus website says you have "Intel? 82801DA ICH4" chipset.  I'm not sure
 > if release 2.7.0 supports this.  Anyone else know?

Any way to find out whether it is supported before I sink too much
more time in spinning my wheels? :)

 > >  > When I run sensors-detect I get that all probes fail including the one for the 
 > >  > 28381d driver. e.g.,
 > >  >   Probing for %G$,3u=(B%@Winbond W83781D%G$,3u=(B%@
 > >  >     Trying address 0x0290... Failed!
 > >  >   Probing for %G$,3u=(B%@Winbond W83782D%G$,3u=(B%@
 > >  >     Trying address 0x0290... Failed!
 > 
 > Right, the above are ISA probes, not I2C.

Shouldn't sensors-detect also probe the I2C bus? I may be
misunderstanding the documentation, but how else do you test if I2C
stuff is working? (In any case, my setup didn't detect anything either way)

 > >  > I am using a stock unpatched 2.4.20 kernel under RH8.0.(i2c support is compiled 
 > >  > in as a module). I also tried separately making and installing the drivers from 
 > >  > the i2c-2.7.0 package without any success.
 > >  >
 > >  > I am using lm_sensors-2.6.5-3 which I installed as an RPM that I got off of 
 > >  > freshrpms.net.
 > 
 > Make sure that you completely remove the sensors RPM before you try to 
 > install one from source.  If that breaks dependencies... ignore them
 > (you'll be replacing what's needed anyway).  

I built new rpms for i2c-2.7.0 and lm_sensors-2.7.0. I then did a
clean install of the RPMs (Note I am running under RH8.0/Linux 2.4.20
with I2C compiled as a module). Is there anything else I should be
doing here?

Is there any way I can be helpful in pushing support forward for the
ASB100 chip? I am not a device-driver programmer but I can help alpha
or beta test :)

Thanks again for your help.
Regards,
Jeff
