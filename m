From: Marco Chiappero <marco@absence.it>
Date: Thu, 18 Sep 2008 11:35:58 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors
Message-Id: <48D23D1E.5060507@absence.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CCB294.907@hhs.nl>
In-Reply-To: <48CCB294.907@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek ha scritto:
> Hi,

Hi!

> Just a short note. The errors  you are experiencing is concurrent access 
> issue. The Asus util use ACPI bytecode to manipulate the i2c bus. Bus 
> other utils try this same time. It may happen that the i2c bus hangs. 
> Then it reads all ffs. Power down with the power cord will reset all in 
> chipset and fixes the problem.
> 
> So if you will use one util, it should not happen.

Ok, I just wanted to be sure there was no faulty hardware, thank you for 
the explanation.

> Btw what happen if you issue command in linux:
> 
> modprobe thermal
> acpi -V

Cooling 0: Processor 0 of 3
Cooling 1: Processor 0 of 3


Bye

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
