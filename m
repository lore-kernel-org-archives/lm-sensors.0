From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 11 Apr 2006 17:38:34 +0000
Subject: [lm-sensors] unable to set lm_sensors
Message-Id: <443BE99A.5030801@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603252150.53616.mmodem00@netvisao.pt>
In-Reply-To: <200603252150.53616.mmodem00@netvisao.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

 > I can only get temperature  from /proc/acpi/thermal_zone/TZS0/trip_points
 >
 > And in /proc/acpi/thermal_zone/ i get 3 subfolders
 > /TZS0
 > /TZS1
 > /TZSV
 >
 > Can this help?

Hmm this is just a trip point and not actual temperature.
Often is the temperature done via the embedded controller
which is prorietary and so we dont know how to read the
temps from it, sorry.

regards
Rudolf

