From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: sensors-output.
Message-Id: <1080647220.40695e3486682@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1080645241.2518.37.camel@ronin.inmyhouse.org>
In-Reply-To: <1080645241.2518.37.camel@ronin.inmyhouse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Chris Douglass:

> OK- Here it is.
> Although I didn't include it, sensors-detect still reccommends
> loading the adm1021 module.

Bad :/

> I use an ABIT NF7-S v2.0. I also have an NV7-133R (NForce 1 ABIT
> board), and a whole slew of MSI NForce2 boards (forgot the model #)
> at the office. Would it be worthwhile to try this on one of those
> machines?

If these machines also have chips that are misdetected as MAX1617 or
LM84, yes, I'm interested.

> I still haven't quite figured out if the particular sensors used on
> any particular MB are dependant on manufacturers choice or dictated
> by the bus and chipset being used.

Basically the bus is determined by the motherboard bridge, but the
hardware monitoring component itself isn't (except in the few cases it
is embedded ito the bridge itself).

> Client found at address 0x4e
> ...
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
> Probing for `Maxim MAX1617'... Success!
>     (confidence 3, driver `adm1021')
> Probing for `Maxim MAX1617A'... Failed!
> ...

I guess that you snipped a LM84 detection at this point, since the
summary below says LM84 (confidence 5) for this address.

> Here is the output of:
> /usr/local/sbin/i2cdump 0 0x4e (if this isn't what you wanted, let
> me know)

This is what I needed. Actually the chip passes almost all checks so
it's very, very difficult to discard it.

Could you please edit sensors-detect around line 3453, and replace:
  return if $misdetect > 2;
with
  return if $misdetect > 1;

I'd expect the chip to be still detected as a LM84 but not as a MAX1617
anymore. With "> 0" I would hope that it doesn't detect it at all
anymore. Please confirm.

If that's what it takes to prevent misdetection, I think we should do
it. Having dumps of real MAX1617 and LM84 chips would help much too,
but I don't know anyone having that.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
