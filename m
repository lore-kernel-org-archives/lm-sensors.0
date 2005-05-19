From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Userquestion: A/D-Converter on Parport
Message-Id: <20031019124237.54246c01.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310182049.38529.chris_honschu@gmx.de>
In-Reply-To: <200310182049.38529.chris_honschu@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> So I bought a I2C 7Bit-Adress ADS1110 (ADS1110A0IDBVT by
> TexasInstruments) 16-Bit and would like to mount it to a
> i2c-philips-par wireing. The Datasheet of the ADS1110 can be found at:
> 
> http://www-s.ti.com/sc/ds/ads1110.pdf
> 
> But howto talk to the ADS1110 ? Is there a simple C Program/Example? 
> Is it hard to write sutch a driver? Do I have to be root to read out
> the values? Are there other known similar projects to mine?

Writing a driver isn't too hard, since i2c-core takes care of all the
protocol and kernel details. All you have to do is to write a chip
driver. Take a look at the pcf85xx chips we already have drivers and
docs for. I'd expect your ads1110 to be a chip of the same kind. Follow
the guidelines found in doc/developers/new_drivers.

If you ever have a driver working, please send it to us together with
documentation and we'll make it part of our distribution.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
