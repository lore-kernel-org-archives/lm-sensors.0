From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 06 Feb 2008 12:41:39 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: add sch5027 support
Message-Id: <47A9AB03.1050801@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0801312242k123f20ffl2ccb85ff1416ee6b@mail.gmail.com>
In-Reply-To: <191fb4ca0801312242k123f20ffl2ccb85ff1416ee6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

My friend Michal has this chip. It detects the chip, but it still tells to load 
the lm85 driver.

Michal, please can you post the full output of sensors-detect script as 
attachment (txt/plain)? Thanks.

Here is the snip, he used latest SVN version already.

[13:31] *misko* jo to je ta deska
[13:31] *misko* Trying family `SMSC'...                                     Yes
[13:31] *misko* Found `SMSC SCH5027D-NW Super IO'
[13:31] *misko*     (hardware monitoring capabilities accessible via SMBus only)
...
[13:32] *misko* Driver `lm85' (should be inserted):
[13:32] *misko*   Detects correctly:
[13:32] *misko*   * Bus `SMBus I801 adapter at 3000'
[13:32] *misko*     Busdriver `i2c-i801', I2C address 0x2e
[13:32] *misko*     Chip `lm85' (confidence: 6)
[13:32] *misko* Driver `coretemp' (should be inserted):
[13:32] *misko*   Detects correctly:
[13:32] *misko*   * Chip `Intel Core family thermal sensor' (confidence: 9)



Thank you,
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
