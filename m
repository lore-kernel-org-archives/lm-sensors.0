From: Clemens Ladisch <clemens@ladisch.de>
Date: Tue, 08 Jun 2010 06:32:43 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <4C0DE40B.6030001@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Mon, 07 Jun 2010 09:45:58 -0700, David Mathog wrote:
> >         Product Name            : Quadro FX 1400
> >         PCI ID                  : ce10de
> 
> 6-digit PCI IDs? Wow.

10de:00ce

> > I thought these CPUs had both per core sensors and a package sensor.
> > Why report only the last one?  Maybe because some of Brisbane chips had
> > broken core sensors?  This is Regor though, hopefully with working core
> > sensors.

The K10 CPUs have one internal temperature sensor which is shown
by k10temp, and one thermal diode that can be connected to the
motherboard's temperature sensor chip.

I see in the datasheet that revision D processors (six cores) can be
multi-node processors with two internal sensors, one for the entire CPU
and one for the second node.  As far as I can tell, these would have two
northbridge PCI devices, and the k10temp driver would be attached to
both, resulting in two separate devices with temp1_value.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
