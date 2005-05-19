From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: linux-2.6.7 parallel port adapter
Message-Id: <20050509182751.678ba137.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <427B6E12.9000008@inf.ed.ac.uk>
In-Reply-To: <427B6E12.9000008@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nils,

> i could post the panic data (any particular kernel debug settings i
> should enable ?) if it would help.

Enabling all four I2C debug options (core, algorithms, busses, chips)
may help.

> do i have to have modules enabled to get this option ?
> (or is this not a kernel config parameter ?)

You can pass i2c_algo_bit.bit_test=1 to your boot loader.

-- 
Jean Delvare
