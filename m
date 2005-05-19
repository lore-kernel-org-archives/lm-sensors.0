From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: configuration question
Message-Id: <3EE691E8.4060800@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055285973.16327.61.camel@saint>
In-Reply-To: <1055285973.16327.61.camel@saint>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Another way to attack this would be to create some "standard" labels 
that your SNMP module would look for.

Then a user of your script would need to make sure the sensors.conf uses 
the "LABEL" directive to name the appropriate values correctly.  In that 
way, your script is independant of the chipset in use.

You could then create entries for -5V, 5V, 3.3V, 12V and -12V (which are 
the standard power supply voltages and generally available). 
5V-standby, 3.3V-standby and Vbat (battery voltage) are also frequently 
available.

Then create a table? for Fan speeds and number them fan1, fan2, fan3. 
Some motherboards have multiple monitoring chips and can monitor as many 
as 6 or more fans.

Basically, pick a common subset of readings and then name them in a 
standard way.  We may be doing something along these lines for the next 
release of the libsensors library...

:v)

Charles Holbrook wrote:
> I have written a script that calls sensors parses the data and then
> loads that data into a MIB tree with either ucd or net SNMP.  I have run
> into a small problem with the via686a chipset though.  In all other
> chipset configs you can set an inX even if that chipset doesn't
> monitor(causing either a bad or null value to be returned)  However with
> the via686a chipset I have not been able to figure out for the life of
> me how to do that.  The reason I am trying to create placeholders for
> all values that can be monitored is so that the same MIB structure would
> apply across all systems.
> 
> EXAMPLE:
> .1.3.6.1.4.1.2021.5822.20.101.20 is -5V on a system with the
> w83627hf-isa-0290 chipset and even if it wasn't there I could add a line
> for in6 creating that value.
> 
> .1.3.6.1.4.1.2021.5822.20.101.20 on a via686a motherboard will return a
> fan RPM speed.
> 
> Because of this difference I cannot actually use this to get any usefull
> data from my server cluster.  Having a mib return different values
> depending on the chipset is a bad bad thing.  Is there a set command I
> can use in the config script to force the via686a configuration to
> insert a line for -12V or for that matter any place holder I want to
> create?
> 
> Thanks in advance.
> 
> 
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
