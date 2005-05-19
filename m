From: merlin@merlin.org (merlin hughes)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: lm_sensors2/prog/sensord rrd.c Module.mk args.c chips.c lib.c sense.c sensord.8 sensord.c sensord.h
Message-Id: <20020428142259.12C2E47E0@primary.mx.nitric.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

r/mds@paradyne.com/2002.04.28/00:06:43
>Our entire package won't compile now unless the user has the rrd
>headers and libraries, right?

Sorry about that; I had removed it from the default make
targets, forgot about the automatic dependencies. As a
quick fix, sensord now doesn't build by default.

Merlin
