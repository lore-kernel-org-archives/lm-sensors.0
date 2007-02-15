From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Feb 2007 10:47:39 +0000
Subject: [lm-sensors] DS75
Message-Id: <20070215114739.34aa8dcc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45BDE148.7020108@pipstechnology.co.uk>
In-Reply-To: <45BDE148.7020108@pipstechnology.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > OK. Attached is a patch against sensors-detect from our SVN repository.
> > Please give it a try, it should detect your DS75. Compared to the LM75
> > detection, I removed the cycle-over-8 test as your kernel patch did,
> > and additionally I'm checking that registers 0x08 to 0x0f behave the
> > same as 0x04 to 0x07 (which isn't true of the LM75.) If it works OK for
> > you, we can use the same approach in the lm75 kernel driver. Please
> > report.
> (...)
> Your sensors detect patch works fine:

OK, patch applied to lm-sensors SVN.

I'm still waiting for updated kernel and libsensors/sensors patches.

-- 
Jean Delvare

