From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ne1619 (really solved)
Message-Id: <20030729215710.48a32986.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307291959.07420.ondrej.cecak@centrum.cz>
In-Reply-To: <200307291959.07420.ondrej.cecak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> It works perfectly. If you can see output, there is:
> 
> adm1025-i2c-0-2d
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> +2.5V:     +2.49 V  (min =  +2.25 V, max =  +2.75 V)
> VCore:     +1.46 V  (min =  +1.42 V, max =  +1.57 V)
> +3.3V:     +3.33 V  (min =  +2.97 V, max =  +3.63 V)
> +5V:       +5.03 V  (min =  +4.51 V, max =  +5.49 V)
> +12V:      +0.00 V  (min = +10.81 V, max = +13.19 V)
> VCC:       +3.27 V  (min =  +2.97 V, max =  +3.63 V)
> SYS Temp:  +43.0?C  (min =   +5?C, max =  +65?C)
> CPU Temp:  +43.0?C  (min =   +5?C, max =  +65?C)
> vid:       +1.50 V

Looks really good, except rounding on VCore which is still a bit too low
(should be 1.43/1.58) but that's not very important and I'm not even
sure it is a driver issue (could be a problem (or feature) of the
sensors library).

Take a look at the config file, there's a line to remove +12V (which
isn't hardwired on your board, as I explained.)

> eeprom-i2c-0-50
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> Unknown EEPROM type (1)
> 
> eeprom-i2c-0-51
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> Unknown EEPROM type (1)

Hey, this isn't working as intended! (When will I leave you alone, you
must be thinking.) You must have a special kind of memory chips we don't
support yet. Could you please run the prog/eeprom/decode-dimms.pl? Also,
a dump of one of your eeproms would be appreciated (unload the eeprom
module, and run "i2cdump 0 0x50"). Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
