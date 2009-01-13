From: "Lauri Kasanen" <curaga@operamail.com>
Date: Tue, 13 Jan 2009 10:49:11 +0000
Subject: Re: [lm-sensors] [Bugme-new] [Bug 12362] New: Extremely high cpu
Message-Id: <20090113104911.248C97BD55@ws5-10.us4.outblaze.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090112135948.12a01501.akpm@linux-foundation.org>
In-Reply-To: <20090112135948.12a01501.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Mon,  5 Jan 2009 03:22:43 -0800 (PST)
> bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id362
> >
> >            Summary: Extremely high cpu usage and temps starting 2.6.25
> >            Product: Platform Specific/Hardware
> >            Version: 2.5
> >      KernelVersion: 2.6.28
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: x86-64
> >         AssignedTo: platform_x86_64@kernel-bugs.osdl.org
> >         ReportedBy: curaga@operamail.com
> >
> >
> > Latest working kernel version: 2.6.24
> > Earliest failing kernel version: 2.6.25
> 
> (regression)
> 
> > Distribution: None
> > Hardware Environment: X86_64
> > Software Environment: pure 64-bit software
> > Problem Description: Starting with 2.6.25, my CPU temperatures 
> > are reported as
> > 55C when idle (30C in 2.6.24). Load avg stays over 0.5 even when completely
> > idle, and mpg123 takes 38% of cpu when it took 3% in 2.6.24 (from top).
> >
> > While the temperature readings of coretemp might be wrong in all kernels,
> > afterall .24 claims using undocumented features and .25-.28 claim to use a
> > relative scale, the cpu usage of all processes has greatly increased starting
> > with .25 kernel.
> >
> > I have tried various configs with .25, .26, and .28, both 
> > identical with my .24
> > config and variations such as enabling tickless, hpet, and using different IO
> > schedulers etc. No matter the config, all kernels starting .25 show this huge
> > cpu usage in all processes.
> >
> > I'm not at all sure what causes this, so marking as platform-specific.
> >
> > Pentium Dual Core E2160 overclocked to 3Ghz
> >
> > Steps to reproduce: Boot a 64-bit kernel 2.6.25 or later
> >
> 
> So I take it that you beleive that this regression was added into
> drivers/hwmon/coretemp.c during 2.6.25 development?
> 
> If so, possible culprits would be:
> 
> 
> commit 561d9a969455cb009bb15b63e1d925dc527e7a9d
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Mon Dec 3 18:01:50 2007 +0100
> 
>      HWMON: coretemp, suspend fix
> 
> commit 6369a2887a1b35fde91573adc650528e3efea8e9
> Author: Rudolf Marek <r.marek@assembler.cz>
> Date:   Fri Jan 18 00:42:54 2008 +0100
> 
>      hwmon: (coretemp) Add maximum cooling temperature readout
> 
> commit 118a88718886a6cb7fb2cf7fb77ef2eea30c73a1
> Author: Rudolf Marek <r.marek@assembler.cz>
> Date:   Sun Feb 17 22:59:39 2008 +0100
> 
>      hwmon: (coretemp) Add TjMax detection for mobile CPUs
> 
> commit ae770152c801f10a91e5e86597a39b5f9ccf2d0d
> Author: Rudolf Marek <r.marek@assembler.cz>
> Date:   Fri Jan 18 00:50:04 2008 +0100
> 
>      hwmon: (coretemp) Add Penryn CPU to coretemp
> 
> commit 34c86c1e622ec77ba81c01969003bbc8e15156f3
> Author: Darrick J. Wong <djwong@us.ibm.com>
> Date:   Fri Aug 15 00:40:41 2008 -0700
> 
>      coretemp: recognize Nehalem CPUs
> 
> 
> None of which look very likely :(

Hello

Sorry, I'm not sure if this is one regression or two.
Either there is something that keeps my cpu a lot warmer, either by itself or by causing all processes to take more cpu, or there is that, and the temperature is read wrong.

I took a look at the kernelnewbies changelog for .25, but nothing jumped at me as possible causes for either of the symptoms.

I'm afraid doing a git bisect would be way beyond my skills.

Also, the huge cpu-usage was at it's worst in .25, it is smaller in .28 but still there (the 38% is from .28, I think it was over 50% in .25)

- Lauri

-- 
_______________________________________________
Surf the Web in a faster, safer and easier way:
Download Opera 9 at http://www.opera.com

Powered by Outblaze

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
