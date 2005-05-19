From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: lm_sensors
Message-Id: <Pine.OSF.4.44.0209090902040.26706-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 8 Sep 2002 phil@netroedge.com wrote:

>
> Just to throw my $.02 in, I think Kyosti is right to say the problem
> isn't really ideally fixed, however we've made some significant
> progress in making it fairly safe for known users with this chip.

Agreed.

> As far as adding locking goes, I can't think of a reason why we need
> locking to implement the I2C/SMBus protocol.  It would be the safest
> way to go to implement a completely reliable workaround for this
> particular issue, but is it *right*?  Unless we are going to need this
> locking mechanism as a standard feature, I would opt to not implement
> it.  Are there are any other devices which require that consecutive
> transations (not just with it, but all bus transactions) to be tightly
> controlled?  Do we have reason to believe that there may be more in
> the future?

The special Start and Stop sequences quarantee mutual exclusion even on
multi-master buses. Eg. Read Byte/Word sequences do not send Stop
between selecting register and reading contents. There should be no need
to promote further bus locking for user-space.

> The nice thing with putting drivers in the kernel is that we can allow
> everyone access to the bus w/o the risk of someone hogging control of
> it.  If we add locking, we potentially lose that if a user-space app
> abuses the locking feature.

I agree.

However I do not consider current situation very satisfactory:

1. Blacklisting by DMI data does not catch new models beforehand.

2. IBM systems with other than PIIX4 are compromised if admin does not
run and/or believe sensors-detect warnings and is unaware of the issue.

3. If #1 or #2 happens, every existing client driver probing around
0x54-0x57 needs a workaround. Including video4linux(2) drivers from
several sources, and any app using the char device.

I think patching i2c-core to add extra Write Quick within the critical
section is safe and easy way to handle those issues. This leaves only
multi-master topologies vulnerable. What do the SMBus specs say, can a
laptop share SMBus with a docking station, charger etc ?

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi

