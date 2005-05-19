From: jeff.kosowsky@verizon.net (Jeffrey J. Kosowsky)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: Following up on ticket: 1108
Message-Id: <16004.34155.491168.582387@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
References: <15975.35668.184684.840621@consult.pretender>
In-Reply-To: <15975.35668.184684.840621@consult.pretender>
To: lm-sensors@vger.kernel.org

Again, just following up on my original ticket dated 1/20/03. At that
time, the response noted that the problem should be resolved in a few
weeks. Was just wondering if you expect to get to this soon or whether
the problem is more difficult than anticipated?

Thanks,
Jeff


Jeffrey J. Kosowsky writes:
 > Haven't seen much "news" on the homepages and was just wondering where
 > things stand and what I might be able to do to help.
 > 
 > Thanks,
 > Jeff
 > ------------------------------------------------------------
 > 
 > Problem in detail:
 > 
 > I am a newbie at lm_sensors, so please forgive me if I am doing something 
 > stupid :)
 > 
 > I have an ASUS p4pe motherboard which according to http://mbm.livewiredev.com/ 
 > has the ASB100 chipset which apparantly is supported by driver w83781d 
 > according to the "new drivers" page for versions >2.6.5.
 > 
 > When I run sensors-detect I get that all probes fail including the one for the 
 > 28381d driver. e.g.,
 >   Probing for %G$,3u=(B%@Winbond W83781D%G$,3u=(B%@
 >     Trying address 0x0290... Failed!
 >   Probing for %G$,3u=(B%@Winbond W83782D%G$,3u=(B%@
 >     Trying address 0x0290... Failed!
 > 
 > I then get the following output
 >   #----cut here----
 >   # I2C adapter drivers
 >   # I2C chip drivers
 >   #----cut here----
 > 
 >   #----cut here----
 >   # I2C module options
 >   alias char-major-89 i2c-dev
 >   #----cut here----
 > 
 > When I run %G$,3u=(B%@sensors -s%G$,3u=(B%@, I get "No sensors found"
 > 
 > Any thoughts on what is going wrong here?
 > 
 > I am using a stock unpatched 2.4.20 kernel under RH8.0.(i2c support is compiled 
 > in as a module). I also tried separately making and installing the drivers from 
 > the i2c-2.7.0 package without any success.
 > 
 > I am using lm_sensors-2.6.5-3 which I installed as an RPM that I got off of 
 > freshrpms.net.
 > 
 > Reply from support:
 > 
 > we have several reports that the ASB100 support doesn?t work,
 > sorry. We?re working on it but it may be a few weeks.
