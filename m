From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(Sorry, couldn't figure out how to amend a ticket through
the web interface.)

In reply to ticket 1775 the response was:

> try changing sensor type to 3435 in sensors.conf

The sensors.conf from Tyan (and every other one I've
found on the web for this mobo) says to do this:

 # thermal sensor types (do not adjust)
   set sensor1 2
   set sensor2 2
   set sensor3 2

Moreover, those settings worked on the same machine when
it ran RH 7.3 and an older version of lm_sensors.  However,
now they do not work (kernel 2.8.6.1 and sensors 2.8.7).
Since the hardware type of the sensor on the mobo clearly has
not changed (only the OS) why would the sensor type change now
from 2 to 3435 with a different version of the kernel or
lm_sensors???

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
