From: list0570@paradise.net.nz (Volker Kuhlmann)
Date: Wed, 28 Dec 2005 10:09:16 +0000
Subject: [lm-sensors] project status and future
Message-Id: <20051228100916.GD6616@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AF1E4A.90902@sh.cvut.cz>
In-Reply-To: <43AF1E4A.90902@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I would like to write here few notes and visions about lm-sensors project.

Let me add some ;)

I found that the fancontrol script works impressively well for
controlling the CPU fan, although it needed tweaking (the code, not just
the config params). It doesn't adjust well enough to the sorts of fans
existing "out there". It's also not integrated into a service startup
script.

There ought to be a general desktop suitable GUI to the sensors
monitored values, with proper reaction when they're found to be out of
range. The good news is, there is a framework for that already:
http://sourceforge.net/projects/powersave Powersave already keeps tabs
on resources, and is capable to optimise in various directions
(performance, noise, battery) and react if necessary (suspend box when
battery flat). It has a daemon part, and a KDE panel GUI part, and some
other GUI part. In other words, it's a monitor and control construction
with Joe-Average-capable interface. Sounds perfect to me for adding
lm_sensors into.

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

