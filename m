From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: I2C crash - ADM1021
Message-Id: <20031014222047.37d54212.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Interesting, Jean.
> 
> Now, s-d is recommending I insert pcf8591 but it did not before!

Perfectly normal, that's what I expected.

> What IS it about my system and port 0x4c?

Simply an unknown chip.

> For that matter, can you have
> two drivers trying to access different chips at the same port?

Not at the same time.

> Isn't that what got me into trouble in the first place?

No, it was the adm1021 driver trying to handle an unknown (and obviously
non-adm1021-compatible) chip.

> Driver `pcf8591' (should be inserted but causes problems):
>   Detects correctly:
>   * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x4e
>     Chip `Philips Semiconductors PCF8591' (confidence: 1)
>   Misdetects:
>   * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x4c
>     Chip `Philips Semiconductors PCF8591' (confidence: 1)

The PCF8591 is an 8-bit A/D-D/A converter which cannot be detected (it
has no readable registers), so we simply give it a confidence value of 1
(the lowest possible). This means that any other chip that will be
detected at the same address will discard it (that's the case at 0x4c,
where the lm90 discards the pcf8591) but at 0x4e I've been able to
prevent all misdetections (adm1021, lm75) but the pcf8591, so
sensors-detect now concludes that the chip at 0x4e is a PCF8591. I think
we should consider chips with confidence=1 as misdetected, and not add
them to the list of suggested modules. Unfortunately, this option
requires important changes to the code and I don't really have the time
for that now. Chips like the PCF8591 could also be simply removed from
sensors-detect (after all, we *can't* detect them so what's the point?).
That second option is an easy one and would probably make the users
happier in average.

Thanks a lot for testing my changes :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
