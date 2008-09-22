From: "David Balnaves" <david@utopia.cable.nu>
Date: Mon, 22 Sep 2008 03:54:50 +0000
Subject: Re: [lm-sensors] unknown VRM version
Message-Id: <946986989C244B1FAD3FA353617F9B3E@gamma>
List-Id: <lm-sensors.vger.kernel.org>
References: <45E76B64FBD6468F9A21FC6ED504138D@gamma>
In-Reply-To: <45E76B64FBD6468F9A21FC6ED504138D@gamma>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the reply.

wintermute:~# uname -r
2.6.20.3-ubuntu1

wintermute:~# cat /proc/cpuinfo
processor : 0
vendor_id : Geode by NSC
cpu family      : 5
model   : 9
model name      : Unknown
stepping  : 1
cpu MHz   : 266.648
fdiv_bug  : no
hlt_bug   : no
f00f_bug  : no
coma_bug  : no
fpu    : yes
fpu_exception   : yes
cpuid level     : 2
wp     : yes
flags   : fpu tsc msr cx8 cmov mmx cxmmx
bogomips  : 533.87
clflush size    : 32

-- 
David Balnaves

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "David" <david@utopia.cable.nu>
Cc: <lm-sensors@lm-sensors.org>
Sent: Monday, September 22, 2008 12:39 AM
Subject: Re: [lm-sensors] unknown VRM version


> Hi David,
>
> On Fri, 19 Sep 2008 07:39:47 +1000, David wrote:
>> Hi,
>>
>> I'm running sensors on a Soekris net4801.
>>
>> As you can see it seems to be reporting properly:
>> wintermute:/var/log# sensors
>> pc87366-isa-6620
>> Adapter: ISA adapter
>> VCORE:     +2.06 V  (min =  +1.90 V, max =  +2.10 V)
>> VCC:       +5.13 V  (min =  +0.00 V, max =  +6.03 V)
>> VPWR:     +25.41 V  (min =  +5.93 V, max = +28.02 V)
>> +12V:     +12.22 V  (min = +11.02 V, max = +13.01 V)
>> -12V:     -11.86 V  (min = -13.01 V, max = -10.95 V)
>> GND:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
>> Vsb:       +3.36 V  (min =  +3.00 V, max =  +3.59 V)
>> Vdd:       +3.38 V  (min =  +3.00 V, max =  +3.59 V)
>> Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
>> AVdd:      +3.33 V  (min =  +3.00 V, max =  +3.59 V)
>> Temp:        +55 C  (low  =    +0 C, high =   +70 C)
>> Critical:    +85 C
>>
>> The problem that I have is that my log files fill with this error:
>> hwmon-vid: requested unknown VRM version
>>
>> Can somebody please tell me what this is complaining about, how to 
>> resolve
>> it, or at the very least supress the message from occuring in dmesg.
>
> Please tell us what kernel version you are using (uname -r) and provide
> the contents of /proc/cpuinfo for that machine.
>
> -- 
> Jean Delvare
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
