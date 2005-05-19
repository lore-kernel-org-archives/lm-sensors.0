From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: 2.7.0 testings
Message-Id: <3DEE6F2B.678CEEF7@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021127213903.5b84866d.khali@linux-fr.org>
In-Reply-To: <20021127213903.5b84866d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I didn't really mean "default to /usr/src/linux", I meant 
"when you had a kernel 2.2, so you were using /usr/src/linux".

I understand what you are doing now. I was a little confused, sorry.

Phil, the scheme is that if LINUX= is not specified on the make command line,
we build against the sources for the running kernel
(as linked to in /lib/modules/`uname -r`) if that link is present.
If not, we build against /usr/src/linux.

So the running kernel is not 'completely unrelated'.

We made this change a few weeks ago. We think it's better than /usr/src/linux
because it is much more likely to have the current kernel source in it
(which is indeed what most people want to build against).
It also matches current practice in other packages I've seen.
Redhat, for example, doesn't seem to have the current source in /usr/src/linux.

Khali's ready for release and so am I. Phil, if you are happy, go ahead.
p.s. I already upped the libsensors library version in preparation for the release.

mds

Jean Delvare wrote:
> 
> > I see. Well, MODPREF controls where the modules get installed.
> > That should be the same as the kernel that we compiled against,
> > which is the one defined in LINUX:= .
> > So don't you think MODPREF should do the "-L" thing?
> > But I don't know what happens if we default to /usr/src/linux...
> 
> If we default to /usr/src/linux, it means that we don't use the release
> of the currently running version of Linux. So, KERNELVERSION is useless.
> The only way we have to know where the modules should be installed is to
> look in /usr/src/linux and see where this kernel has installed its
> modules. This is exactly what is done right now.
> 
> If we didn't default to /usr/src/linux, it means that we know where to
> install the modules, and we could use KERNELVERSION. But, on the other
> hand, we built LINUX from KERNELVERSION (through the build symlink), so
> the method above will also work.
> 
> I don't see the point in creating a complex expression that does
> different things for these two cases when the first one will work for
> both (and has obviously proven to work well for years).
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
