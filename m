From: Volker Kuhlmann <list0570@paradise.net.nz>
Date: Sun, 25 Jan 2009 01:50:55 +0000
Subject: Re: [lm-sensors] fancontrol init script for ubuntu +
Message-Id: <20090125015055.GC16739@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <000101c97b90$15a03de0$3001a8c0@cw8xp>
In-Reply-To: <000101c97b90$15a03de0$3001a8c0@cw8xp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed 21 Jan 2009 19:18:31 NZDT +1300, Charles wrote:

> Here's a standards-compliant init script for fancontrol, developed and
> tested using fancontrol 0.66 on ubuntu 8.04.1. It may work on other ubuntus,
> debian and other debian-based systems using lsb-base (>= 3.0-6).

Are you joking? Which "standard"? You say standards-compliant, then
say it only works on Debian?

> Part of the standards-compliance is that the script issues no messages at
> boot or shutdown if /etc/default/rcS has VERBOSE=no (the default value).

Where is this requirement mentioned? I don't see it in
http://refspecs.linux-foundation.org/LSB_3.2.0/LSB-Core-generic/LSB-Core-generic/tocsysinit.html
byt may have missed something.

Greets,

Volker

-- 
Volker Kuhlmann			is list0570 with the domain in header
http://volker.dnsalias.net/	Please do not CC list postings to me.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
