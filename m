From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Disabling chassis intrusion alarm?
Message-Id: <20031204230316.19910627.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0312041256360.18024-100000@druifje.clustervision.com>
In-Reply-To: <Pine.LNX.4.44.0312041256360.18024-100000@druifje.clustervision.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> can I ask for a little help please?

Sure you can.

> I am trying to configure lm_sensors for a dual processor
> Supermicro motherboard.
> 
> I'm using the Nagios plugin check_sensors,
> which very simply does a grep on the output of sensors,
> and returns an alarm sate if the string ALARM is present.
> On this motherboard, the chassis intrusion alarm is often set,
> and I'd rather not alarm on this.
> 
> Is there a way of switching off this alarm in sensors.conf please?

In the w83627hf-* section, add the line "ignore alarms", and that
should be OK.

I also suspect that you can reboot, enter the BIOS setup screen, say you
want to ignore the intrusion alarm, and be done that way.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
