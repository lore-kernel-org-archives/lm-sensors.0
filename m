From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <40E98944.7010000@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

what's the easiest way to build this to test on 2.6?

Rudolf Marek wrote:
>>Yes, use 100. That's already what MDS did if I'm not mistaking.
> 
> 
> done
> 
> 
>>Yes, it's definitely compile-time stuff. You compile for a given
>>architecture anyway! So what you did is fine.
> 
> 
> Ok in attach, version that can be used for testing. It is using the
> numerical VRM, "while" instead of "for" in lookup func and other changes
> proposed by you. I think this is the end of email storm :)
> 
> 
> Regards
> 
> Rudolf
> 
> 
> ------------------------------------------------------------------------
> 
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/kernel.h>
> 
> typedef struct {
> u8 vendor;
> u8 eff_family;
> u8 eff_model;
> int vrm_type;
> } vrm_models_t;
> #define ANY 0xFF
> 
> #ifdef CONFIG_X86
> 
> vrm_models_t vrm_models[] = {
> 		{X86_VENDOR_AMD,0x6,ANY,90}, /*athlon duron etc*/
> 		{X86_VENDOR_AMD,0xF,0x4,90}, /*Athlon 64*/
> 		{X86_VENDOR_AMD,0xF,0x5,24}, /* Opteron*/
> 		{X86_VENDOR_INTEL,0x6,0x9,85},  /* 0.13um too */
> 		{X86_VENDOR_INTEL,0x6,0xB,85},  /* 0xB Tualatin */
> 		{X86_VENDOR_INTEL,0x6,ANY,82},  /* any P6 */
> 		{X86_VENDOR_INTEL,0x7,ANY,00},   /* Itanium */
> 		{X86_VENDOR_INTEL,0xF,0x3,100}, /* P4 Prescott */
> 		{X86_VENDOR_INTEL,0xF,ANY,90},  /* P4 before Prescott */
> 		{X86_VENDOR_INTEL,0x10,ANY,00}, /*Itanium 2*/
> 		{X86_VENDOR_UNKNOWN,ANY,ANY,00} /* stop here */
> 		};
> 
> static int find_vrm(u8 eff_family,u8 eff_model,u8 vendor) {
> int i=0;
> 
> while (vrm_models[i].vendor!=X86_VENDOR_UNKNOWN) {
>     if (vrm_models[i].vendor=vendor)
>        if ((vrm_models[i].eff_family=eff_family)&& \
>           ((vrm_models[i].eff_model=eff_model)|| \
> 	   (vrm_models[i].eff_model=ANY))) return vrm_models[i].vrm_type;
>     i++;
> }    
> 
> return 00;
> }
> 
> 
> int which_vrm(void) {
> struct cpuinfo_x86 *c = cpu_data;
> u32 eax;
> u8 eff_family,eff_model;
> 
> if (c->x86 < 6) return 00; /* any CPU with familly lower than 6
> 				     dont have VID and/or CPUID*/
> 
>     eax = cpuid_eax(1);
>     eff_family = ((eax & 0x00000F00)>>8);
>     eff_model  = ((eax & 0x000000F0)>>4);
>     if (eff_family = 0xF) {	 /* use extended model & familly */
>     eff_family+=((eax & 0x00F00000)>>20);   /*compute effective family */
>     eff_model+= ((eax & 0x000F0000)>>16)<<4; /*compute effective model */
>     }
> return find_vrm(eff_family,eff_model,c->x86_vendor);
> 
> }
> /* and now something completely different for Non-x86 world*/
> #else 
> int which_vrm(void) {
> return 00;
> }
> #endif
> 
>     static int hello_init(void)
>     {
>         printk(KERN_ALERT "Hello, world %d\n",which_vrm());
>         return 0;
>     }
> 
>     static void hello_exit(void)
>     {
>         printk(KERN_ALERT "Goodbye, cruel world\n");
>     }
> 
>     module_init(hello_init);
>     module_exit(hello_exit);
>    MODULE_LICENSE("GPL");    
