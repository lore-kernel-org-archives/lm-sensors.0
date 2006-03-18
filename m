From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 18 Mar 2006 01:05:09 +0000
Subject: [lm-sensors] couple of issues - MSI AMD64 motherboard and sysfs
Message-Id: <4dfa50520603171705s2b60b4dke00414740dd42ea2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY12-F3EE11C41D520A1A1EB1B8B5E40@phx.gbl>
In-Reply-To: <BAY12-F3EE11C41D520A1A1EB1B8B5E40@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

On 3/16/06, Michael Alladin <huivzhopu at hotmail.com> wrote:
> Hi everyone
>
> I have MSI K8NGM2-FID motherboard (AMD64). I am not exactly sure which
> module driver needs to be loaded -- w83627ehf   seems to work but I'm not
> sure if that's the right one. I do get some output from sensors, which makes
> some sense:
>
> bash-2.05b$ sensors
> w83627ehf-isa-0a10
> Adapter: ISA adapter
> Case Fan: 1350 RPM  (min =    0 RPM, div = 8)
> CPU Fan:  3245 RPM  (min =  922 RPM, div = 8)
> fan3:        0 RPM  (min = 10546 RPM, div = 128)
> fan4:        0 RPM  (min = 10546 RPM, div = 128)
> Sys Temp:    +35 C  (high =   -87 C, hyst =    -8 C)
> CPU Temp:  +39.0 C  (high = +80.0 C, hyst = +75.0 C)
> unknown:   +41.5 C  (high = +80.0 C, hyst = +75.0 C)
>
>
> Now, what puzzles me, is the last temp. reading -- i cannot determine what
> the heck it is. I tried putting a fan directly over Northbridge chip, then
> over Southbridge, and this "unknown" temp. didn't change at all.  In fact, I
> don't think it changes it all, which makes me think it's bogus (or the
> driver is  not correct for my motherboard).

This may be useful information, or it may not. I have an Asus
A8N-VM/CSM with an AMD64 X2 processor, not an Athlon FX. I get three
temperature readings, like you. I am sure that I have a w83627ehf, so
if it ends up you don't have the chip, this may be irrelevant.
However, I get one reading from the thermistor inside the w83627ehf,
so that could be your sys temp. (Put something cold on the chip, temp
drops rapidly.) The other two, for me, are both the AMD64 X2 chip. I
guess there's one per core? The two stay very close to each other for
me, so if you run your system at 100% utilization for a while, they
should both climb together. That's one thing you can test.

David

