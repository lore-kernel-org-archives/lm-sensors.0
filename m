From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: [swan@shockfrosted.org: Ticket #1017]
Message-Id: <3DA76EE9.CBDD429B@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021003110526.GA5364@TK150122.tuwien.teleweb.at>
In-Reply-To: <20021003110526.GA5364@TK150122.tuwien.teleweb.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Great!
the 3177 mod clearly works, we will add support in CVS.
You are unlikely to have a LM80 (often misdetected) or a w83781d
(i2cdetect doesn't look right).
Look at your board or ask your board maker to identify sensors chip.
You can also send us the output of i2cdump 1 0x1b and i2cdump 1 0x2f
and we can try to identify the chips at those addresses.

mds



Stefan Schwandter wrote:
> 
> Stefan Schwandter wrote:
> 
> > > does it actually work though? any chips found on the bus?
> > > (try sensors-detect, or i2cdetect 1)
> 
> Ok:
> 
> sensors-detect suggests:
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-viapro
> modprobe i2c-isa
> # I2C chip drivers
> modprobe eeprom
> modprobe w83781d
> #----cut here----
> 
> To make the sensors modules behave correctly, add these lines to either
> /etc/modules.conf or /etc/conf.modules:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> i2cdetect gives:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>          00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>          10: XX XX XX XX XX XX XX XX XX XX XX 1b XX XX XX XX
>          20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX UU
>          30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>          40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>          50: 50 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>          60: XX XX XX XX XX XX XX XX XX 69 6a XX XX XX XX XX
>          70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 
> 
> I can use sensors to look at the values of the lm80 chip (although
> they're nonsense, but that's another problem - the second chip on the
> motherboard, w83781d gives sane values).
> 
> If you want me to do some more testing, please say so!
> 
> regards, Stefan
> --
> ----> http://www.shockfrosted.org
