From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <1082389839.4083f54f22309@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Just a side note as you are talking about address ranges and the
> like here:  Please keep in mind that there is a world outside smbus
> which also uses i2c and where your assumtions are not nessesarely
> correct even if they are for smbus.

I do know that and keep it in mind. However, I obviously don't know the
audio and video side of I2C as good as you do. The non-smbus chips I
thought about are the ones which are part of the lm_sensors project
(A/D and D/A converters, multiplexers, lcd displays, switches).

Do you know of any chip on you side using an address in the 0x30-0x3F or
0x50-0x5F ranges? If there are, I would need to know what they are and
how much they like quick writes and byte reads, so that I can refine my
changes.

As a side node, I don't expect people to run sensors-detect on
video-dedicated i2c busses...

> Reportly some DVB card frontends are reacting very sensitive to the
> lm_sensor probes.

.but I am obviously wrong ;) Any chance you could provide more details
about how bad it goes? Maybe the change I am planning to do could
improve this too.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
