From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 28 Jan 2006 08:52:32 +0000
Subject: [lm-sensors] wrong readings for w83627ehf on p5mt-m - solution
Message-Id: <20060128095232.40d95ca0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43DA95AC.70504@sh.cvut.cz>
In-Reply-To: <43DA95AC.70504@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf, Alexander,

> I think I know what happen. The chip is not used at all.
> You should have there W83792AD on board. Can you check?
> It should be square with like total 48legs. If yes I will
> contact Asus and ask them how to unhide it.

Indeed, the manual for the Asus P5MT-M mentions a Winbond W83792D chip
for voltage and fan monitoring. They don't mention temperature, but
they do mention the existence of a multiplexer in front of the SMBus.
Without additional information regarding this multiplexer, there's
nothing we can do.

That being said, I don't think Alexander ever provided the full output
of sensors-detect nor any output of i2cdetect, so we don't even know
for sure is the W83792D/AD chip is visible on the bus or not. But we
know that the SPD EEPROMs were.

Alexander, can you please provide the full output of sensors-detect?

-- 
Jean Delvare

