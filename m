From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: what about thinkpad?
Message-Id: <20030216205815.4db8176e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1045415814.1826.5.camel@localhost.localdomain>
In-Reply-To: <1045415814.1826.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I recently bought a refurbished IBM thinkpad 600E. I like Red Hat
> Linux, but I found in www.linux-thinkpad.org that lm_sensors and I2C
> can damage the mother board.
> 
> Do you have a solution for this?, have a plan for the future? or I
> have to change distro?

The current "solution" is that we won't let you run lm_sensors (at
least, not recent versions) on this hardware. FYI, the whole thing isn't
distribution-related. Running lm_sensors on your thinkpad could really
damage it, so don't do it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
