From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: A7V8X-X and lm sensors
Message-Id: <20030918205538.619ebebf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030918153623.GA3679@pvv.org>
In-Reply-To: <20030918153623.GA3679@pvv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > CPU temperature needs adjustment to fit with the BIOS readings. 
> 
> I did some fast reboots after driving the T of the CPU up to certain
> temperatures measured by lm sensors. I then went into BIOS and checked
> it's temperature. I made a graph and I fitted the data. I have
> attached the graph if it can be helpful to you.

One user with the same motherboard reported: "When running cpuburn or
setiathome the cpu runs a bit hot and does agree with bios/setup at
about 40 degrees C, when the cpu is idling sensors reports 8 degrees C
while bios/setup reports about 30 degrees C." These values don't match
either forula you were proposing.

Anyway, you're always free to edit /etc/sensors.conf and use your
favorite formula here, as long as it works for you.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
