From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 May 2011 16:30:41 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110505183041.6cf0031d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harry,

On Thu, 05 May 2011 09:16:19 -0600, Harry G McGavran Jr wrote:
> Attached are the sensors-detect output and the i2cdump
> results...

I found just now in the list archives that you had been reporting all
the requested data back on April 14th. For some reason I never received
any of the 3 replies you sent that day :( So sorry for the delay...

Anyway, my detection code was too strict, as it seems you have the
second revision of the EMC6W201 and my code only detected the first
one. I've committed a fixed version of the detection code, successfully
tested on the dump you sent, so I know it works.

I've also updated the entry in wiki/Devices. Hopefully this will get
other owners of this chip, if any, to report to us.

> FWIW: I installed the i8kutils and driver and forceloaded the driver.
> They seem to be able to read the fan speeds, but not the CPU 
> temperature.  So, there is some code around that works with
> this machine, but not entirely.  That may be a place to look too.

Huh. I don't know if this is good news... If the BIOS gets the fan
speeds from the EMC6W201, then we will get a resource conflict if you
try using a native driver for the EMC6W201. If the BIOS gets the fan
speeds from somewhere else, then a native driver for the EMC6W201 may
not be that useful to you. D'oh.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
