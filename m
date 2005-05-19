From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040129212058.7112ba77.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > +/* Defining this will enable debug messages for the voltage
> > iteration+   code used with rev 0 ICs */
> > +#undef DEBUG_VIN
> > +#ifdef DEBUG
> > +#define DEBUG_VIN
> > +#endif
> 
> As you always tie DEBUG_VIN to DEBUG, why even have it at all?  Just
> get rid of it, and everywhere it's defined.

I was wondering. Since it seemed that specific debug was wanted for this
part of the code, I thought it would make sense to keep a separate
define. Yes, it is set when DEBUG itself is, but could easily be
disabled with DEBUG still set, or set when DEBUG isn't.

Anyway, I think that this code will go away, so there's no point
discussing this anymore.

Here are the things as I understood them. Please correct me if I am
mistaking.

Release 0x00 of the chipset doesn't support reading in0-in2 values. A
workaround was implemented into the driver. The idea of it is to change
the min and max limits of these channels, and watch wether an alarm is
triggered. After a few iterations, you can get an idea of the
approximative value of the reading.

Since the iteration process is slow, an option was introduced to use it
or not, and possibly trigger it as a background job (thus the thread
code). Note that when the iteration process is run in the background,
the driver will return the previous value so that the caller doesn't
have to wait for the iterations to finish.

I sure don't want to see this into the 2.6 kernel. The chip doesn't
support reading these values? It doesn't support it. Period. So we don't
report them. It's that simple. 160 lines of complex code (20% of the
driver code) simply there to workaround a chip design issue is more than
arguable. What's more, I think we all agree that what really needs to be
monitored are temperatures and fans. If the voltages are bad, the alarm
will trigger. You don't really need to know how bad they were. If people
really want to know, well, they can do the limits trick from user space.

If anyone wants this "feature" to be kept, speak up. Else let's get rid
of it. The way we will handle it in libsensors and sensors is a
different problem, I'll take a look right now.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
