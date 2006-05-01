From: marc.lefevre@hp.com (LeFevre, Marc)
Date: Mon, 01 May 2006 15:13:50 +0000
Subject: [lm-sensors] Driver question
Message-Id: <347F0EE2DB29484092B27DF737737AC204DA12EB@idbexc01.americas.cpqcorp.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <347F0EE2DB29484092B27DF737737AC2040E12B9@idbexc01.americas.cpqcorp.net>
In-Reply-To: <347F0EE2DB29484092B27DF737737AC2040E12B9@idbexc01.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the reply.  Can you point me to a location for the driver?

Marc 

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Monday, May 01, 2006 9:03 AM
To: LeFevre, Marc
Cc: LM Sensors
Subject: Re: [lm-sensors] Driver question

Hi Marc,

> When I run sensors-detect on my system (HP XW6200 running RHES4), it 
> tells me that I need the smsc47b397 module.  However, I don't have it.
> I have studied the lm-sensors website and googled the 47b397 to death,

> but have not found what I think is a driver I can use.  I have found 
> some references to patches, but I don't know how to take that 
> information and solve the problem on my system.
> 
> Does this driver (module) exist or was that module name just derived 
> from the chip name and the module has not been written yet?

The driver exists, but may not be available on older distributions. It
was first added to linux 2.6.11. I guess that you have 2.6.9 in RHEL4.

You may try to backport the driver, or ask Red Hat to do it if you have
a support contract with them and they are willing to do it.

--
Jean Delvare

