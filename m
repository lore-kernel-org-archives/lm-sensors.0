From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 Jun 2013 12:04:49 +0000
Subject: Re: [lm-sensors] inaccurate fan speed
Message-Id: <20130629140449.5eb572c3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+Ei6tk5vue20Ga9qoRrDDkxUxHU08QUrWAkXWogx562VzpQ+w@mail.gmail.com>
In-Reply-To: <CA+Ei6tk5vue20Ga9qoRrDDkxUxHU08QUrWAkXWogx562VzpQ+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Earl,

On Fri, 28 Jun 2013 08:34:26 -0600, earl middlebrook wrote:
> On Fri, Jun 21, 2013 at 4:16 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > First you should ensure that all power saving options are enabled.
> >
> > For the CPU, these are C states and cpufreq (although the usefulness of
> > cpufreq with good C states can be discussed.) Please install powertop,
> > then check the Idle stats and Frequency stats panels (use the Tab key
> > to navigate between these in recent versions of powertop.) You should
> > see multiple C states in the first and multiple frequencies in the
> > second.
> >
> > When the machine is idle, the CPU should spend most of the time at the
> > lowest C states and the lowest frequency. If this isn't the case then
> > something is wrong, either in the BIOS or in the kernel.
> 
> Here are Idle stats from PowerTOP:
> 
> **  Package              |             Core          |             CPU
> 0               CPU 2
>                              |                             | C0 active
> 4.5%                0.5%
>                              |                             | POLL
> 0.0%    0.0 ms      0.0%    0.0 ms
>                              |                             | C1-NHM
> 0.0%    0.0 ms      0.0%    0.0 ms
> C3 (pc3)   16.9%    | C3 (cc3)   15.0%    | C3-NHM      3.8%    0.9 ms
> 12.8%   32.3 ms
> C6 (pc6)   59.9%    | C6 (cc6)   76.3%    | C6-NHM     89.3%    3.7 ms
> 86.3%    4.0 ms
> 
>                              |             Core          |             CPU
> 1               CPU 3
>                              |                              | C0 active
> 1.6%                0.9%
>                              |                              | POLL
> 0.0%    0.0 ms      0.0%    0.0 ms
>                              |                              | C1-NHM
> 0.0%    0.0 ms      0.0%    0.0 ms
>                              | C3 (cc3)    8.5%      | C3-NHM      4.3%
> 1.1 ms      5.3%    2.3 ms
>                              | C6 (cc6)   86.0%     | C6-NHM     92.7%
> 3.3 ms     93.2%    3.3 ms

This looks reasonable, most time is spent in deepest C state (C6.)

> Here are Frequency Stats:
> 
> Package |             Core    |            CPU 0       CPU 2
>                     |                     | Actual    2.0 Ghz     1.8 Ghz
> Turbo Mode  14.8%   | Turbo Mode  12.8%   | Turbo Mode  12.5%        5.3%
> 2.40 Ghz     0.0%   | 2.40 Ghz     0.0%   | 2.40 Ghz     0.0%        0.0%
> 2.27 Ghz     0.1%   | 2.27 Ghz     0.1%   | 2.27 Ghz     0.1%        0.0%
> 2.14 Ghz     0.0%   | 2.14 Ghz     0.0%   | 2.14 Ghz     0.0%        0.0%
> 2.00 Ghz     0.0%   | 2.00 Ghz     0.0%   | 2.00 Ghz     0.0%        0.0%
> 1.87 Ghz     0.0%   | 1.87 Ghz     0.0%   | 1.87 Ghz     0.0%        0.0%
> 1.74 Ghz     0.9%   | 1.74 Ghz     0.6%   | 1.74 Ghz     0.5%        0.3%
> 1.60 Ghz     0.0%   | 1.60 Ghz     0.0%   | 1.60 Ghz     0.0%        0.0%
> 1466 Mhz     0.0%   | 1466 Mhz     0.0%   | 1466 Mhz     0.0%        0.0%
> 1333 Mhz     0.1%   | 1333 Mhz     0.0%   | 1333 Mhz     0.0%        0.0%
> 
>                     |             Core    |            CPU 1       CPU 3
>                     |                     | Actual    1.8 Ghz     1.8 Ghz
>                     | Turbo Mode  10.9%   | Turbo Mode  10.2%        8.7%
>                     | 2.40 Ghz     0.0%   | 2.40 Ghz     0.0%        0.0%
>                     | 2.27 Ghz     0.1%   | 2.27 Ghz     0.1%        0.0%
>                     | 2.14 Ghz     0.0%   | 2.14 Ghz     0.0%        0.0%
>                     | 2.00 Ghz     0.0%   | 2.00 Ghz     0.0%        0.0%
>                     | 1.87 Ghz     0.0%   | 1.87 Ghz     0.0%        0.0%
>                     | 1.74 Ghz     0.8%   | 1.74 Ghz     0.8%        0.8%
>                     | 1.60 Ghz     0.0%   | 1.60 Ghz     0.0%        0.0%
>                     | 1466 Mhz     0.0%   | 1466 Mhz     0.0%        0.0%
>                     | 1333 Mhz     0.1%   | 1333 Mhz     0.0%        0.0%

On my own system there is a last line, "Idle", where most time is
spent. I am surprised you don't have it. The total is way less than
100% so I can only guess that the rest of the time is spent in Idle
state. If this is the case then it's all OK.

> Noticed this in Tunables:
> >> Good          Using 'ondemand' cpufreq governor
> 
> Could I try to toggle it and see if there is a conflict?

No, that's the other way around. "Good" means that powertop thinks this
is a good thing with regards to power consumption (and I would agree,
even though deep C states save more power than frequency scaling on
recent Intel CPU.) The lines you should investigate are the "bad" ones. I
have many of these on my own system, BTW :(

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
