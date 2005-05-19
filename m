From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <Pine.LNX.4.58.0407012332040.26054@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hello
I just made second version of VRM detection code. I won't be here starting
from friday afternoon until sunday evening.

Any comments & ideas ? :)

Thanks

Regards

Rudolf

Here is produced code:

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>


typedef enum  { VRM_UNKNOWN,VRM_INTEL_8x, VRM_INTEL_85,VRM_INTEL_9x, \
VRM_INTEL_10x, VRM_INTEL_ITANIUM2,VRM_AMD_OPTERON} vrm_t;

typedef struct {
u8 vendor;
u8 eff_family;
u8 eff_model;
vrm_t vrm_type;
} vrm_models_t;
#define ANY 0xFF
vrm_models_t vrm_models[] = {
                {X86_VENDOR_AMD,0x6,ANY,VRM_INTEL_9x}, //athlon duron etc
                {X86_VENDOR_AMD,0xF,4,VRM_INTEL_9x}, //Athlon 64
                {X86_VENDOR_AMD,0xF,5,VRM_AMD_OPTERON},
                {X86_VENDOR_INTEL,0x6,0x9,VRM_INTEL_85},  /* 0.13um too */
                {X86_VENDOR_INTEL,0x6,0xB,VRM_INTEL_85},  /* 0xB Tualatin */
                {X86_VENDOR_INTEL,0x6,ANY,VRM_INTEL_8x},  /* any P6 */
                {X86_VENDOR_INTEL,0x7,ANY,VRM_UNKNOWN},   /* Itanium */
                {X86_VENDOR_INTEL,0xF,0x3,VRM_INTEL_10x}, /* P4 Prescott */
                {X86_VENDOR_INTEL,0xF,ANY,VRM_INTEL_9x},  /* P4 before
Prescott*/
                {X86_VENDOR_INTEL,0x10,ANY,VRM_INTEL_ITANIUM2} /*Itanium 2*/
                };
#define num_models (sizeof(vrm_models) / sizeof(vrm_models_t) )

vrm_t find_vrm(u8 ef,u8 em,u8 vendor) {
int i;

for (i=0;i<num_models;i++) {
    if (vrm_models[i].vendor=vendor)
       if
((vrm_models[i].eff_family=ef)&&((vrm_models[i].eff_model=ef)|| \
       ((vrm_models[i].eff_model=ANY)))) return vrm_models[i].vrm_type;
    }
return VRM_UNKNOWN;
}


static vrm_t whichVRM(void) {
struct cpuinfo_x86 *c = cpu_data;

u32 eax;
u8 f,m;

if (c->x86 < 6) return VRM_UNKNOWN; /* any CPU with familly lower than 6
                                     dont have VID and/or CPUID*/

    eax = cpuid_eax(1);
    f = ((eax & 0x00000F00)>>8);
    m = ((eax & 0x000000F0)>>4);
    if (f = 0xF) {
    f+=((eax & 0x00F00000)>>20);
    m+=((eax & 0x000F0000)>>16)<<4;
    }
return find_vrm(f,m,c->x86_vendor);

}

complete source http://ssh.cz/~ruik/cpuidvrm2.c


