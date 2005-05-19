From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Problems with W83791D driver
Message-Id: <3EDBE012.2060503@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED99C0B.9040006@penguincomputing.com>
In-Reply-To: <3ED99C0B.9040006@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Done.
Take your time on ADM1026.
There's a lot more broken then I'd realized. This will take a couple of weeks.

Philip Pokorny wrote:
> Yes, please use the following patch to update w83781d.c to get it ready 
> for automatic sensors.h...
> 
> Index: kernel/chips/w83781d.c
> =================================> RCS file: /home/cvs/lm_sensors2/kernel/chips/w83781d.c,v
> retrieving revision 1.99
> diff -u -r1.99 w83781d.c
> --- kernel/chips/w83781d.c    31 Jan 2003 04:00:33 -0000    1.99
> +++ kernel/chips/w83781d.c    2 Jun 2003 06:55:03 -0000
> @@ -426,9 +426,14 @@
>  #define W83781D_SYSCTL_IN6 1006
>  #define W83781D_SYSCTL_IN7 1007
>  #define W83781D_SYSCTL_IN8 1008
> +#define W83781D_SYSCTL_IN9 1009
> +
>  #define W83781D_SYSCTL_FAN1 1101    /* Rotations/min */
>  #define W83781D_SYSCTL_FAN2 1102
>  #define W83781D_SYSCTL_FAN3 1103
> +#define W83781D_SYSCTL_FAN4 1104
> +#define W83781D_SYSCTL_FAN5 1105
> +
>  #define W83781D_SYSCTL_TEMP1 1200    /* Degrees Celcius * 10 */
>  #define W83781D_SYSCTL_TEMP2 1201    /* Degrees Celcius * 10 */
>  #define W83781D_SYSCTL_TEMP3 1202    /* Degrees Celcius * 10 */
> 
> 
> I should have the ADM1026 patch for you sometime on Monday.  To test it 
> I'm having to compile on a new machine since my previous development 
> machine was a 2.4.7 kernel and it just doesn't work with lm_sensors-cvs...
> 
> But I'm finding lots of compile problems with I2C and LM_SENSORS.  And 
> then even if it does compile, it won't load on the machine I'm testing 
> with because of module_put and try_module_get unresolved symbols...
> 
> :v)
> 
> Mark D. Studebaker wrote:
> 
>> I have the answers :)
>>
>> We recently got a patch for adding 791D support to the w83781d driver.
>> The library part of it applied easily and I checked it in.
>> The driver part was against stock 2.7.0 and didn't apply so I asked
>> the person to send us a patch against CVS, which I haven't received yet.
>> So that's why it's in a halfway state.
>>
>> The w83627hf driver is an ISA-only driver for the 627hf and 697hf 
>> Super I/O chips.
>> It contains code to find and enable the ISA I/O for the sensors.
>> The support for these chips in w83781d is, for the most part, I2C-only.
>> Many many people have had problems getting these chips to work on the 
>> I2C side
>> using w83781d. There's many tickets on helper functions to get the 
>> sensors enabled. ISA accesses will be much more dependable.
>> Rather than add more gunk to an already-messy w83781d, I copied
>> it to a new w83627hf driver and cleaned it up.
>>
>> I like your idea about an automatic sensors.h a lot.
>>
>> I guess some of our practices of reusing SYSCTL numbers and other stuff
>> (bmcsensors comes to mind) may be making it more complicated.
>>
>> Do you want me to check the new SYSCTL for 791D into the w83781d driver
>> so that doesn't cause problems for your on-the-fly creation?
>>
>>
>> Philip Pokorny wrote:
>>
>>> I'm working on my ADM1026 patch for CVS and I've decided to work in 
>>> something else that was bugging me.
>>>
>>> Namely, the change in kernel/include/sensors.h that means the 
>>> #define's are duplicated in sensors.h and in the individual drivers.  
>>> It's bugged me since I first heard about it.
>>>
>>> I've modified the Module.mk in kernel/include to create sensors.h on 
>>> the fly from the SYSCTL START/END stuff in each of the chips/*.c files.
>>>
>>> It works great, except that the following #defines existed in the 
>>> original sensors.h but not in any of the kernel/chips/*.c files.  The 
>>> real problem though is that they *are* referenced in lib/chips.c!!!
>>>
>>> lib/chips.c:1218: `W83781D_SYSCTL_IN9' undeclared here (not in a 
>>> function)
>>> lib/chips.c:1248: `W83781D_SYSCTL_IN9' undeclared here (not in a 
>>> function)
>>> lib/chips.c:1278: `W83781D_SYSCTL_IN9' undeclared here (not in a 
>>> function)
>>> lib/chips.c:1286: `W83781D_SYSCTL_FAN4' undeclared here (not in a 
>>> function)
>>> lib/chips.c:1288: `W83781D_SYSCTL_FAN5' undeclared here (not in a 
>>> function)
>>> lib/chips.c:1300: `W83781D_SYSCTL_FAN4' undeclared here (not in a 
>>> function)
>>> lib/chips.c:1303: `W83781D_SYSCTL_FAN5' undeclared here (not in a 
>>> function)
>>>
>>> These seem to be associated with the W837_9_1D support that was 
>>> recently? commited.
>>>
>>> Which leads to the next question which is...  Which chip driver 
>>> actually implements support for the W83791D?  A grep for w83791d 
>>> doesn't turn up any *actual* support...
>>>
>>> [root@eng184 lm_sensors2]# find . -type f -print | xargs grep w83791d
>>> ./CHANGES:           add lm85 support; add w83791d support
>>> ./CHANGES:  Program sensors: add lm85 support; add w83791d support
>>> ./lib/chips.c:static sensors_chip_feature w83791d_features[] >>> ./lib/chips.c: { SENSORS_W83791D_PREFIX, w83791d_features },
>>> ./lib/chips.h:#define SENSORS_W83791D_PREFIX "w83791d"
>>> ./prog/sensors/main.c:           (!strcmp(name.prefix,"w83791d")) ||
>>>
>>> Which driver is supposed to support this chip?
>>>
>>> And finally, why do both the w83627hf.c and w83781d.c drivers exist.  
>>> They use the *same* list of #define entries (W83781D) and appear to 
>>> be 80% or more identical.  I know that the w83781d driver is 
>>> complicated, but when did the w83627hf driver get created and what 
>>> does it support?  The w83781d driver has "kind" types for the 627hf 
>>> and 697hf which are they only kinds in the other driver.
>>>
>>> :v)
>>>
>>
> 
> 
