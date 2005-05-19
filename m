From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <Pine.LNX.4.58.0407012044070.26054@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> >> ELSE
> >> VRM_NONE
>
> I would say VRM_UNKNOWN. You don't know about any other CPU, especially
> not any *future* CPU.

Sure

> Ruik, can we actually forget about the stepping (at least for the
> existing CPUs)?

Yes we can, but we must care about extended family and extended model in
future

>
> If we don't go with a simple (but large) lookup table, there are two
> choices left: simple algorithmic and rules-based (much like dmi_scan.c
> does). I think that the latter is the easier to maintain. Rules would
> look like:
>
> { cpu manufacturer, family, from product, to product, (from stepping, to
> stepping), VRM }
>
> If stepping (or even product) is not relevant we define a negative
> constant standing for "any" and use it.

Before I answer this.
I think We dont need that header file. I need only some masks from that
#defines so I can live without that. It wont be use in table concept
anyway.

Output from CPUID:
eax = cpuid_eax(1);

Bits    Description
0..3    Stepping
4..7    Model  c->x86_model
8..11   Family c->x86
12..13  Processor type
16..19  Extended Model
20..27  Extended Family

??? unknown value?
-- dont care

F in Family => refer to extended family.
Exteded model seems unused

Here is the table:

c->x86_vendor=VENDOR_AMD
============

Family|Model|ExtFamily|ExtModel
===============  6     --    --         --    VRM_INTEL_9x;    //athlons etc
  F      4      0        ???     perhaps 9x      //Athlon 64
  F      5      0        ???    VRM_AMD_OPTERON  //Opteron


c->x86_vendor = X86_VENDOR_INTEL
================
Family|Model|ExtFamily|ExtModel
===============  6     B      --         --      VRM_INTEL_85   /* 0xB Tualatin */
  6     9      --         --      VRM_INTEL_85  // this is also 0.13um
  6    --      --         --      VRM_INTEL_8x  //rest P6 CPU's
  7   ???????????????????????     ???????????   //Itanium
  F     3      0          --      VRM_INTEL_10x //Pentium P4 (0.09 um)
  F     --     0          --      VRM_INTEL_9x  //All P4 before Prescott
  F     ???    1         ???      ??????????    //Itanium 2

For completeness only
==========
  F     0      0          --      VRM_INTEL_9x  //Pentium IV (0.18 um)
  F     1      0          --      VRM_INTEL_9x  //Pentium IV (0.18 um)
  F     2      0          --      VRM_INTEL_9x  //Pentium IV (0.13 um)

> I have a Tualatin on my laptop but unfortunately no hardware monitoring
> chip on it, and I don't think the BIOS will let me know the voltage...
> I'll still try this evening.

Only try if that code really finds it :) If it will produce right
number...

>
> >> 2) how to or who will incorporate this into the drivers? (Khali maybe?)
>
> The good thing here is that it can be done step by step. We can just add
> the function to i2c_sensor, then convert existing drivers to it as time
> permits. I don't think we want a separate modue for it, do we?

No function will be great I think.

One think in closing. I found Itanium2 VID and they are different from all
above...

I guess I should implement some code that will go through the tables it
the format I proposed?

Regards

Rudolf
