From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <Pine.LNX.4.58.0407021001220.26054@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Fri, 2 Jul 2004, Jean Delvare wrote:

>
> >typedef struct {
> >u8 vendor;
> >u8 eff_family;
> >u8 eff_model;
> >vrm_t vrm_type;
> >} vrm_models_t;
> >#define ANY 0xFF
>
> What is 0xFF is ever a valid value for eff_model?

No, model is 4 bit :)

>
> >vrm_models_t vrm_models[] = {
> >                {X86_VENDOR_AMD,0x6,ANY,VRM_INTEL_9x}, //athlon duron etc
> >                {X86_VENDOR_AMD,0xF,4,VRM_INTEL_9x}, //Athlon 64
> >                {X86_VENDOR_AMD,0xF,5,VRM_AMD_OPTERON},
> >                {X86_VENDOR_INTEL,0x6,0x9,VRM_INTEL_85},  /* 0.13um too */
> >                {X86_VENDOR_INTEL,0x6,0xB,VRM_INTEL_85},  /* 0xB Tualatin */
> >                {X86_VENDOR_INTEL,0x6,ANY,VRM_INTEL_8x},  /* any P6 */
> >                {X86_VENDOR_INTEL,0x7,ANY,VRM_UNKNOWN},   /* Itanium */
> >                {X86_VENDOR_INTEL,0xF,0x3,VRM_INTEL_10x}, /* P4 Prescott */
> >                {X86_VENDOR_INTEL,0xF,ANY,VRM_INTEL_9x},  /* P4 before
> >Prescott*/
> >                {X86_VENDOR_INTEL,0x10,ANY,VRM_INTEL_ITANIUM2} /*Itanium 2*/
> >                };
> >#define num_models (sizeof(vrm_models) / sizeof(vrm_models_t) )
>
> I think that the usual practice for this kind of lookup tables is to have
> an "empty" final line and rely on it to detect the end of the table.
> Your method looks OK too, but maybe there's a reason why kernel folks
> seem to prefer the empty last line?

I will take a look to kernel code.

>
> >vrm_t find_vrm(u8 ef,u8 em,u8 vendor) {
> >int i;
> >
> >for (i=0;i<num_models;i++) {
> >    if (vrm_models[i].vendor=vendor)
> >       if
> >((vrm_models[i].eff_family=ef)&&((vrm_models[i].eff_model=ef)|| \
>
>                                                              ^^
>                                                              em
>
oops :)  I tested only the ANY case for this PII Thanks.

> >       ((vrm_models[i].eff_model=ANY)))) return vrm_models[i].vrm_type;
> >    }
> >return VRM_UNKNOWN;
> >}
>
> >static vrm_t whichVRM(void) {
> >struct cpuinfo_x86 *c = cpu_data;
> >
> >u32 eax;
> >u8 f,m;
>
> Please use longer variable names in the final code. Short varible names
> make the code harder to read.

I will do.
>
> >    eax = cpuid_eax(1);
> >    f = ((eax & 0x00000F00)>>8);
> >    m = ((eax & 0x000000F0)>>4);
> >    if (f = 0xF) {
> >    f+=((eax & 0x00F00000)>>20);
>
> No <<4 here?


No according to AMD paper is family "additive", model is "concat" so
thatswhy it is shifted by 4;

> >    m+=((eax & 0x000F0000)>>16)<<4;
> >    }
> >return find_vrm(f,m,c->x86_vendor);
>
> Looks overwise really good,

I'm not sure if we can leave 0x000F0000 such things there...

>I'll test this on as many systems as
> possible soon.
>
Ok thank you.

Rudolf
