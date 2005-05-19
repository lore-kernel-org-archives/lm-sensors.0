From: sydow@speakeasy.net (sydow@speakeasy.net)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors without modules in the kernel
Message-Id: <Pine.LNX.4.44.0309151813130.7559-100000@web0.speakeasy.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0309101108420.19605-100000@web0.speakeasy.net>
In-Reply-To: <Pine.LNX.4.44.0309101108420.19605-100000@web0.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I completely realize my error once I actually tried a kernel with module 
support. While the drivers I did have loaded loaded just fine and seemed 
like it should work it didn't. The reason was apparent once I enabled 
modules support and ran sensors-detect it detected that I have the 
i2c-nforce2 rather than the i2c-amd756 which I thought would work for my 
motherboard (ASUS A7N8X Deluxe). Considering that there isn't a driver 
available for this sensor yet, certainly explains why the program would 
not detect the sensors, and why it doesn't work on my system.

:(

On Sat, 13 Sep 2003, Mark Studebaker wrote:

> if you have any patches or suggestions on how to fix sensors-detect that
> would be great.
> It should recognize the amd756 driver is compiled in and scan its bus.
> 
> 'sensors' should work fine with compiled-in drivers;
> you mentioned the amd756 "bus" driver but no "chip" drivers.
> 
> If sensors-detect did scan the amd756 bus but did not find anything,
> then see our FAQ.
> 
> 
> sydow@speakeasy.net wrote:
> > 
> > I know you've made some good strides in making lm_sensors non modularized.
> > I was able to get everything compiled into my kernel for my particular
> > platform (lm_sensors-2.8 and i2c-2.8). Using kernel 2.4.22 and I also have
> > compiled in the appropriate sensor driver (i2c-amd756).
> > 
> > The only problem I am seeing is that your sensors-detect program seems to
> > be hard coded for modules, when in fact everything is compiled in the
> > kernel. Also the sensors program reports no sensors found. A previous
> > unsolved ticket# relating to this would be #892 and #547. The former being
> > nearly identical in symptoms.
> > 
> > If I need to open a ticket, let me know.
> > 
> > Sorry for bothering you directly.
> > 
> > --
> > 
> > Donovan Sydow
> > Information Systems Lead
> > SPEAKEASY.net
> > 
> > "One World, One Web, One Program" - Microsoft promotional ad.
> > "Ein Volk, Ein Reich, Ein F?hrer" (One People, One Kingdom, One Leader)
> > - Adolph Hitler.
> 

-- 

Donovan Sydow
Information Systems Lead
SPEAKEASY.net

"One World, One Web, One Program" - Microsoft promotional ad.
"Ein Volk, Ein Reich, Ein F?hrer" (One People, One Kingdom, One Leader) 
- Adolph Hitler.


