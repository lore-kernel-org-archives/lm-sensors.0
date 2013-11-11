From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Nov 2013 08:59:02 +0000
Subject: Re: [lm-sensors] Submitting a patch
Message-Id: <20131111095902.4bf8fabc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFCHPoNujkPUHfi1Ep4EnWm=aDUbMY=6PqRRS6_A7Es4+TzeXw@mail.gmail.com>
In-Reply-To: <CAFCHPoNujkPUHfi1Ep4EnWm=aDUbMY=6PqRRS6_A7Es4+TzeXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bruno,

On Sun, 10 Nov 2013 22:49:55 +0100, Bruno DUYE wrote:
> Today, I found a little bug in lm-sensor, and wanted to submit you a
> patch using csv. Si I came to the doc, section "How to get CVS acces",
> clicked on the link of daily builds; but nothing appears here.
> The link http://www2.lm-sensors.nu/~lm78/download.html#cvs send a blank file.

I'm very curious where you found references to CVS and the link above,
as we migrated away from lm-sensors.nu and CVS many years ago. We're
using Subversion now, hosted on lm-sensors.org. See:

http://www.lm-sensors.org/wiki/Download

> So, here is the patch, by email (not my prefered way so far).

Patches sent by e-mail are just fine, we would not have created you a
write access to our repository just for one patch anyway. But please
use the unified format (diff -up) when sending patches.

> it's nearly nothing : in sensor-detect perl script; > 3.0 kernels
> numbers are not matched by the regex. Here's a quick patch :
> 
> 2666c2666
> < $kernel_version =~ /(\d+)\.(\d+)\.(\d+)(.*)/;
> ---
> > $kernel_version =~ /(\d+)\.(\d+)[-\.](\d+)(.*)/;

This has been discussed many times before, and rejected each time so
far. This isn't a bug in sensors-detect per se, 3.x kernels from
upstream do have a 3rd (sublevel) version number. The problem is that
some distributions decided to hide it from their user. I believe this
is bad practice as this information is very useful when investigating
user problems. The sensors-detect breakage is only another proof that
they are doing the wrong thing. Distributions who decide to do this are
on their own and have to patch every application they broke. 

Anyway, your proposed fix is not even correct. The number behind the
"-" in version strings is the build number, it has nothing to do with
the upstream kernel sublevel number. Debian (one of the offending
distributions) does have a correct fix, see 14-2-digits-kernel.patch in
http://ftp.de.debian.org/debian/pool/main/l/lm-sensors/lm-sensors_3.3.2-2+deb7u1.debian.tar.xz

If we ever accept a patch for this issue, it would be that one.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
