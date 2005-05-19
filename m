From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I finally finished some code to detect correct VRM using CPUID.

What the code does?

If AMD
    /*Duron&Ahlon has VRM 9x*/
    if Opteron  VRM_AMD_OPTERON
If INTEL
     FOR /* P6 Family */
         ret = VRM_INTEL_8x;
         but  /* 0xB Tualatin */ and maybe  /* 0x9 ????? it has 0.13um */
         has   ret = VRM_INTEL_85;
     FOR p4 Family
         everything except model 3 has  ret = VRM_INTEL_9x;
         model 3 is prescott 90nm it has VRD 10 (my name is   ret         VRM_INTEL_10x;   /* 0x3 prescott */)
ELSE
  VRM_NONE

I belive this is correct.

You can get it here:

http://ssh.cz/~ruik/cpuidvrm.c
http://ssh.cz/~ruik/Makefile
make -C /usr/src/linux-2.6.6 SUBDIRS=$PWD modules


Cut & paste from relevant part of source will follow at the end of this
message.

What is needed now ?

0) review by people here
1) test the code for different processors, mainly see if Tualatin is
working and opteron. Simply insmod the module and see
the output VRM_NONE = 0 etc..
2) how to or who will incorporate this into the drivers? (Khali maybe?)

3) Little problem:
//Linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h
#define CPUID_PROCESSOR_SIGNATURE             1 /* function 1
*/
#define OPTERON_XFAM_MOD             0x00000f50 /* xtended fam, fam +
model */
#define CPUID_XFAM_MOD               0x0ff00ff0 /* xtended fam, fam +
model */

I need this from that header file but dont know how to get it clever way.


Thats all for now. Comments wellcome.

Thanks

Regards

Rudolf

C0re code:

typedef enum  { VRM_NONE,VRM_INTEL_8x, VRM_INTEL_85,VRM_INTEL_9x,
VRM_INTEL_10x,,VRM_AMD_OPTERON} vrm_t;


static vrm_t whichVRM(void) {
vrm_t ret=VRM_NONE;
struct cpuinfo_x86 *c = cpu_data;
u32 eax;

 if (c->x86_vendor = X86_VENDOR_AMD) {

    if (c->x86 = 6) {
    /*Duron&Ahlon has VRM 9x*/
    ret = VRM_INTEL_9x;
    } else

    {
    eax = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
    if ((eax & CPUID_XFAM_MOD) = OPTERON_XFAM_MOD) {
        /* opteron */
        ret = VRM_AMD_OPTERON; }
    }
 }
 else if (c->x86_vendor = X86_VENDOR_INTEL) {

    if (c->x86=6) {
    /* P6 Family */
    ret = VRM_INTEL_8x;


    if ((c->x86_model = 0xB) || (c->x86_model = 0x9)) {
    ret = VRM_INTEL_85;   /* 0x9 ????? it has 0.13um */
                        /* 0xB Tualatin */
    }

    } else if (c->x86=0xF) {
    /*P4 family*/
    ret = VRM_INTEL_9x;
        if (c->x86_model = 3) {
            ret = VRM_INTEL_10x;   /* 0x3 prescott */
        }
    }
 } else {
 ret = VRM_NONE;
 }

return ret;
}
