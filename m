From: liontooth@cogweb.net (David Liontooth)
Date: Wed, 03 May 2006 17:28:56 +0000
Subject: [lm-sensors] Winbond PC87431M and PC87427
Message-Id: <4458E858.2000303@cogweb.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some suggested updates for http://secure.netroedge.com/~lm78/newdrivers.html

Martin Devera (cc'd) has done some work on the PC87427 -- see
http://luxik.cdi.cz/~devik/supermicro-wdt.htm. Could this be integrated
into lm-sensors and used as a basis for support?

Corey Minyard has incorporated a rewrite of Yani Ioannou's BMC code for
PC87431M into the openipmi patches for 2.6.16; these  also appear to
have been submitted to the mm tree (cf.
http://groups.google.ca/group/fa.linux.kernel/browse_thread/thread/db9b2e03786b8e7d/5a1f8e11ea55c8b1).


Ipmitool is working great on my Intel Server Board SE7525GP2 running
Debian etch with 2.6.16.12.

David




