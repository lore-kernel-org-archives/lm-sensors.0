From: richardvoigt@gmail.com (richardvoigt at gmail.com)
Date: Thu, 04 Jan 2007 03:34:15 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <2e59e6970701031934p1da95fc3ne5c35323aff78117@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 1/3/07, Andrew Gaydenko <a at gaydenko.com> wrote:
> Aha, applied. Thanks! - it helped. Now these sensors are visible too:
>
> coretemp-isa-0000
> Adapter: ISA adapter
> temp1:       +36?C  (high =   +85?C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> temp1:       +36?C  (high =   +85?C)
>
> And, sorry, additional questions arised.
>
> - W83627DHG shows CPU temp about 6-8 grad lower (well, and it is single sensor,
>   and I don't understand what does single sensors show :-)) rather coretemp sensors.
>   Who is more honest? It is important because ASUS P5B-VM seems to not support
>   PWM-regulating, so I have soldered PWM-controller and need to be sure CPU
>   temp is acceptable,

coretemp is measured at the hottest part of the core, while
motherboard will tend to measure the surface temperature.  A few
degrees difference is expected.  Also that's a really nice temperature
for coretemp, perhaps you have really frigid air conditioning.  My
overclocked Core2Duo (@3.4 GHz) runs coretemps of 51C idle and up to
60C under full load... which is a huge improvement from my old Athlon
MPs which were 56-65C surface temperature.

>
> - KDE's SysGuard see the only coretemp sensor. Is it SysGuard-related bug?
>

I made a patch for KSensors, I don't use SysGuard.

