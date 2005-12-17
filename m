From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 17 Dec 2005 17:53:57 +0000
Subject: [lm-sensors] Backport of lm77.c for 2.4.x
Message-Id: <20051217185357.6117c026.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1134463317.4459.36.camel@gimli>
In-Reply-To: <1134463317.4459.36.camel@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> > > a. Tcrit and Thyst into two distinct files, or
> > > b. Tcrit and Thyst into one file.
> (...)
> I decided to choose option (a) nevertheless. I felt that having Tcrit
> and Thyst might lead to confusions, making users think that Thyst is
> only related to Tcrit, for example. The driver therefore currently has
> the following proc files: temp, temp_crit, temp_hyst and alarms.

Fine with me.

> > My personal opinion is that this kind of tuning should be done by the
> > BIOS, as the system manufacturer should know whether the fault queue is
> > needed for the hardware combination used and the expected conditions of
> > the system.
> 
> Agreed.
> 
> On the other hand WRAPs don't offer BIOS support for this feature.

And the Linux 2.6 lm77 driver doesn't either. Just because it looks
easier to add it there doesn't mean that's where it really belongs.

> (...) I'm
> not sure if it is needed at all, but it might still be handy for some
> people out there. I made it a compile time decision: when
> LM77_FAULT_QUEUE is defined, the fault queue will be enabled on every
> chip (LM77 only, of course) the driver takes care of. By default that
> feature is turned off.
> 
> Do you think this is an acceptable compromise?

No, it's not. Compilation time options are a pain to deal with.
Distribution kernel builders don't know what to choose, support people
don't know what the user has, and users are not supposed to need a
kernel recompilation every now and then (if they only know how to
compile a kernel.)

If you do not need this feature yourself, I suggest you do not
implement it. Just make sure that the driver will respect the BIOS'
settings.

> Well, it seems that the backport is done then. I'll test the driver a
> bit more locally. If I don't find any further problems/bugs, I'll send
> it to the list during the next days.

OK, great.

> Another question: which is the right place to talk about the scx200_acb
> driver? I've done some modifications of the version that can be found in
> Kernel 2.4.32 so that it correctly recognizes and handles SC1100-based
> systems as well - 2.6.x handles this correctly, but 2.4.x only probes
> for SCx200-type systems.

As this driver is not part of our packages, there's not much we can do.
You may try proposing your patch to Marcelo Tosatti for inclusion into
2.4 mainline, but changes are he will reject it. He is being very
conservative now, he even didn't accept my latest documentation updates
and typo fixes.

Other than that, all you can do is publish your fix as a patch
somewhere on the web where people interested in it are likely to find
it. I have no idea myself where such a place would be.

Thanks,
-- 
Jean Delvare

