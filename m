From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 02 Jun 2005 15:07:34 +0000
Subject: [lm-sensors] [Fwd: Linux kernel - i2c - eeprom module]
Message-Id: <429F0489.3070002@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <429C9BCD.1040605@edgedesign.us>
In-Reply-To: <429C9BCD.1040605@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

We are the developers of Linux kernel. There was a request for EEPROM writing on SMBus.
We know that this bus is often used by SPD EEPROMs on DIMM modules.

We would like to know what is current status of write protecting features of those EEPROMs
I found only this:

 DDR2 DIMM SPD Software Write Protect Requirement:

 "The contents of the lower 128 bytes (bytes 0-127) of the SPD EEPROM must
 be software write protected by the DIMM vendor, using one of the two
 methods defined by ballot JC-42.4-03-103 (item 1435.01,) either the
 permanent software write protect method, or the reversible software write
 protect method. This requirement is to be phased in by the end of the first
 quarter of 2004."

 But I failed to find ballot JC-42.4-03-103 (item 1435.01,)

Please can you point me to those documents so we are able to judge if it is safe to add EEPROM writing feature to kernel?

Also I would like to know if anything similar exists for DDR and SDRAM modules.

Thank you,
regards

Rudolf Marek
