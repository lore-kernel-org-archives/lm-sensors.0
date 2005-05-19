From: clepple@ghz.cc (Charles Lepple)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: error: "SMBus collision!"/"sending abort" in 2.6.0test2
Message-Id: <07F7FD0F-C306-11D7-BB43-003065DC6B50@ghz.cc>
List-Id: <lm-sensors.vger.kernel.org>
References: <1D98A118-C22E-11D7-BB43-003065DC6B50@ghz.cc>
In-Reply-To: <1D98A118-C22E-11D7-BB43-003065DC6B50@ghz.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday, July 30, 2003, at 11:04  PM, Mark M. Hoffman wrote:

> * Charles Lepple <clepple@ghz.cc> [2003-07-29 21:35:35 -0400]:
>> I accidentally started up two copies of a sensord-for-2.6 kludge (just
>> cats a bunch of /sys nodes, and jams the results into rrdtool). A
>> little while after I started the second copy, I started seeing this in
>> my kern.log:
>>
>> Jul 29 21:19:45 vole kernel: i2c_adapter i2c-0:  SMBus collision!
>> Jul 29 21:19:46 vole kernel: i2c_adapter i2c-0: : Sending abort.
>> Jul 29 21:20:17 vole last message repeated 52 times
>
> What I2C bus driver?
>
> What sensors chip driver?

my fault, that was an embarrassingly poor bug report.

It's an AMD 76x bus controller (i2c-amd76x), and both a W83627HF and a 
W83782D chip controlled by the w83781d driver.

This setup requires the crazy init=0 and force_subclients deal that 
other 760MP chipset users have reported in the trouble ticket area.

Driver version is 2.7.0 (20021208). I haven't gotten around to making 
2.8.0 work with the 2.6 kernel.

>> removing the modules didn't help-- nothing showed up in
>> /sys/bus/i2c/devices afterwards.
>>
>> ideas?
>
> I would like to try to reproduce this, but not until this weekend.
> Would running 2-3 shell scripts simultaneously which cat the /sys
> values to /dev/null be good enough?

I would assume so. It'll probably take some random time skew between 
the scripts to trigger the problem, because I think there was a delay 
between the beginning of the script, and the beginning of the error 
messages.

I was trying to figure out some power management and ntp interaction 
problems that required some extended uptime, so I didn't try and 
reproduce the problem after rebooting.

Afterwards I happened to see some reports on LKML of interactions 
between ACPI and the sensor chips, but the ACPI implementation is so 
weak on this board (a Tyan S2460) that I doubt the ACPI portion of the 
BIOS even knows about the I2C bus.

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/
