From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <200407010825.i618PQDu088819@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> ELSE
>> VRM_NONE

I would say VRM_UNKNOWN. You don't know about any other CPU, especially
not any *future* CPU.

>It's not a bad start.  I wonder if it should be implemented literally as
>a table; with vendor id, family, model, and stepping.  Walk the table to
>find the answer.  Although, I guess the VRM spec can't differ due to
>different processor stepping alone?

Ever seen a CPUID table from Intel docs? You wouldn't believe there are
that many different versions for each CPU. If we can forget about the
stepping it *may* be possible to have a way shorter table, but it's
likely to be still rather large.

Ruik, can we actually forget about the stepping (at least for the
existing CPUs)?

If we don't go with a simple (but large) lookup table, there are two
choices left: simple algorithmic and rules-based (much like dmi_scan.c
does). I think that the latter is the easier to maintain. Rules would
look like:

{ cpu manufacturer, family, from product, to product, (from stepping, to
stepping), VRM }

If stepping (or even product) is not relevant we define a negative
constant standing for "any" and use it.

I guess that it'll be stlighly slower than raw algorithmic but it
doesn't matter. It'll still be fast enough and is really only called
once.

>> 0) review by people here
>> 1) test the code for different processors, mainly see if Tualatin is
>> working and opteron. Simply insmod the module and see
>> the output VRM_NONE = 0 etc..

I have a Tualatin on my laptop but unfortunately no hardware monitoring
chip on it, and I don't think the BIOS will let me know the voltage...
I'll still try this evening.

>> 2) how to or who will incorporate this into the drivers? (Khali maybe?)

The good thing here is that it can be done step by step. We can just add
the function to i2c_sensor, then convert existing drivers to it as time
permits. I don't think we want a separate modue for it, do we?

Maybe we can merge i2c_vid.h into i2c_sensor.h after that, or maybe we
don't care.

>> 3) Little problem:
>> //Linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h
>> #define CPUID_PROCESSOR_SIGNATURE             1 /* function 1
>> */
>> #define OPTERON_XFAM_MOD             0x00000f50 /* xtended fam, fam +
>> model */
>> #define CPUID_XFAM_MOD               0x0ff00ff0 /* xtended fam, fam +
>> model */
>>
>> I need this from that header file but dont know how to get it clever way.
>
>That's a symptom of a bigger problem... we don't want to suddenly make
>all the sensors chip drivers depend on x86.  I.e. we'll need trivial stubs
>for other architectures.  How many of those even have VID?  No idea.

I don't see the problem. We know which architecture we are compiling the
module for. Just enclose the whole stuff (including the arch-specific
#include) into #ifdef CONFIG_X86. For other archs we default to an empty
function returning VRM_UNKNOWN. If we later learn about non-x86 chips
we'll update the file.

Am I missing something?

Jean Delvare
