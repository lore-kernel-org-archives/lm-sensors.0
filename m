From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: Asus P4PE-XS
Message-Id: <1080212716.4062bcec7913c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200403251128.45259.a.bitz@gmx.net>
In-Reply-To: <200403251128.45259.a.bitz@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Deutsch ist nicht meine erste Sprache... Aber ich w?rde versuchen, Dir
zu helfen.]

Quoting Annette Bitz <a.bitz@gmx.net>:

> eigentlich sollte das Board einen Asus asb100 (Bach) - Chip haben.
> Aber der wird nicht erkannt. Nach modprobe asb100 von Hand erhalte
> ich immerhin folgende Ausgabe:

Korrect, dieses Board hat einen Asus ASB100 Bach.

> # sensors
> asb100-i2c-0-2d
> Adapter: SMBus I801 adapter at e800
> Algorithm: Non-I2C SMBus adapter

Nicht gut :(

War das mit w83781d treiber oder asb100?

> eeprom-i2c-0-50
> Adapter: SMBus I801 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> Memory type:            DDR SDRAM DIMM SPD
> Memory size (MB):       512

Aber das is gut :) Es meint das Deinen i2c bus funktioniert.

> In /prov/sys/dev... stehen z.B. und temp1 auch Werte, aber diese
> werden nicht ausgelesen.

Was gescheht wenn du vesuchest, ihnen zu lesen?

> # prog/dump/isadump 0x295 0x296

Das Asus ASB100 ist einen I2C Chip, nicht ISA, so es ist normal dass
isadump hiflt nicht.

> # prog/dump/i2cdump 1 0x23 b
> Error: Could not open file `/dev/i2c-1' : No such device

Was versuchste Du zu machen? Kein Chip hat diese Addresse (0x23) und
dein System hat kein i2c bus 1 (nur 0).

Welches lm_sensors version ist es? Welches Linux kernel?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
