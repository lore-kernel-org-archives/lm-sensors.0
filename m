From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: FAN VALUES NOT COMING
Message-Id: <Rpj1B2CH.1107334443.4305520.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

> I am  toby ,working in hcl infosystems. i am working on AMASON   mother
> board now.Its an ipmi based board ,but in this board one health monitoring
> chip  W83627HF AW is also there.I ve loaded the module for W83627HF . im
> getting all voltage and temperature values.but only 3 fan values are
> coming.but the board supports 6 fans.And in the BIOS it shows all the fan
> values.
> It has been specified in the data sheet for W83627HF (not W83627HF AW) that
> only 3 fans are supported .Is there any  other data sheet available
> specifically for W83627HF AW.if it is there could you plz kindly send me
> the same to this mail id .

I don't think that the W83627HF-AW is anything different from the
W83627HF, it's most probably the exact same thing. So I doubt there are
6 fan monitors in your chip. Most likely the fan inputs are multiplexed,
or you have an additional fan speed monitoring chip on your board. I
invite you to ask your motherboard manufacturer for additional
information.

--
Jean Delvare
