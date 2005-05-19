From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Ticket #1018
Message-Id: <E17viwV-0006OX-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm_sensors 2.6.4, RH 7.3, PS fan not showing up.

I've narrowed down the problem.  The configuration switch
 "set  fan3_div 8"  is ignored even though it is in the relevant
chip section for chip as99127f.  I even tried setting all 3 fans and it
was still ignored.

I can get it work by writing the divisor directly to the  /proc file.

But in 2.6.4 or is there something special about the syntax?  Ie,
what's wrong with this:

set fan1_div 2
set fan2_div 2
set fan3_div 8
set fan3_min 600

By setting the divisor to 8 I made it work fine in motherboard monitor
on the same machine when booted under windows.

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
