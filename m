From: Owl <owl@umail.ru>
Date: Wed, 09 Feb 2011 17:12:00 +0000
Subject: Re: [lm-sensors] coretemp output changed after loading acpi_cpufreq
Message-Id: <4D52CAE0.30002@umail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D526303.6060506@umail.ru>
In-Reply-To: <4D526303.6060506@umail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

09.02.2011 19:06, Philip Pokorny пишет:
> Can you also read fan speeds?  Is there a fan on the CPU?  Some Atom
> systems have a fan on the northbridge but not on the CPU itself.
>
> Are there any other temperature sensors in the system for comparison?
At this time - no. We wait adding support of Fintek F71869FG chip (which 
is in Hans TODO list).
Anyway, I think it is not root of problem, because my system is fanless.
MB - Jetway NC9C-550-LF - http://www.jetwaycomputer.com/NC9C.html

> >  gentoo ~ # modprobe acpi_cpufreq
> >  gentoo ~ # sensors
> >  coretemp-isa-0000
> >  Adapter: ISA adapter
> >  Core 0:      +37.0°C  (crit = +100.0°C)
> >
> >  coretemp-isa-0001
> >  Adapter: ISA adapter
> >  Core 1:      +41.0°C  (crit = +100.0°C)
> >
> >  It's normal?
> >  I think, second output is much closer to BIOS values.
>
> Again, if we knew more about other sensors or fans in the system, this
> might be explained by acpi also stopping the fan when the CPU is idle
> because CPU power is known to be so low and without a fan, thermal
> margins are stil met (100degC)
If I run (after reboot), for example, cpuburn - and run commands, liste 
above, I have got same results - coretemp get values, that about 2 time 
more.
> If you don't have sensors, can you simply look or listen to the system
> when you load the acpi-cpufreq module?  Does anything change?
No.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
