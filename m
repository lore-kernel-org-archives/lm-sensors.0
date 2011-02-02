From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Feb 2011 11:08:02 +0000
Subject: Re: [lm-sensors] How to distinguish sensors on Xeon multi-socket
Message-Id: <20110202120802.7e4f94ff@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201102012323.13215.4ernov@gmail.com>
In-Reply-To: <201102012323.13215.4ernov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2 Feb 2011 12:34:44 +0300, 4ernov wrote:
> 2011/2/2 Jean Delvare <khali@linux-fr.org>:
> > On Tue, Feb 01, 2011 at 03:23:13PM -0500, Alexey Chernov wrote:
> > > Hello,
> > >
> > > I have two socket motherboard with two Xeon's 5345 installed on them, so
> > > overall it's 8 cores. Using lm_sensors all of them are detected correctly out
> > > of the box, but the problem is that after certain Linux kernel upgrade (I
> > > believe it's somewhere around 2.6.32) matching kernel on both processors
> > > started to be called identically. I have two 'Core 0', two 'Core 1' etc. and
> > > it drives mad many applications which use lm_sensors. Here's the output of
> >
> > These are badly written applications, which need to be fixed
> > regardless of what the coretemp did, does, or will do. Label uniqueness
> > across multiple sensor devices isn't and has never been guaranteed. We
> > only guarantee uniqueness of symbols within each given chip.
> > Application which needs unique keys must use the combination of the
> > chip name + the symbol name; definitely not the label.
> 
> That's right and this is what I want to do with one of them but the
> question is how to do it properly. Thank you for suggestion on unique
> keys. What is "symbol name"? Does it stand for sensors_feature struct
> or label?

Symbol names are things like "in0" or "temp1". Which in libsensors
indeed corresponds to sensors_feature structure.

> > (...)
> > In the meantime, a workaround would be to align the hwmon device
> > numbers with the CPU number, so that the user can at least look-up
> > in /proc/cpuinfo to find out who is who. But there is no guarantee for
> > the CPU enumeration order to stay the same across reboots, so the
> > interest would be limited in practice.
> 
> Is it about lm-sensors or the applications? As for the applications I

The workaround would be in the coretemp driver. But it would only let
you look-up manually which coretemp entry corresponds to which physical
CPU. It wouldn't help with bogus applications which rely on label
uniqueness.

> think it's the possible solution because the list of sensors could be
> generated on every startup of the app and if there were some mapping
> between hwmon and, say, 'core id' in /proc/cpuinfo, the processors can
> be recognized.

Really, I don't think we want to invest any development time in this.
Applications shouldn't have to do this, the coretemp driver should
simply group sensors together when they belong to the same CPU.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
