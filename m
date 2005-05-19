From: cj.rankin1@ntlworld.com (Chris Rankin)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Linux 2.6.0-test11 and lm_sensors 2.8.2
Message-Id: <200312132325.hBDNPQfM021761@twopit.underworld>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312131634.hBDGYrix013282@twopit.underworld>
In-Reply-To: <200312131634.hBDGYrix013282@twopit.underworld>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Success :-) !!

$ sensors
eeprom-i2c-0-52
Adapter: SMBus I801 adapter at efa0
Algorithm: Unavailable from sysfs
Memory type:            SDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at efa0
Algorithm: Unavailable from sysfs
Memory type:            SDR SDRAM DIMM
Memory size (MB):       512

The "unavailable algorithm" bothers me, but the output is now correct.

Thanks,
Chris

 
> Thanks. With your help I
> just realized I'm testing with a buggy i2c-amd756 driver.
> I fixed it and saw that
> my fix in libsensors was off-by-one.
> So I fixed that and now CVS should work for you. let me know.
> mds
> 
> Chris Rankin wrote:
> > 
> > It's definitely better... ;-).
> > 
> > $ sensors
> > eeprom-i2c-0-52
> > Adapter: SMBus I801 adapter at efa0
> > Algorithm: Unavailable from sysfs
> > Unknown EEPROM type (13)
> > 
> > eeprom-i2c-0-50
> > Adapter: SMBus I801 adapter at efa0
> > Algorithm: Unavailable from sysfs
> > Unknown EEPROM type (13)
> > 
> > Chris
> > 
> > > You inspired me to add support for eeproms in libsensors,
> > > I just checked it into CVS if you would like to try it.
> > > mds
> > >
> > > Chris Rankin wrote:
> > > >
> > > > Hi,
> > > >
> > > > I am having trouble using the lm_sensors 2.8.2 user tools with the
> > > > 2.6.0-test11 kernel. My machine has 2 built-in LM87 chips and 2 SDRAM
> > > > EEPROMs, all of which worked fine under Linux 2.4.
> > > >
> > > > The new 2.8.2 sensors tools are refusing to recognise my EEPROMs:
> > >
> 
