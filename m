From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 23 May 2006 16:12:26 +0000
Subject: [lm-sensors] Question about correct sensor
Message-Id: <20060523181226.7213f5ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
In-Reply-To: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf, Christoph,

> > well things partly work now. I get the following output from sensors 
> > (thanks for the hint):
> > #----cut here----
> > # I2C adapter drivers
> > modprobe i2c-i801
> > modprobe i2c-isa
> > # I2C chip drivers
> > modprobe eeprom
> > modprobe w83627ehf
> 
> I guess you are trying the w83627hf because w83627ehf does not exists for 2.4.
> However I think someohow forcing the w83627hf might work. I dont have time for
> this right know, maybe Jean knows?

No, the W83627EHF chip is different (else we wouldn't have started a
different driver.) Forcing the w83627hf driver will cause more trouble
than is worth. The solution would be to backport the w83627ehf driver
to Linux 2.4, if someone (not me) wants to do that. This is the second
request.

-- 
Jean Delvare

