From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <20040412183307.6e9d0293.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> OK, so I was blind.

OK, let's form a club ;) Looks like we both like replying to ourselves
today.

> The LPC I/C has moved from 24c0 (801DB) to 24cc
> (82801DBM). I checked the specs at Intel and found that my SMBus is
> disabled wrt to the PCI configuration space, but the I/O space is
> accessible, e.g. the SMBus is there but hidden ...
> 
> What is the best way to proceed? I found a module that deals with a
> similar problem for the DB on ASUS P4B. Should this be dealt with the
> same way? Then I could add 82801DBM support into i2c-i801.c and
> sensors-detect.

Step 1 is to check that the p4b_smbus trick works for you. Just change
the relevant define and try (see my other post).

If step 1 is successfull, i2c-i801.c should work out of the box (it's
the same SMBus device after all). So there is no step 2 ;) Ditto for
sensors-detect, it should work out of the box (we just can chanhge the
description string from "DB" to "DB/DBM").

If it works (whether or not you actually find something on the bus), we
of course want to do update the files in our CVS repository.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
