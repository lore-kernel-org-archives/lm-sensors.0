From: aurelien@aurel32.lan (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Ticket 1751
Message-Id: <20040814015818.GA4981@bode.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
In-Reply-To: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 12, 2004 at 09:21:23PM +0200, Jean Delvare wrote:
> > When everything is fine, CPU and MB temps move up and down with load
> > as expected (and as confirmed by the BIOS).
> > The only required action to break the values appears to be installing
> > lm-sensors by apt-get install (which I'd guess runs sensors-detect) -
> > removing lm-sensors, and running only the w83627hf kernel module (ie
> > without lm_sensors) provides the "correct" (in the sense of more valid
> > anyway) values. When broken, the CPU temp locks itself at 85.0?C, and
> > doesn't shift whatsoever.
> > Sensors -s doesn't help anything.
> 
> Just asked the debian maintainer about it, and he told me that
> installing the package will actually run "sensors -s", not
> sensors-detect. So "sensors -s" is somehow messing with your chip. I
> can't remember of a similar report so far.
sensors -s is also run during each reboot. To disable that, just run
'update-rc.d -f lm-sensors remove'

Cheers,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
