From: list0570@paradise.net.nz (Volker Kuhlmann)
Date: Tue, 24 Jan 2006 03:22:04 +0000
Subject: [lm-sensors] Added hysteresis to fancontrol
Message-Id: <20060124032204.GG28986@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I rewrote the fancontrol script, and added a hysteresis to the fan speed
calculation. This prevents the fan from being switched between off and
minimum speed every $INTERVAL seconds because the temperature changes by
1?C. Another important change which allows fancontrol to be started from
the lm_sensors service script is also included.

The syntax of /etc/fancontrol is appropriately extended, the change will
be ignored by previous versions of the script.

Please replace the fancontrol script in the lm_sensors package with the
one at http://volker.dnsalias.net/soft/script/fancontrol . No diff
because it's a complete tidy-up, with many clumsy parts being rewritten.

Thanks + greetings,

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

