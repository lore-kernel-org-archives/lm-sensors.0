From: amarsh@freeshell.org (Aaron Marsh)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Driver for vt8231
Message-Id: <20040912155346.GA28588@SDF.LONESTAR.ORG>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040908144801.GA12507@SDF.LONESTAR.ORG>
In-Reply-To: <20040908144801.GA12507@SDF.LONESTAR.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Jerry,

Thanks for the feedback.  I wish I could pin down some of the strange behavior
and at least determine if it's in the kernel-side code or in the calibrations
used in sensors.conf.  I just haven't done the detective work.

FWIW, while I'm not sure I trust the temperature calibration either, my 
Proc Temp does change with load (18.7 idle, 40-ish while compiling the 
kernel).  Hmm...

Thanks again for the support,

Aaron



On Sun, Sep 12, 2004 at 08:08:00AM -0700, Jerry Joplin wrote:
> Aaron, thanks for the port. I tried the vt8231
> port on a VIA EPIA 5000 and your sensors.conf
> running 2.6.8 (Debian) with the following output:
> 
> t8231-isa-6000
> Adapter: ISA adapter
> VCore1:    +0.30 V  (min =  -0.05 V, max =  +0.39 V)
> +5V:       +0.23 V  (min =  -0.08 V, max =  +0.56 V)
> +12V:      +1.10 V  (min =  -0.18 V, max =  +1.34 V)
> fan1:        0 RPM  (min =    0 RPM, div = 2)
> fan2:        0 RPM  (min =    0 RPM, div = 2)
> ERROR: Can't get TEMP2 data!
> Proc Temp:  -0.8 C  (high =    -1 C, hyst =    -1 C)
> vid:       +2.05 V
> 
> 
> The 5000 doesn't have fans, so fan1 and fan2 are
> good.  The other values look a little weird, but
> I haven't really found any usefuleness for VIA's
> sensors anyway.  (Proc Temp doesn't seem to change
> even when running CPU benchmarks for extended
> periods of time).
> 
> Overall, your port of vt8231 looks to be at least
> as good as the support in 2.4, so I would support
> adding it to the 2.6 drivers.  (I'm not sure how
> that is accomplished)
> 
> Thanks,
> Jerry
> 
> 

-- 
amarsh@sdf.lonestar.org
SDF Public Access UNIX System - http://sdf.lonestar.org
