From: Simon Wilson <simon@simonandkate.net>
Date: Wed, 21 Oct 2009 12:30:42 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091021223042.12991mpr87bj9b02@mail.simonandkate.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Jean Delvare <khali@linux-fr.org>:

> Your register dump makes it pretty clear that there is no VID value to
> be read in the first place. At least not from the VID value register
> 0xfc).
>
> --
> Jean Delvare
>
>

What does this mean (taken from the it87.c documentation):

"The IT8718F and IT8720F also features VID inputs (up to 8 pins) but the value
is stored in the Super-I/O configuration space. Due to technical limitations,
this value can currently only be read once at initialization time, so
the driver won't notice and report changes in the VID value. The two
upper VID bits share their pins with voltage inputs (in5 and in6) so you
can't have both on a given board."

and...

   /* The device with the IT8718F/IT8720F VID value in it */
   #define GPIO    0x07

There are a few web pages out there with doco on that file (e.g.  
http://www.lm-sensors.org/attachment/ticket/2343/hwmon-it87-add-it8720f-support.patch).

They seem to refer to that chip holding VID in a different space... am  
I reading that wrongly?  :-D

At the end of the day, from my reading VID is what is used to  
kickstart the CPU, correct? Ongoing V to actually run it is what is  
measured as VCore, and this varies on modern CPUs. So what VID is  
really doesn't matter on a running system - and as it's only read into  
the IT8718F once on boot, reading it with lm_sensors doesn't really  
give me much useful data. Is that a correct(ish) understanding?

Of more real use I guess would be a range that I would expect to see  
at VCore (which I think is what I am seeing at in0), i.e. 1.04V to  
1.25V.

In which case, as you have previously mentioned, telling the IT87  
driver to ignore VID if it doesn't contain anything useful is probably  
the way to go...

Simon.

-- 
Simon Wilson
www.simonandkate.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
