From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Mar 2007 10:33:41 +0000
Subject: [lm-sensors] sensors-detect path issue under fc5 / 6 -- fix
Message-Id: <20070304113341.091c3819.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Vince,

Moving the thread to the lm-sensors list, where it belongs.

On Sun, 4 Mar 2007 03:04:42 -0500 (EST), Vince Spinelli wrote:
> It's a simple one, but it's worth noting.
> 
> I'm unawares of other distributions, but under Fedora Core 5 and 6, the
> i2cdetect command is located in the /usr/sbin directory, not /sbin/ nor
> /usr/local/sbin.

That's the case of pretty much all distributions shipping lm-sensors,
as /usr/local is meant for things added on top of the original
distribution.

> As a result, an error message is encountered when running
> sensors-detect.sh as either root, sudo root, or a normal user.

There's no such thing as "sensors-detect.sh" in our source package.
sensors-detect is a perl script.

If your root user doesn't have /usr/sbin in its $PATH, then your setup
is seriously broken, I doubt sensors-detect will be the only failing
tool.

sensors-detect can no longer be run as non-root, so this case doesn't
matter.

The su/sudo case is more problematic though, I can imagine a standard
user gaining root permissions without getting the $PATH usually
associated with the root user.

> The fix is as follows... inside of the sensors-detect.sh script, there's a
> segment to add directories to path.
> 
> Change -->
> # Just in case a root user doesn't have /sbin in his/her path for some reason
> # (was seen once)
> $ENV{PATH} = '/sbin:'.$ENV{PATH}
> 	unless $ENV{PATH} =~ m,(^|:)/sbin/?(:|$),;
> # Same for /usr/local/sbin since we need i2cdetect which is installed there
> # by default (reported by Lennard Klein)
> $ENV{PATH} = '/usr/local/sbin:'.$ENV{PATH}
> 	unless $ENV{PATH} =~ m,(^|:)/usr/local/sbin/?(:|$),;
> 
> To -->
> # Just in case a root user doesn't have /sbin in his/her path for some reason
> # (was seen once)
> $ENV{PATH} = '/sbin:'.$ENV{PATH}
> 	unless $ENV{PATH} =~ m,(^|:)/sbin/?(:|$),;
> # Same for /usr/local/sbin since we need i2cdetect which is installed there
> # by default (reported by Lennard Klein)
> $ENV{PATH} = '/usr/local/sbin:'.$ENV{PATH}
> 	unless $ENV{PATH} =~ m,(^|:)/usr/local/sbin/?(:|$),;
> # Same for /usr/sbin, for FC default dir (location of i2cdetect - V.
> Spinelli)
> $ENV{PATH} = '/usr/sbin:'.$ENV{PATH}
> 	unless $ENV{PATH} =~ m,(^|:)/usr/sbin/?(:|$),;
> 
> And that fixes it.

Can you please provide a unified diff as everyone does, so that I can
just apply it? Something like:
  diff -u sensors-detect.orig sensors-detect
should do it.

Thanks,
-- 
Jean Delvare

