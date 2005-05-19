From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <20040302015135.GB30448@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Quoting Charles Galpin <charles@defenderhosting.com>:
> > How can I explain the concept of "activating the AMD-8111 SMBus" to 
> > him? What do you need - memory locations to address the chip with?

* Jean Delvare <khali@linux-fr.org> [2004-03-01 18:27:58 +0100]:
> Modern computers are mostly made of PCI devices. This is what lspci
> lists. Each device has one or more "functions" (understand:
> sub-devices).  Devices also belong to a group or bus. This is the
> meaning of the three values in front of lspci's line. For example,
> "00:09.0" means bus 0, device 9, function 0.
> 
> In your specific case your lspci shows:
> (...)
> 00:07.1 Class 0101: 1022:7469 (rev 03)
> 00:07.3 Class 0680: 1022:746b (rev 05)
> (...)
> 
> The AMD-8111 SMBus function has PCI ID 1022:746a. It should obvously
> show between the two other lines as function 2 of PCI device 7 on bus
> 0. But it does not.
> 
> It is almost certain that this function *is* here (because the device
> is, and you cannot easily remove a function from a given device). It it
> doesn't show up, this is because the BIOS has been told to remove it
> from the PCI devices list.
> 
> The reason why manufacturers sometimes do this are obscure. One often
> heard reason is that it would frighten Windows user because it would
> appear as a unknown device in the System panel. Anyway, we had to deal
> with similar behaviors on some ALi and Intel chipsets so far. Never
> with AMD.

Also SiS chipsets.  Keep in mind that the BIOS comes from the board maker,
not the chipset maker... e.g. both Asus/SiS and Asus/Intel boards often
do this.

> Usually, the solution it to change the value of some bits in some place.
> The question is: which bits, which place. We cannot guess that without
> documentation.
> 
> So basically you need to ask them what operation is needed to re-enable
> that specific PCI function.

If they won't tell you this, there may be another way:

If they provide a system monitoring app for Windows, see if you can get
it to run under Wine.  Email me off-list for help with that.  If you
can get that working, we can probably find out how to enable the device.
That's exactly what I did for the SiS96x quirk.

Jean: 

I quickly browsed through this datasheet, and I see nothing obvious...

http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24674.pdf

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
