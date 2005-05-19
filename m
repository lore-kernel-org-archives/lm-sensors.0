From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: lm_sensors:  PCA9549, MAX6653
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440564837D@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079465318.4136.52.camel@pavement.sandburst.com>
In-Reply-To: <1079465318.4136.52.camel@pavement.sandburst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Re the max 6650 - I wrote that originally. If you have any questions about
it (or fixes :-)
during your port, I'd be glad to help.

J.

> -----Original Message-----
> From: Travis B. Sawyer [mailto:tsawyer@sandburst.com]
> Sent: Tuesday, March 16, 2004 11:29 AM
> To: sensors@Stimpy.netroedge.com
> Cc: tsawyer@sandburst.com
> Subject: lm_sensors: PCA9549, MAX6653
> 
> 
> Greetings!
> 
> I'm working on an embedded linux project that includes use of the i2c
> busses on a ppc440gx.
> 
> I've download/patched my kernel source with the I2C 2.8.4 and 
> LM Sensors
> 2.8.5.
> 
> However, our project includes the use of several PCA9548 (8 port i2c
> mux), and MAX6653 (fan controller & temp sensor)
> 
> I found the patch from Brian Kuschak for subordinate busses 
> and patched
> that in (with some hand patching).  I'm hoping that'll work for the
> pca9548, but I don't have high hopes.
> 
> For the 6653 I plan on basing code on the 6650 driver that currently
> exists.
> 
> Is this a feasible attempt?  Is someone already developing 
> the drivers I
> need?
> 
> Thanx for the 2 packages, some of the devices we're using are already
> support, makes my life much easier!
> 
> -travis
> 
> -- 
> Travis B. Sawyer
> Sandburst Corporation  http://www.sandburst.com
> (978) 689-1620
> 
> 
