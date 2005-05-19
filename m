From: cholbrook@hi-privacy.net (Charles Holbrook)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: configuration question
Message-Id: <1055285973.16327.61.camel@saint>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have written a script that calls sensors parses the data and then
loads that data into a MIB tree with either ucd or net SNMP.  I have run
into a small problem with the via686a chipset though.  In all other
chipset configs you can set an inX even if that chipset doesn't
monitor(causing either a bad or null value to be returned)  However with
the via686a chipset I have not been able to figure out for the life of
me how to do that.  The reason I am trying to create placeholders for
all values that can be monitored is so that the same MIB structure would
apply across all systems.

EXAMPLE:
.1.3.6.1.4.1.2021.5822.20.101.20 is -5V on a system with the
w83627hf-isa-0290 chipset and even if it wasn't there I could add a line
for in6 creating that value.

.1.3.6.1.4.1.2021.5822.20.101.20 on a via686a motherboard will return a
fan RPM speed.

Because of this difference I cannot actually use this to get any usefull
data from my server cluster.  Having a mib return different values
depending on the chipset is a bad bad thing.  Is there a set command I
can use in the config script to force the via686a configuration to
insert a line for -12V or for that matter any place holder I want to
create?

Thanks in advance.


