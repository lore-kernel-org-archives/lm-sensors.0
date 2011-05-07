From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 May 2011 07:49:21 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110507094921.458a8219@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 May 2011 18:30:41 +0200, Jean Delvare wrote:
> On Thu, 05 May 2011 09:16:19 -0600, Harry G McGavran Jr wrote:
> > FWIW: I installed the i8kutils and driver and forceloaded the driver.
> > They seem to be able to read the fan speeds, but not the CPU 
> > temperature.  So, there is some code around that works with
> > this machine, but not entirely.  That may be a place to look too.
> 
> Huh. I don't know if this is good news... If the BIOS gets the fan
> speeds from the EMC6W201, then we will get a resource conflict if you
> try using a native driver for the EMC6W201. If the BIOS gets the fan
> speeds from somewhere else, then a native driver for the EMC6W201 may
> not be that useful to you. D'oh.

Oh, BTW, if you're using the i8k driver, you may want to give a try to
my modified version here:
  http://khali.linux-fr.org/devel/misc/i8k/
Generic instructions can be found here:
  http://khali.linux-fr.org/devel/misc/INSTALL

This version of the i8k driver has proper hwmon subsystem integration,
so whatever the i8k driver reports should show up in the output of
"sensors".

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
