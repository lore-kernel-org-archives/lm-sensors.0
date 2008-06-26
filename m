From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 26 Jun 2008 15:26:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <191fb4ca0806260826x583d02f9x100a8afd4053099c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


> Hi Juerg,
>
> On Thu, 19 Jun 2008 16:20:34 -0700, Juerg Haefliger wrote:
>> New driver to support temperature and voltage sensors embedded inside
>> the VIA C7 CPU.
>
> Is it really an analog voltage sensor? Or does it simply reflect the
> value of the VID pins? The conversion formula "(data->in << 4) + 700"
> corresponds to VRM case 13 in hwmon-vid.c, which is what the C7 uses.
> This makes me suspect that the latter is true. If I am right then the
> attribute should be named cpuN_vid rather than in0_input.

The datasheet states that this register value is a copy of the MSR
0x198 value (performance status register). The bios writting guide
labels 0x198 as 'current value'  whereas MSR 0x199 (performance
control register) is labeled as 'desired value'. Unless I'm
misinterpreting taiwanese english, I'd say it's a measured value :-)

...juerg



> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
