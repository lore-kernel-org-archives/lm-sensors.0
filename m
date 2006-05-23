From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 23 May 2006 12:07:48 +0000
Subject: [lm-sensors] Question about correct sensor
Message-Id: <4472FB14.9010001@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
In-Reply-To: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> well things partly work now. I get the following output from sensors 
> (thanks for the hint):
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> modprobe i2c-isa
> # I2C chip drivers
> modprobe eeprom
> modprobe w83627ehf

I guess you are trying the w83627hf because w83627ehf does not exists for 2.4.
However I think someohow forcing the w83627hf might work. I dont have time for
this right know, maybe Jean knows?

Regards
Rudolf

