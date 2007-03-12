From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Mar 2007 10:12:36 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <20070312111236.d1f3a26b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel, Hans, all,

On Sun, 11 Mar 2007 21:28:46 +0100, Axel Thimm wrote:
> On Sun, Mar 11, 2007 at 08:53:43PM +0100, Hans de Goede wrote:
> > Agreed, thinking about this some more I'm not so sure that dropping 2.4 
> > support is a good idea as there is still plenty of 2.4 usage out there. 
> 
> I would second keeping 2.4 support if it's not too much pain. Many
> RHEL3 users pick i2c/lm_sensors' kernel modules at ATrpms for
> supporting their hardware.

Come on, I'm tired of all this whining each time we say that we want to
drop 2.4 support. Users need to get a life and finally understand that
you can't run a 3-year old kernel on brand new hardware and expect
everything to work. If they want to be stupid and do that, great, but
then they are on their own and they better don't come and ask me to
support them.

The drop of 2.4 support is a fact already. We are no longer writing new
drivers for 2.4, and when 2.4 drivers are backported by others
(w83627ehf, smsc47m192) we don't have the time to review them anyway.
All the new hardware we added support for in 2.6 lately (?Guru, K8
integrated sensors, ADM1029, IT8716F, IT8718F, PC87427, W83793) isn't
supported with 2.4 kernels.

The only new hardware support will still backport is when it's as easy
as adding a new device ID in an old driver. And I think I'm nice enough
to do that - Mark suggested to plain _kill_ 2.4 support one year ago
already.

> But if 2.4 support is slowing down things and developer resources want
> to concentrate on 2.6 it will have to go sooner or later.

That's the case exactly. We hardly have time to keep up with the new
drivers for 2.6 and all the infrastrcuture changes that are long
overdue.

If people are interested in continued 2.4 kernel support, that's
alright, but then they get to do the job themselves. They stop whining,
they join the project, and they do the job themselves.

It might be worth remining everyone that Rudolf, Mark and myself, to
name only the three most active contributors, are working on lm-sensors
on our spare time, for free, because we think it's fun. We don't owe
anything to anyone out there. Free software doesn't mean developers are
the users' slaves and do everything for free on request. Free software
means that whoever wants something gets to do the job.

-- 
Jean Delvare

