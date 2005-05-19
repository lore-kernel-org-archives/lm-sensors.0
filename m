From: wathey@salk.edu (Jack Wathey)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: unrecognized thermal sensor
Message-Id: <20030124083409.J85775-100000@euler.salk.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Dear lm_sensors folks,

First, thanks for all your hard work on lm_sensors.  It's a most useful
tool.

A friend and I are building a 200-processor high-density beowulf cluster
in a custom enclosure.  Monitoring temperature is critical, as you can
imagine.  The motherboards are GigaByte Technologies GA7dpxdw+ dual Athlon
boards.

We started the project by testing an early version of the board, GA7dpxdw.
This uses Winbond W83627HF-AW and a standard thermistor (labeled 5103BJ2)
for the cpus.  lm_sensors has no problem with this and gives believable
temperatures.

We decided to build the cluster with a new version of the board, the
GA7dpxdw+, which is identical to the GA7dpxdw, but with the additional
capability of shutting down the power when the cpu temperature exceeds a
user-specified threshold.  Unfortunately, the GA7dpxdw+ replaces the
thermistor with some new temperature sensor that lm_sensors does not
understand.  The sensor appears to be an 8-lead surface-mounted IC,
about 2.5mm X 2.5mm, and is labeled thus:

    M6AB
    T11C

If we just use lm_sensors as configured to work correctly on the old
(thermistor-equipped) version of the board, temp1 and temp2 (the cpu
temperatures) stay around 27 or 28C when the machine is running full bore,
which we know must be bogus.  The temp3 value is similar, but that could
be correct.  When we try the other sensor alternatives listed in
sensors.conf, we get numbers that are even worse (somewhere around 130C as
I recall, and the numbers don't change when the machine goes from idle to
loaded).

Do you know anything about this new sensor?  What do I need to do to get
lm_sensors to read it correctly?

If you don't know anything about it, can you tell me what kind of
technical questions I need to ask the motherboard manufacturer to be able
to solve this problem?

Finally I have one last question.   I have been unable to find a
temperature sensor for temp3, the motherboard temperature.  Is that built
into the Winbond chip itself?

Thanks in advance for your help!

Best wishes,
Jack Wathey
