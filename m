From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 05 Jun 2008 15:02:08 +0000
Subject: Re: [lm-sensors] v1211 fan control
Message-Id: <191fb4ca0806050802n1a1d34b7xad91a64e59920524@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
In-Reply-To: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergio,


> root@nimbus:~# ~sergio/cpuid
>  eax in    eax      ebx      ecx      edx
> 00000000 00000001 746e6543 736c7561 48727561
> 00000001 000006a9 00010800 00000181 a7c9bbff
> 80000000 80000006 00000000 00000000 00000000
> 80000001 00000000 00000000 00000000 00100000
> 80000002 20202020 20202020 20202020 20202020
> 80000003 56202020 45204149 65687473 72702072
> 80000004 7365636f 20726f73 30303031 007a484d
> 80000005 00000000 08800880 40040140 40040140
> 80000006 00000000 00000000 0080a140 00000000
> c0000000 c0000002 00000000 00000000 00000000
> c0000001 00000000 00000000 00000000 00003fcc
> c0000002 00003b00 080c0810 08100a13 42000000
>
> Vendor ID: "CentaurHauls"; CPUID level 1
>
> Unknown vendor

Ah very good! Now can you please run cpuid and 'grep ""
/sys/class/hwmon/hwmon*/device/temp?_input' in close succession a
couple of times (maybe 5 times with a couple of secs in between) while
the system is idle and then again while the system is busy (by running
cpuburn for example)? This should allow me to calculate the correct
values for the conversion that goes into sensors.conf.


>> 3) What is the rev of your vt1211? It's printed in the kernel log during module load.
>> Your board is the first that I see that actually has the vt1211 controlling the Fans.
>> Interesting.
>
> # dmesg | grep vt1211
> [   91.562775] vt1211: Found VT1211 chip at 0x6000, revision 2

Nothing special here.


>> 4) Can you try to manually control the fans? Write 1 to pwmX_enable (where X is the
>> number of the pwm controller that controls the CPU fan). And then try writing different
>> values in the range 0-255 to pwmX. The fan RPMs hopefully change accordingly.
>
> # echo 1 > pwm2_enable
> -su: echo: write error: Invalid argument
> # cat pwm2_enable
> 0

My bad. Manual mode was never implemented as it doesn't seem to work.


> Ive just verified that pwm1_enable and pwm2_enable controls the same fan, fan2 in my case (cpu fan).
>
> echo 2 > pwm2_enable and echo 1 > pwm1_enable turn that fan off.

Either of this command enables the fan auto controller in the vt1211.
As I mentioned earlier, there is only a single controller that affects
both PWM outputs.

...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
