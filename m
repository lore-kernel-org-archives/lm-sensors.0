From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: lm_sensors
Message-Id: <Pine.OSF.4.44.0209071707450.18572-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Sep 2002, Mark D. Studebaker wrote:

> Kyosti has described some ways in which the 24RF08 could still
> theoretically be corrupted (on non-IBM systems). While not disagreeing
> with him, I think we need to draw the line somewhere, and in my
> opinion we have a good explanation for Alan Cox that we have both
> blacklisted the IBM systems _AND_ fixed the actual problem on non-IBM
> systems, if there are any.

I think we should not claim the actual problem fixed until adapter
lock is held between the two Write Quicks. Unless of course, if you
can convince Alan Cox that it hardly ever happens...

1. Module eeprom.o

Generates Quick + multiple Read sequences if loaded with chksum!=0.

Lucky we are, even number of Quicks protects 24rf08 from being
corrupted by future transactions, but the lock issue applies here.
I do not know if loading another client "simultaneuosly" is safe.

2. Two Write Quicks are breaken apart, since adapter lock is released

Only single Write Quick in i2cdetect - but even number of those, and
two Write Quicks in sensors-detect but releasing the bus in between.
Just running sensors-detect twice may be harmful. First run loads
sensor client that polls readings every five seconds or so.


> I don't see how we can prevent corruption in a multi-master system.

If 0x54-0x57 is known to be any eeprom, Write Byte could replace Write
Quick for the address probe.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi



