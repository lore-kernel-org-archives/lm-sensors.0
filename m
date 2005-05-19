From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Hi, about lm_sensors
Message-Id: <423769EB.3050406@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4237654F.10903@infodesign.bg>
In-Reply-To: <4237654F.10903@infodesign.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Filip Tsachev wrote:
> Hi,
> 
> Sorry to bother you but what happens at my system is that CPU temp was 
> inicially detectect as 28C while it runs at 55C 
2x too high? adjust in sensors.conf

> also -5V current is 
> displayed as -8,....V 
see FAQ 4.6.1


> and so on... pls help me out, 
can't help you with 'and so on' without details

> I did sensors-detect 
> then just some minor adjustments to sensors.conf but no luck. How can I 
> understand which module is appropriate for GB GA-7N400L nForce2 with AMD 
> athlon 2200+
sensors-detect tells you what modules.
If it didn't work see FAQ 4.24.3

