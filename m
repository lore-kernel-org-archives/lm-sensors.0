From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Tue, 27 May 2008 17:01:19 +0000
Subject: Re: [lm-sensors] [spi-devel-general] Accelerometer,
Message-Id: <20080527170119.GA1938@polina.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com> <20080527164415.GA27584@polina.dev.rtsoft.ru> <20080527165021.GA22585@trinity.fluff.org>
In-Reply-To: <20080527165021.GA22585@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben@fluff.org>
Cc: Jonathan Cameron <Jonathan.Cameron@gmail.com>, spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On Tue, May 27, 2008 at 05:50:21PM +0100, Ben Dooks wrote:
> On Tue, May 27, 2008 at 08:44:15PM +0400, Anton Vorontsov wrote:
> > Hi Jonathan,
> > 
> > On Tue, May 20, 2008 at 11:04:01AM +0100, Jonathan Cameron wrote:
> > > This email is basically a request for opinions on how and where such sensors
> > > should be integrated into the kernel.
> > > 
> > > To set the scene...
> > > 
> > > Increasing numbers of embedded devices are being supplied attached MEMS
> > > devices (www.xbow.com imote2 etc). Along with more traditional sensors such
> > > as ADC's not being used for hardware monitoring, these do not really 
> > > seem to
> > > fit with in an particular subsystem of the kernel.  A previous 
> > > discussion on
> > > lkml in 2006 considered the accelerometers to be found within some laptop
> > > hard drives, but I haven't been able to track down any more general 
> > > discussions
> > > of such non hardware monitoring sensors.
> > > 
> > > The obvious possibilities are:
> > > 
> > > * To place the various drivers within the spi / i2c etc subsystems as 
> > > relevant.
> > > 
> > > * To place within the hwmon subsystem as this is probably closest.
> > > (there is already at least one straight ADC driver in hwmon)
> > > 
> > > * To create a new subsystem, or perhaps merely sysfs class to contain these
> > >   elements.
> > > 
> > > Typical requirements within an application include simply polling for 
> > > current
> > > readings, and using device triggered interrupts to grab data 
> > > continuously to a
> > > ring buffer, for collection by suitable userspace code.  Obviously it 
> > > would be
> > > desirable to standardize sysfs controls for various calibration 
> > > parameters as
> > > much as possible across the various devices.
> 
> The two drivers i've seen so far use the input subsystem to report
> their data to the user. I'm working on an driver for the SMB380 which
> can be both i2c and spi.
>  
> > Also, I'd mention that most ADC devices could report in "bunched" mode,
> > i.e.
> > 
> > 1. Request ADC readings from pins X, Y, Z1, Z2.
> > 2. Wait for single IRQ
> > 3. Read all the results
> > 
> > At handhelds.org, we've wrote quite good (I think) ADC subsystem,
> > that keeps in mind ADC capabilities. It implements two interfaces:
> > in-kernel (e.g. for touchscreen drivers), and userspace interface via
> > sysfs. I was planning to implement drivers/input/ interface too.
> 
> handhelds.org's track history of getting things into the kernel
> is poor.

Yes, mostly. Because lack of human resources. But something gets done
anyway, e.g. drivers/power/ is already in the mainline. Philipp Zabel is
doing great work for the HTC Magician support (already in mainline, too).

I think there are only few of us who think that mainlining is important,
this is bad. But the thinking improves as times goes by.

So, don't be so pessimistic. :-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
