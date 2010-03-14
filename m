From: lmsensorslist@nodivisions.com
Date: Sun, 14 Mar 2010 14:41:16 +0000
Subject: Re: [lm-sensors] Wrong temperatures reported for Core2Duo CPU in
Message-Id: <78b73eb5d6cf2aee78a7c44bebd51b8c.squirrel@webmail.nodivisions.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
In-Reply-To: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>> Sorry for the double-post, but I meant to re-iterate just
>> for completeness' sake: the idle/loaded temps reported by
>> lm-sensors+coretemp under Linux are ~73C/93C, in contrast
>> to the lower temperatures reported by the 3 Windows apps
>> mentioned above.
>
> Thinking in relative terms, your system is running under Windows at -31
> idle and -10 under heavy load; Linux at -27 idle and -7 under heavy
> load. So the bottom line is that your system runs hotter in Linux than
> Windows. You should check if you have services running that suck your
> CPU, or, if you self-built your kernel, if you missed some CPU-related
> options such as CONFIG_CPU_IDLE, ACPI, etc. And also make sure you have
> the acpi_cpufreq and cpufreq_conservative drivers loaded and used. The
> "powertop" utility might come in handy to track such issues.
>
> The 20=B0C difference between idle and heavy load seems reasonable, my own
> mobile Core Duo CPU has an even larger difference (37=B0C!). The 7=B0C
> margin is more problematic, but that being said, I just checked mine
> and it's running only 12=B0C below the limit under heavy load... That's
> not so different from yours. So maybe these CPUs really run hot and so
> be it.

That makes sense.  And yeah, I do generally have tons of stuff running
under Linux, so the system doesn't spend much time being entirely idle.

Well I've just upgraded my PC's case to this one:

http://www.newegg.com/Product/Product.aspx?Item=3DN82E16811233049

It's nothing super fancy, but it does have one of those side-vents with a
duct going straight to the CPU, and it also has a 120mm rear exhaust fan
(plus a spot in the front for an intake fan).  My old case was a nice,
solid In-Win case, but it was about 10 years old, and had no case fans at
all -- not even spots for them -- and the CPU's fan was almost right
against the side of the PSU.  So cooling in there was pretty suboptimal.

This new case is a huge improvement: my CPU is idling around 63-65C now,
compared to 73-75C in the old case.  Under load it goes as high as the
mid-80s, not into the 90s as in the old case.

I'd like it to be even cooler, and will probably get a front intake fan
next, but I'm really happy with this upgrade, especially because it's
solved my main complaint: the fan noise.  It's super quiet now because the
CPU fan and rear case fan are spinning pretty slowly, and only rarely
speed up -- as opposed to the CPU fan being obnoxious nearly 24/7 in the
old case.

--
Anthony DiSante
http://nodivisions.com/



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
