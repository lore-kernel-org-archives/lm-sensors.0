From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: Following up on ticket: 1108
Message-Id: <20030413183018.GC17239@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <15975.35668.184684.840621@consult.pretender>
In-Reply-To: <15975.35668.184684.840621@consult.pretender>
To: lm-sensors@vger.kernel.org

* Jeffrey J. Kosowsky <jeff.kosowsky@verizon.net> [2003-03-28 12:24:59 -0500]:
>  > Problem in detail:
>  > 
>  > I am a newbie at lm_sensors, so please forgive me if I am doing something 
>  > stupid :)
>  > 
>  > I have an ASUS p4pe motherboard which according to http://mbm.livewiredev.com/ 
>  > has the ASB100 chipset which apparantly is supported by driver w83781d 
>  > according to the "new drivers" page for versions >2.6.5.

The ASB100 chip (unlike others supported by w83781d module) requires a
working I2C bus driver.  The w83781d module will not even detect your ASB100
without it.  (Ticket answerers please keep this in mind.)

Asus website says you have "Intel? 82801DA ICH4" chipset.  I'm not sure
if release 2.7.0 supports this.  Anyone else know?

>  > When I run sensors-detect I get that all probes fail including the one for the 
>  > 28381d driver. e.g.,
>  >   Probing for %G$,3u=(B%@Winbond W83781D%G$,3u=(B%@
>  >     Trying address 0x0290... Failed!
>  >   Probing for %G$,3u=(B%@Winbond W83782D%G$,3u=(B%@
>  >     Trying address 0x0290... Failed!

Right, the above are ISA probes, not I2C.

>  > I am using a stock unpatched 2.4.20 kernel under RH8.0.(i2c support is compiled 
>  > in as a module). I also tried separately making and installing the drivers from 
>  > the i2c-2.7.0 package without any success.
>  >
>  > I am using lm_sensors-2.6.5-3 which I installed as an RPM that I got off of 
>  > freshrpms.net.

Make sure that you completely remove the sensors RPM before you try to 
install one from source.  If that breaks dependencies... ignore them
(you'll be replacing what's needed anyway).  

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

