From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: FW: ADM1021 on Xeon ...
Message-Id: <3DCEBBF6.CC75CCEA@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DCAA055.3070908@netroedge.com>
In-Reply-To: <3DCAA055.3070908@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some clarification here.

The Xeon contains the full i2c slave sensor.
It looks like a 1-sensor adm1021 (the real adm1021 has 2 sensors).
If you load the module with the correct parameters (see
doc/chips/adm1021)
and ignore the 2nd sensor, it should work.

This is all very confusing, and we should really have a dedicated xeon
driver, but nobody has gotten around to it.

you can't add paramters when it's compiled into the kernel, use modules.

mds


Philip Edelbrock wrote:
> 
> Have you run sensors-detect?  From my understanding, a basic temp sensor
> is on the xeon, but the chip (adm1021) is not.  I.e., for it to work,
> your motherboard needs some sort of chip which we can drive which is
> connected to the sensor on the Xeon.
> 
> Phil
> 
> Manish Lachwani wrote:
> 
> >Hello,
> >
> >
> >
> >> -----Original Message-----
> >>From:         Manish Lachwani
> >>Sent: Wednesday, November 06, 2002 1:17 PM
> >>To:   'David_Papasan@Dell.com'; 'mds@paradyne.com';
> >>'sensors@Stimpy.netroedge.com'
> >>Cc:   Manish Lachwani
> >>Subject:      ADM1021 on Xeon ...
> >>
> >>Hello,
> >>
> >>I am making use of 2.4 GHZ Xeon CPUs. Do they have a adm1021 chip on it? I
> >>am using a adm1021.c driver and it cannot detect the adm1021 chip on the
> >>processor. How do I use force_adm1021 when using the adm1021.c compiled in
> >>the kernel?
> >>
> >>Any help is appreciated ...
> >>
> >>Thanks
> >>manish
> >>
> >>
> >
> >
> >
