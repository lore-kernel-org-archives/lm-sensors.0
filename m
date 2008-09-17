From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 17 Sep 2008 20:49:57 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors
Message-Id: <48D16D75.4040804@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CCB294.907@hhs.nl>
In-Reply-To: <48CCB294.907@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Just a short note. The errors  you are experiencing is concurrent access issue. 
The Asus util use ACPI bytecode to manipulate the i2c bus. Bus other utils try 
this same time. It may happen that the i2c bus hangs. Then it reads all ffs. 
Power down with the power cord will reset all in chipset and fixes the problem.

So if you will use one util, it should not happen.

Btw what happen if you issue command in linux:

modprobe thermal
acpi -V


Thanks,
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
