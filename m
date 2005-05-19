From: nroeder@inf.ed.ac.uk (Nils Roeder)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: linux-2.6.7 parallel port adapter
Message-Id: <427F4A76.6070805@inf.ed.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <427B6E12.9000008@inf.ed.ac.uk>
In-Reply-To: <427B6E12.9000008@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
[snip]
> These lines make little sense. I guess you really mean:
> #CONFIG_I2C_PARPORT is not set
> CONFIG_I2C_PARPORT_LIGHT=y
> Right?
right :)

[snip]
>>causes a kernel panic ...
> Never had any report about this. Can't tell whether this has a chance to
> be fixed in 2.6.11+ without the kernel panic data.
i could post the panic data (any particular kernel debug settings i
should enable ?) if it would help.

[snip]
> You should try the bit_test=1 parameter to the i2c-algo-bit module, it
> will test the lines when i2c-parport(-light) is loaded so you know
> whether the driver uses the correct pins or not.
do i have to have modules enabled to get this option ?
(or is this not a kernel config parameter ?)

cheers,

  nils
