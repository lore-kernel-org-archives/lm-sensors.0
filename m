From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Interested to donate a board to get a driver
Message-Id: <4bynRCRp.1108042715.4608590.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <008601c50f61$d3250430$8c00a8c0@tin1>
In-Reply-To: <008601c50f61$d3250430$8c00a8c0@tin1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Timo,

> Driver status page fo National Semiconductor's PC87372 says:
>
> (2004-08-02) Super I/O with fan monitoring and PWM. A driver has been
> requested, will be developped upon donation of a board.
>
> I'm definetly interested to get a full set of working lm_sensors drivers
> for my Intel D865GLC boards (I have several servers running on this hw).
> AFAIK, the only missing driver is a chip driver for PC87372.

I took a look at the Intel D865GLC specifications and was surprised to
find that they advertise an SMSC LPC47M172 as the Super-I/O. Deeper in
the specifications, there is a reference to the National Semiconductor
PC87372. A quick look at both datasheets reveal (to my great surprise)
that both chips are pin-compatible. They are, however, not
register-compatible, at least when  it comes to fan speed monitoring.

> If donating a reasonably-priced motherboard would be what is required to
> get the drivers in question, I'm ready to consider making this donation.
> Of course, prior to making the donation I would appreciate some rough
> schedule when to expect the drivers could be available -just to know if
> we are talking about  few weeks or half a year.

We would gladly accept your kind offer, but...

After taking a look at your motherboard manual, it seems very clear to me
that the fan monitoring capabilities of your PC87372 chip are NOT used.
You have another, dedicated hardware monitoring chip on that board, with
voltage, temperature and fan monitoring, and fan control. If you have a
physical access to the board, look for it between to the CPU Fan header
and the edge of the board (the manual has a nice drawing).

So it wouldn't be exactly fair from us to accept a donation from you and
then find out that the driver we wrote is useless to you.

Could you please provide the output of sensors-detect (a recent one) for
your system? I'm surprised that it didn't find that chip, since it's
supposed to hang off the Intel SMBus, which we do support.

Thanks,
--
Jean Delvare
