From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <20040701022644.GB5247@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf:

* Rudolf Marek <R.Marek@sh.cvut.cz> [2004-06-30 19:38:33 +0200]:
> 
> Hello,
> 
> I finally finished some code to detect correct VRM using CPUID.
> 
> What the code does?
> 
> If AMD
>     /*Duron&Ahlon has VRM 9x*/
>     if Opteron  VRM_AMD_OPTERON
> If INTEL
>      FOR /* P6 Family */
>          ret = VRM_INTEL_8x;
>          but  /* 0xB Tualatin */ and maybe  /* 0x9 ????? it has 0.13um */
>          has   ret = VRM_INTEL_85;
>      FOR p4 Family
>          everything except model 3 has  ret = VRM_INTEL_9x;
>          model 3 is prescott 90nm it has VRD 10 (my name is   ret >         VRM_INTEL_10x;   /* 0x3 prescott */)
> ELSE
>   VRM_NONE
> 
> I belive this is correct.

It's not a bad start.  I wonder if it should be implemented literally as
a table; with vendor id, family, model, and stepping.  Walk the table to
find the answer.  Although, I guess the VRM spec can't differ due to
different processor stepping alone?

> You can get it here:
> 
> http://ssh.cz/~ruik/cpuidvrm.c
> http://ssh.cz/~ruik/Makefile
> make -C /usr/src/linux-2.6.6 SUBDIRS=$PWD modules

As I found it, it doesn't actually compile for me... misplaced paren.

> Cut & paste from relevant part of source will follow at the end of this
> message.
> 
> What is needed now ?
> 
> 0) review by people here
> 1) test the code for different processors, mainly see if Tualatin is
> working and opteron. Simply insmod the module and see
> the output VRM_NONE = 0 etc..
> 2) how to or who will incorporate this into the drivers? (Khali maybe?)
> 
> 3) Little problem:
> //Linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h
> #define CPUID_PROCESSOR_SIGNATURE             1 /* function 1
> */
> #define OPTERON_XFAM_MOD             0x00000f50 /* xtended fam, fam +
> model */
> #define CPUID_XFAM_MOD               0x0ff00ff0 /* xtended fam, fam +
> model */
> 
> I need this from that header file but dont know how to get it clever way.

That's a symptom of a bigger problem... we don't want to suddenly make
all the sensors chip drivers depend on x86.  I.e. we'll need trivial stubs
for other architectures.  How many of those even have VID?  No idea.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
