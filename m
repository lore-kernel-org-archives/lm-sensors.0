From: lists@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: scaling of loadavg in sensord
Message-Id: <417D0FCE.3000501@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <417CB2E3.3090007@aurel32.net>
In-Reply-To: <417CB2E3.3090007@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all!

Currently sensord is logging load1 when used with the --load-average 
option. It does not make much sense to do that for a 5 minutes RRD 
update interval (the default one).

The best solution is to let the user to choose which load he wanted to 
log according to the update interval and other things.

That's the purpose of the attached patch. Using it, it possible to 
select the load average to log. For example --load-average 1,5,15 logs 
load1, load5 and load15.

Please note that it should be applied after the patch I sent this 
morning (scaling of loadavg).

Bye,
Aurelien

-- 
    .''`.  Aurelien Jarno	       GPG: 1024D/F1BCDB73
   : :' :  Debian GNU/Linux developer | Electrical Engineer
   `. `'   aurel32@debian.org         | aurelien@aurel32.net
     `-    people.debian.org/~aurel32 | www.aurel32.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensord.loadavg_1_5_15.patch
Type: text/x-patch
Size: 7827 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041025/90dcd789/sensord.loadavg_1_5_15.bin
