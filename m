From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 22 Nov 2005 22:00:09 +0000
Subject: [lm-sensors] +5V line... and Stdby fixable?
Message-Id: <20051122220049.3abbb3cf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b0511180346s58c38f67p465b9e2adad74bc@mail.gmail.com>
In-Reply-To: <ea9ff50b0511180346s58c38f67p465b9e2adad74bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf, Filip,

> > +5V:       +4.22 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
> 
> Hmm perhaps you need better formula. Without asking MB manufacturer
> is it hard to get one. (There is nearly no chance for answer)
> 
> Jean any suggestions?

Change the in3 compute line:

    compute in3 ((10/10)+1)*@ ,  @/((10/10)+1)

(10 instead of 6.8) and it should look better. A few Gigabyte boards
seem to use this. I'll note this in our default configuration file.

Also note that on this board, Vcore2 is really Vram, and -12V is Vagp
(remove the compute line and it should read around 1.5V, then adjust
the limit settings).

> > how can I exclude from monitoring the following:
> > eeprom-i2c-0-51
> > Adapter: SMBus nForce2 adapter at 1c00
> > Memory type:            DDR SDRAM DIMM
> > Memory size (MB):       512
> 
> This will be dropped soon or maybe is in CVS version.

In the mean time, two other possibilities:

1* Simply don't load the eeprom driver.

2* Explicitely ask sensors to only show the other chip: "sensors
'it8712-*'".

-- 
Jean Delvare
