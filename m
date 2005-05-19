From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: I2C mux / virtual bus implementation
Message-Id: <200406250728.i5P7Snbe003245@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40DB5E52.2030902@verizon.net>
In-Reply-To: <40DB5E52.2030902@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Third, you may not have realized that Khali recently did a (2.4 kernel)
>pca9540 driver. It is in our sensors package. It however doesn't do any
>of the bootstrapping or bus registering either. It may or may not help
>you.

It's a really simple driver meant to give manual control over the
PCA9540. I wrote it as a temporary solution for someone who had a board
with such a chip but that someone vanished so I don't think the driver
was ever tested. At any rate, the driver is definitely unsafe. Using it
to change the i2c channel while the bus happens not to be idle will
certainly result in, huh well, something bad, to say the least. I don't
think the driver will be of any help, or at least it won't help more
that Philips' datasheet for that chip.

Jean "Khali" Delvare
