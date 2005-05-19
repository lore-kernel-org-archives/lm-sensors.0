From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors without modules in the kernel
Message-Id: <3F638AF7.C48D7658@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0309101108420.19605-100000@web0.speakeasy.net>
In-Reply-To: <Pine.LNX.4.44.0309101108420.19605-100000@web0.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

if you have any patches or suggestions on how to fix sensors-detect that
would be great.
It should recognize the amd756 driver is compiled in and scan its bus.

'sensors' should work fine with compiled-in drivers;
you mentioned the amd756 "bus" driver but no "chip" drivers.

If sensors-detect did scan the amd756 bus but did not find anything,
then see our FAQ.


sydow@speakeasy.net wrote:
> 
> I know you've made some good strides in making lm_sensors non modularized.
> I was able to get everything compiled into my kernel for my particular
> platform (lm_sensors-2.8 and i2c-2.8). Using kernel 2.4.22 and I also have
> compiled in the appropriate sensor driver (i2c-amd756).
> 
> The only problem I am seeing is that your sensors-detect program seems to
> be hard coded for modules, when in fact everything is compiled in the
> kernel. Also the sensors program reports no sensors found. A previous
> unsolved ticket# relating to this would be #892 and #547. The former being
> nearly identical in symptoms.
> 
> If I need to open a ticket, let me know.
> 
> Sorry for bothering you directly.
> 
> --
> 
> Donovan Sydow
> Information Systems Lead
> SPEAKEASY.net
> 
> "One World, One Web, One Program" - Microsoft promotional ad.
> "Ein Volk, Ein Reich, Ein F?hrer" (One People, One Kingdom, One Leader)
> - Adolph Hitler.
