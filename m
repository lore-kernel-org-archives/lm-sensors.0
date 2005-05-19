From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: sensors in 2.5.54
Message-Id: <3E1A4DC0.8000101@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I skimmed through the changes, tried to categorize them, and added a summary
to TODO in sensors.

The biggest change is in the PCI drivers, where you have to convert
to 2.4 kernel facilities for registering a driver for a PCI device.
Everything else is pretty straightforward.

Christoph did lots of debug printk changes which is harmless but
increases the size of the diff substantially.

One other big change is removing inc_use and dec_use functions
both from the drivers, and from the driver and adapter structs in i2c.h.
("modules can't adjust their own refcounts")
They are replaced with the struct member "owner" which is
handled in i2c-core.
This means that Albert's 2.5.53 patches won't work on 2.5.54+,
without ripping inc_use and dec_use out of each driver.

So in summary, non-PCI drivers don't look too bad,
PCI drivers will take some more effort.
I count about 18 PCI and 42 non-pci drivers in our package.

mds


Pavel Machek wrote:
> Hi!
> 
> 
>>The patch for i2c-amd756, i2c-amd8111, adm1021, and lm75,
>>submitted by Pavel Machek, has been included,
>>with modifications, in kernel 2.5.54 by Cristoph Hellwig.
>>As you can see from the patch notes below, there were
>>several modifications to the drivers and to the i2c core.
>>
>>Any volunteers to work with Cristoph to feed more drivers in?
>>Pavel?
> 
> 
> I'm slowly catching up on email flood. I'm unlikely to be mass-porting
> drivers, but I might port those needed for my boxes, in 4 weeks or so.
> 
> 
>>Also note that the drivers went into i2c/busses and i2c/chips,
>>so I think that solves that debate. I'll update our
>>makefiles and mkpatch to put them there and remove
>>old modules in i2c/ and sensors/ .
> 
> 
> Heh, that was probably me who did that... I did not know I was doing
> decision ;-).
> 								Pavel
