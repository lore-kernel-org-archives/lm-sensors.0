From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Thu, 05 May 2011 16:40:28 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110505164028.8194C1266C5@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jean --


On Thu, 5 May 2011 18:30:41 +0200 Jean Delvare wrote:
> Hi Harry,
> 
> On Thu, 05 May 2011 09:16:19 -0600, Harry G McGavran Jr wrote:
> > Attached are the sensors-detect output and the i2cdump
> > results...
> 
> I found just now in the list archives that you had been reporting all
> the requested data back on April 14th. For some reason I never received
> any of the 3 replies you sent that day :( So sorry for the delay...
> 
> Anyway, my detection code was too strict, as it seems you have the
> second revision of the EMC6W201 and my code only detected the first
> one. I've committed a fixed version of the detection code, successfully
> tested on the dump you sent, so I know it works.
> 
> I've also updated the entry in wiki/Devices. Hopefully this will get
> other owners of this chip, if any, to report to us.

I;ll keep my fingers crossed --- this is progress...

> 
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

I didn't know if that would be helpful or not.  Since my machine isn't
i8k, I'm not keen to use it, but I though the fact it got fan info
might be helpful without really knowing how it got the data.

I can hope for an lm-sensors driver...

Thanks again!

	Harry

> 
> -- 
> Jean Delvare

-- 

Harry G. McGavran, Jr.

E-mail: w5pny@w5pny.com




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
