From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 driver
Message-Id: <20030705195746.6565ea15.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


If anyone could take a look at my code for the LM83, I'd appreciate it.
This is my first driver, as you must know. I followed the guidelines in
doc/developers/new_drivers, tried to follow the coding standards, but I
may have missed a few things.

I propose the following changes to new_drivers file:

- Change the recommended driver to use as a template. The writer should
use the driver that is the more similar to the chip he is writing a
driver for. I personally used much more the lm75 and adm1021 drivers
than the recommended lm78. And actually, using two different drivers as
templates was great.

- Don't ask for testing with 2.2 kernels! Maybe we should add a line
about sending a 2.5 version (if possible) to Greg KH instead?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
