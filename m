From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 19 Apr 2006 20:40:12 +0000
Subject: [lm-sensors] sensor output writing to terminals
Message-Id: <4446A02C.8010508@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1145229015.329.9.camel@localhost.localdomain>
In-Reply-To: <1145229015.329.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Apr 16 19:07:48 VTdebian sensord: Sensor alarm: Chip w83697hf-isa-0290:
> -12V: +2.03 V (min = -13.18 V, max = -10.80 V) [ALARM]
> Apr 16 19:07:48 VTdebian sensord: Sensor alarm: Chip w83697hf-isa-0290:
> -5V: +0.63 V (min = -5.25 V, max = -4.75 V) [ALARM]
> Apr 16 19:07:48 VTdebian sensord: Sensor alarm: Chip w83697hf-isa-0290:
> fan2: 0 RPM (min = 1188 RPM, div = 8) [ALARM]
> Apr 16 19:07:48 VTdebian sensord: Sensor alarm: Chip w83697hf-isa-0290:
> temp1: 24 C (limit = 12 C, hysteresis = 18 C, sensors = thermistor)
> [ALARM]
> 
> Can someone please tell me what I need to configure to stop the writing
> to all open terminals?

Hmm perhaps the sensorsd deamons sends an alert. And because of allert nature it
will be sent to all terms. Please check if this cannot be configured somehow.
I'm not too familiar with sensorsd.

You may also adjust the /etc/sensors.conf file so the alarm is produced
only when it is a real one.

I hope it helps
Regards
Rudolf

