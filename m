From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 20 Feb 2008 05:41:44 +0000
Subject: Re: [lm-sensors] adt7475 support status update?
Message-Id: <Pine.LNX.4.64.0802192335001.6941@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B32CEF.40405@hhs.nl>
In-Reply-To: <47B32CEF.40405@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 Feb 2008, Jordan Crouse wrote:
> Updated patch against HEAD is attached.  Thanks.

I finally got around to checking the fan speed reporting and it appears
to work fine.  At the moment I only have one spare fan, but I swapped it
around to the various fan connectors on my Asus M2N-SLI Deluxe
motherboard and Jordan's driver read them all.  The fan idled at about
3000 rpm (this was with the BIOS set to "Performance" chassis fan speed),
and the speed went down when I put my thumb on the hub of the fan.  The
particular fan I used was the one supplied by Intel on the heat sink of
an old Pentium II processor; it says "12 V 0.06 A Sanyo Denki" on it.

For reference, the mapping from motherboard connectors to chip inputs on
this particular motherboard seems to be:

Input          Connector
it8716 fan 1   CPU
it8716 fan 2   Chassis 1
it8716 fan 3   Power
adt7475 fan 1  Chassis 4
adt7475 fan 2  Chassis 2
adt7475 fan 3  Chassis 3
adt7475 fan 4  Probably no connection

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
