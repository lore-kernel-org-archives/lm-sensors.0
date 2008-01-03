From: "Kessia Pinheiro" <kessiapinheiro@gmail.com>
Date: Thu, 03 Jan 2008 14:50:04 +0000
Subject: Re: [lm-sensors] no sensors were detected with Intel Corporation
Message-Id: <c8faca170801030650v355671f5wcbc5a1a5f0e8b600@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
In-Reply-To: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> OK, so it was indeed an index/data pair. Now, if some of these register
> values correspond to sensors, their values should change a little over
> time. Try running the same isadump command a few seconds apart and see
> if some values change. Do that while the fan is spinning, otherwise you
> might miss it. Also try with and without CPU load to increase the
> chances to spot a change.

I execute some times "isadump 0x910 0x911" and got differents values, like:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 59 ff 00 00 01 27 80 4c 00 00 00 07 37 39 37 39
90: 02 00 00 00 00 00 00 08 00 00 00 00 00 00 00 1e
a0: 00 01 00 62 00 00 a9 30 50 14 b8 0b 0a 47 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


and

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 23 00 00 00 01 27 80 4c 00 00 00 07 37 39 37 39
90: 02 00 00 00 80 00 00 08 00 00 00 00 00 00 00 43
a0: 00 01 00 62 00 00 a9 30 50 14 b8 0b 0a 47 32 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



> Note that the register map above looks like what the LPC47N252
> datasheet describes. The bad news is that the chip does only fan speed
> monitoring and control. On top of that, the fan speeds cannot be read
> directly from the I/O space, so I don't even know how we would write a
> driver. Someone would need to take a deeper look at the datasheet, I
> don't have the time myself.
>
> I also think that it would be worth taking a look at the ACPI
> implementation of your laptop to see what they are doing with
> temperatures and fans. We don't want to interfere with that. Can you
> read the temperature using acpi?

Can i read:

processor/CPU0:
info  limit  power  throttling

# cat processor/CPU0/*
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      yes
limit interface:         yes
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
active state:            C3
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 6666 usec
states:
    C1:                  type[C1] promotion[C2] demotion[--]
latency[001] usage[00000040] duration[00000000000000000000]
    C2:                  type[C2] promotion[C3] demotion[C1]
latency[001] usage[00023260] duration[00000000000211173996]
   *C3:                  type[C3] promotion[--] demotion[C2]
latency[017] usage[01032996] duration[00000000014670215004]
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%


thermal_zone/THM:
cooling_mode  polling_frequency  state  temperature  trip_points

# cat thermal_zone/THM/*
<setting not supported>
<polling disabled>
state:                   ok
temperature:             40 C
critical (S5):           99 C


video/VID:
CRT  DOS  DVI  LCD  POST  POST_info  ROM  TV  info

video/VID1:
CRT  DOS  DVI  LCD  POST  POST_info  ROM  TV  info

video/VID2:
DOS  POST  POST_info  ROM  info

-- 
Kessia Pinheiro
Bacharelanda em Ciência da Computação
Universidade Federal da Bahia
Linux Counter User #389695 [http://counter.li.org]
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
