From: Sergio Bruder <sergio@bruder.com.br>
Date: Thu, 12 Jun 2008 04:35:53 +0000
Subject: Re: [lm-sensors] v1211 fan control
Message-Id: <F592A20D-C627-43FD-B459-197603CF8912@bruder.com.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
In-Reply-To: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

working on it as I mail that response!

Em 09/06/2008, =E0s 18:48, Juerg Haefliger escreveu:

> Sure, as soon as I get the requested dumps from Sergio.
>
> ...juerg
>
>
> On Mon, Jun 9, 2008 at 2:22 PM, Daniel Lucio <lucio@eecs.utk.edu> =20
> wrote:
>> Juerg,
>>
>> can you please share witow us how do you calculate the correct =20
>> values for
>> the conversion that goes into sensors.conf by using the data from =20
>> 'grep ""
>> /sys/class/hwmon/hwmon*/device/temp?_input'?
>>
>> Thank you!
>>
>> Daniel.
>>
>>
>> On Jun 5, 2008, at 11:02 AM, Juerg Haefliger wrote:
>>
>>> Hi Sergio,
>>>
>>>
>>>> root@nimbus:~# ~sergio/cpuid
>>>> eax in    eax      ebx      ecx      edx
>>>> 00000000 00000001 746e6543 736c7561 48727561
>>>> 00000001 000006a9 00010800 00000181 a7c9bbff
>>>> 80000000 80000006 00000000 00000000 00000000
>>>> 80000001 00000000 00000000 00000000 00100000
>>>> 80000002 20202020 20202020 20202020 20202020
>>>> 80000003 56202020 45204149 65687473 72702072
>>>> 80000004 7365636f 20726f73 30303031 007a484d
>>>> 80000005 00000000 08800880 40040140 40040140
>>>> 80000006 00000000 00000000 0080a140 00000000
>>>> c0000000 c0000002 00000000 00000000 00000000
>>>> c0000001 00000000 00000000 00000000 00003fcc
>>>> c0000002 00003b00 080c0810 08100a13 42000000
>>>>
>>>> Vendor ID: "CentaurHauls"; CPUID level 1
>>>>
>>>> Unknown vendor
>>>
>>> Ah very good! Now can you please run cpuid and 'grep ""
>>> /sys/class/hwmon/hwmon*/device/temp?_input' in close succession a
>>> couple of times (maybe 5 times with a couple of secs in between) =20
>>> while
>>> the system is idle and then again while the system is busy (by =20
>>> running
>>> cpuburn for example)? This should allow me to calculate the correct
>>> values for the conversion that goes into sensors.conf.
>>>
>>>
>>>>> 3) What is the rev of your vt1211? It's printed in the kernel =20
>>>>> log during
>>>>> module load.
>>>>> Your board is the first that I see that actually has the vt1211
>>>>> controlling the Fans.
>>>>> Interesting.
>>>>
>>>> # dmesg | grep vt1211
>>>> [   91.562775] vt1211: Found VT1211 chip at 0x6000, revision 2
>>>
>>> Nothing special here.
>>>
>>>
>>>>> 4) Can you try to manually control the fans? Write 1 to =20
>>>>> pwmX_enable
>>>>> (where X is the
>>>>> number of the pwm controller that controls the CPU fan). And =20
>>>>> then try
>>>>> writing different
>>>>> values in the range 0-255 to pwmX. The fan RPMs hopefully change
>>>>> accordingly.
>>>>
>>>> # echo 1 > pwm2_enable
>>>> -su: echo: write error: Invalid argument
>>>> # cat pwm2_enable
>>>> 0
>>>
>>> My bad. Manual mode was never implemented as it doesn't seem to =20
>>> work.
>>>
>>>
>>>> Ive just verified that pwm1_enable and pwm2_enable controls the =20
>>>> same fan,
>>>> fan2 in my case (cpu fan).
>>>>
>>>> echo 2 > pwm2_enable and echo 1 > pwm1_enable turn that fan off.
>>>
>>> Either of this command enables the fan auto controller in the =20
>>> vt1211.
>>> As I mentioned earlier, there is only a single controller that =20
>>> affects
>>> both PWM outputs.
>>>
>>> ...juerg
>>>
>>> _______________________________________________
>>> lm-sensors mailing list
>>> lm-sensors@lm-sensors.org
>>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
