From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: rpm of 0 with smsc47m1 does not cause alarm
Message-Id: <41879A3F.3050304@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I have recently noticed that one of the fans on a box I am monitoring is 
no longer sending a tachometer signal, so sensors(1) indicates the 
RPM=0.  This is as you would expect.   However, I would expect 
sensors(1) to report an ALARM for this fan.   That is not what I am seeing:

smsc47m1-isa-0680
Adapter: ISA adapter
superio,Fan1:
              0 RPM  (min = 1396 RPM, div = 8)
superio,Fan2:
              0 RPM  (min = 1396 RPM, div = 8)


# cat /proc/sys/dev/sensors/smsc47m1-isa-0680/alarms
0

Hmmm...  This indicates to me that maybe the part doesn't
think there's a problem??

I really need to get alarms in the cases where the fans are not working.

In researching this, the fan tachometer has not been working for a long 
time (wiring problem), so if it makes any difference, the superio chip 
has never seen any tachometer signals since power on.

Any suggestions??

David


