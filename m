From: Philip Pokorny <ppokorny@penguincomputing.com>
Date: Wed, 09 Feb 2011 16:06:31 +0000
Subject: Re: [lm-sensors] coretemp output changed after loading acpi_cpufreq
Message-Id: <1060B264-A15E-45C1-97C9-9EC141FB2005@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D526303.6060506@umail.ru>
In-Reply-To: <4D526303.6060506@umail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org


On Feb 9, 2011, at 1:48 AM, Owl <owl@umail.ru> wrote:

> gentoo ~ # uname -a
> Linux gentoo 2.6.36-gentoo-r7 #1 SMP Fri Jan 14 14:34:23 MSK 2011  
> i686 Intel(R) Atom(TM) CPU N550 @ 1.50GHz GenuineIntel GNU/Linux
>
> gentoo ~ # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +18.0°C  (crit = +100.0°C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +22.0°C  (crit = +100.0°C)
>

Can you also read fan speeds?  Is there a fan on the CPU?  Some Atom  
systems have a fan on the northbridge but not on the CPU itself.

Are there any other temperature sensors in the system for comparison?

> gentoo ~ # modprobe acpi_cpufreq
> gentoo ~ # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +37.0°C  (crit = +100.0°C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +41.0°C  (crit = +100.0°C)
>
> It's normal?
> I think, second output is much closer to BIOS values.

Again, if we knew more about other sensors or fans in the system, this  
might be explained by acpi also stopping the fan when the CPU is idle  
because CPU power is known to be so low and without a fan, thermal  
margins are stil met (100degC)

If you don't have sensors, can you simply look or listen to the system  
when you load the acpi-cpufreq module?  Does anything change?

Phil P.

-- 
Philip Pokorny, RHCE
Chief Hardware Architect
PENGUIN COMPUTING, Inc
www.penguincomputing.com
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
