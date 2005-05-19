From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: W83627HF SuperIO support in lm_sensors
Message-Id: <20030930195645.29a8f9d8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929180436.GB1779@pua.nirvana>
In-Reply-To: <20030929180436.GB1779@pua.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > If you want more drivers, either tweak the FILES and Config.in files
> > in mkpatch, or build the modules directly in the lm_sensors
> > directory instead of patching the kernel.
> 
> What do you think is better for an rpm (and what is better supported
> by you in general)? I checked the first way and it would require
> someone providing me with the changes, and these would have to be
> synced with the next lm_sensors release.
>
> The second proposal is something I could do propably without
> assistance (building kernel modules), but this would have to wait for
> some time (a couple of weeks), as it means ripping lm_sensors out of
> the atrpms kernels and providing it seperately, and also rebuilding
> and redistributing all further atrpms kernel modules.

I would use solution 2. This is what I do as a user. It doesn't change a
thing as far as packaging is concerned. You may build the modules inside
the lm_sensors tree rather than inside the kernel tree, they still end
up in /lib/modules, where they have to be. The only difference is that
you can't choose which module you want to install with solution 2, but
being packaging a kernel, you obviously don't want to exclude any driver
anyway.

That said, I think that we could add many drivers (if not all) to the
list of "considered stable" drivers. I can't think of any of our drivers
that may cause serious problems [1] so there is no real reason not to
include them all.
> 
> On Tue, Sep 30, 2003 at 10:40:20AM +0200, Alfredo Milani-Comparetti
> wrote:

Aha, you're the almico.com guy. Nice to see you here actually, I did not
know you were using Linux too :)

> > I see :-)
> > Anyway: since yours is a kernel recompiled for those who "know what
> > they're doing" and since setting up lm_sensors needs some knowledge,
> > I think it would be nice to include all those modules in your
> > distribution. Consider that sensors-detect script already knows
> > which modules are dangerous and which ones are not and acts
> > accordingly. Just a suggestion. Thank you for your time :-)
> 
> OK, sounds reasonable, what do you think, Jean?

Yes, let's go. Either you switch so solution 2, or you wait for us to
update our list, if nobody on the list objects it, of course.



[1] Actually, the adm1021 driver seems to cause much trouble these days,
for an unknown reason, and the i2c-piix4 used to cause trouble to
Thinkpad users - and they *are* both in the list of stable drivers.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
