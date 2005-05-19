From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: scaling of loadavg in sensord
Message-Id: <417CB2E3.3090007@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all!

It make not much sense for sensord to scale the loadavg itself (*10):
RRDs work with floating-point values and thus do very well with
non-integer values even < 1.

They can even be scaled later at display time by rrdtool itself, if
the user wants it.

The attached patch removes the scaling of loadvg in sensord.

Bye,
Aurelien

-- 
   .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
  : :' :  Debian GNU/Linux developer | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensord.loadavg_scale.patch
Type: text/x-patch
Size: 757 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041025/42030cdd/sensord.loadavg_scale.bin
