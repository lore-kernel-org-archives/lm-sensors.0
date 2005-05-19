From: dan.eaton@rlx.com (Dan Eaton)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Thermal fan on PIIIDME
Message-Id: <1024530116.28465.32.camel@dan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
In-Reply-To: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Best course of action may be to dump the configuration data for the lm87
prior to loading the lm87 data (using the smbus access functions in the
core i2c drivers) so that the BIOS configuration of the part can be
determined.  It is quite possible (almost certain) that the default lm87
settings are conflicting with the way that the inputs/outputs of the
part are physically wired.  Some of the I/O on that part is
multi-purpose based on configuration making it impossible for the
default driver initialization of the part to properly configure it to
suit every design.

Once you know the proper configuration of the part, change the lm87
driver to configure it the same way and recompile.

May be way more than you want to get into but it's simpler than it
sounds.

On Wed, 2002-06-19 at 16:30, phil@netroedge.com wrote:
> 
> Oh, boy, I'm not sure.  It sounded like the fan was controlled by an
> LM87.  What controls the LM87?  It seems obvious to me that the LM87's
> must be controlled exclusively through the SMBus.  It's possible that
> ACPI (or some other Bios thing?) is controlling the LM87 via the
> SMBus, but I'm not an ACPI expert. 
> 
> 
> Phil
> 
> 
> On Wed, Jun 19, 2002 at 10:07:07PM +0100, Chris Rankin wrote:
> > 
> > --- phil@netroedge.com wrote:
> > > It's possible that the initialization function in
> > > the LM87 driver in
> > > lm-sensors is overriding the settings that the Bios
> > > does.
> > 
> > Ummm, I wonder. I tried setting the thermal fan to
> > come on at 30 degrees C, so it came on immediately at
> > power up. I noticed that the memory test was running
> > slower than usual and then the boot-process "stuck"
> > just after the hard disks had been recognised. I had
> > to power off and re-enter the BIOS settings. Trying to
> > boot at a higher temperature (45 degrees) resulted in
> > the fan whirring intermittently and this time it
> > managed to boot during one of the thermal fan's quiet
> > periods. (I.e. it waited for the fan to stop spinning,
> > and then booted!) At the LILO prompt screen, the
> > keyboard was unresponsive as long as the thermal fan
> > was on, and now that I've booted into Linux the fan
> > isn't spinning at all.
> > 
> > This is starting to sound "interrupt-like", to me. Do
> > you think that the thermal fan could be part of the
> > ACPI subsystem instead, and not connected to the SMBus
> > at all?
> > 
> > Chris
> > 
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > Everything you'll ever need on one web page
> > from News and Sport to Email and Music Charts
> > http://uk.my.yahoo.com
> 
> -- 
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
-- 
Dan Eaton
Senior Systems Engineer
RLX Technologies, Inc.
25231 Grogan's Mill Rd - Suite 600
The Woodlands, TX 77380
281.863.2100 Main
281.863.2126 Direct
281.863.2104 Fax
dan.eaton@rlxtechnologies.com
http://www.rlxtechnologies.com 
