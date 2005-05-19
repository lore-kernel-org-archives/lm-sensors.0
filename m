From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: IBM PPC 405 and I2C
Message-Id: <20030803103452.4e553e1f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <006801c35927$0358be50$bd00a8c0@laptop>
In-Reply-To: <006801c35927$0358be50$bd00a8c0@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I am working with a powerpc 405 chip, which supports both master and
> slave in the hardware.  The linux distribution is Montavista Hardhat.
> 
> 1)  The i2c files i2c-algo-ibm_ocp.h, i2c-algo-ibm_ocp.c, and
> i2c-adap-ibm_ocp.c were written by Montavista.  Unfortunately, they do
> not support slave mode.  Has anyone outside Montavista added
> functionality to this code?  Does Montavista provide updates often (it
> appears the code with the Montavista distribution has significant
> modifications over what is distributed with i2c, unfortunately I do
> not have the code available to me now)?

According to the CVS logs, there were no updates from Montavista since
the initial commit back in July 2002. If there are changes that should
make their way to our repository, please let us know.

> 2)  Has anyone successfully insmoded the i2c-algo_ibm_ocp and
> i2c-adap-ibm_ocp modules together?  Insmod complains about recursive
> includes (which is true, the files call on functions in the other
> file) when loading either module.

This requires specific hardware we don't have, so it is unlikely any of
us could try these modules. From my understanding, the adapter needs the
algorithm, and not the other way around. That's the way it seems to work
in our version of the driver. Maybe you could give it a try?

> 3)  There have been several inquiries about using a host/bus in slave
> mode. Has anyone done work on this since the postings?  Are their
> plans to implement this at some point?  What would be required to add
> slave functionality to the core i2c files?

I don't think anyone worked seriously on this. Anyway, this is far over
my knowledge, so I can't help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
