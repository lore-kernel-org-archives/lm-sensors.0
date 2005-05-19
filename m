From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: lm_sensors
Message-Id: <20020909102519.D16408@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Mon, Sep 09, 2002 at 11:18:44AM +0300, Ky?sti M?lkki wrote:
>[...]
> 
> However I do not consider current situation very satisfactory:
> 
> 1. Blacklisting by DMI data does not catch new models beforehand.

Pam claims all current and future models will not use this chip (at 
least on Thinkpads).
 
> 2. IBM systems with other than PIIX4 are compromised if admin does not
> run and/or believe sensors-detect warnings and is unaware of the issue.

Yes, there are still configurations which exist which make it possible 
for this problem to crop up again.  I worry particularly about other 
chips which may react negatively to probing.

> 3. If #1 or #2 happens, every existing client driver probing around
> 0x54-0x57 needs a workaround. Including video4linux(2) drivers from
> several sources, and any app using the char device.
>
> I think patching i2c-core to add extra Write Quick within the critical
> section is safe and easy way to handle those issues. This leaves only
> multi-master topologies vulnerable. What do the SMBus specs say, can a
> laptop share SMBus with a docking station, charger etc ?

I'm wary of changing the code at quite that low of a level.  I think 
it's good we tweaked sensors-detect to do what it can to work around 
the issue.  It's also nice to have the blacklist in effect as a 
temporary measure until testing is completed.

Past that, I think we should stay out of most kernel code (with
exception to the blacklisting code).  What we most definitely do not
want to do is change the operation of the code to make it work in an
unexpected way for developers (e.g. having quick writes get duplicated 
for certain addresses and such).

It's a balance between practicality and technical 'correctness'.  I'd
like to keep things as technically correct as possible.  If a chip or
mobo has a broken design, then it's the problem of the manufacturer.  
In practicality, it is nessesary for us to do what we can to make it
safe for users, but I don't want to move away from having the code
work as expected simply to work around someone else's broken hardware
design.


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
