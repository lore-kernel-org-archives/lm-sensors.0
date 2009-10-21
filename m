From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Oct 2009 13:06:05 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091021150605.40760023@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Simon,

On Wed, 21 Oct 2009 22:30:42 +1000, Simon Wilson wrote:
> What does this mean (taken from the it87.c documentation):
> 
> "The IT8718F and IT8720F also features VID inputs (up to 8 pins) but the value
> is stored in the Super-I/O configuration space. Due to technical limitations,
> this value can currently only be read once at initialization time, so
> the driver won't notice and report changes in the VID value. The two
> upper VID bits share their pins with voltage inputs (in5 and in6) so you
> can't have both on a given board."
> 
> and...
> 
>    /* The device with the IT8718F/IT8720F VID value in it */
>    #define GPIO    0x07
> 
> There are a few web pages out there with doco on that file (e.g.  
> http://www.lm-sensors.org/attachment/ticket/2343/hwmon-it87-add-it8720f-support.patch).
> 
> They seem to refer to that chip holding VID in a different space... am  
> I reading that wrongly?  :-D

You are right. But this was fixed a long time ago. The register dumps
you provided clearly show that the problem is at the hardware level and
not at the driver level.

> At the end of the day, from my reading VID is what is used to  
> kickstart the CPU, correct? Ongoing V to actually run it is what is  
> measured as VCore, and this varies on modern CPUs. So what VID is  
> really doesn't matter on a running system - and as it's only read into  
> the IT8718F once on boot, reading it with lm_sensors doesn't really  
> give me much useful data. Is that a correct(ish) understanding?

Not exactly. You are right that Vcore (in0) measures the actual CPU
voltage at any given time. VID, however, still matters after boot time.
VID is the (encoded) voltage _requested_ by the CPU. Which, as you
know, can vary over time for modern CPUs. So normally Vcore = VID, all
the time, if your power supply unit does its job correctly.

Now you are right that the limitation of the it87 driver to only read
VID at initialization time (for some of the supported chips at least,
amongst which the IT8718F) makes the VID value useless on systems with
CPU changing VID over time, as is your case. Even if we managed to get
a valid VID reading from your IT8718F chip (assuming this is possible
at all) it wouldn't be that interesting, unless we also address the
driver limitation about reading VID in real-time. Which is very complex
(which is why it didn't happen yet.)

> Of more real use I guess would be a range that I would expect to see  
> at VCore (which I think is what I am seeing at in0), i.e. 1.04V to  
> 1.25V.
> 
> In which case, as you have previously mentioned, telling the IT87  
> driver to ignore VID if it doesn't contain anything useful is probably  
> the way to go...

I agree it is probably the best thing you can do, until the it87 driver
is taught to hide invalid VID readings automatically.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
