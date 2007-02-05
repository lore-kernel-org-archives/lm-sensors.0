From: r.marek@assembler.cz (Rudolf Marek)
Date: Mon, 05 Feb 2007 16:41:04 +0000
Subject: [lm-sensors] ACPI bytecode hardware registers access
Message-Id: <45C75E20.8010101@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C640CF.2090205@assembler.cz> <3877989d0702050003w3e0be4d3q9c475d2c6706f6a8@mail.gmail.com> <45C74337.4060105@assembler.cz> <45C7506A.20402@linux.intel.com>
In-Reply-To: <45C7506A.20402@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>

Hello Alex,

Thanks for the comments.

> Why do you think such a solution exists?

I asked help to find a solution, this does not mean I believe there is one.

> One solution would be to create generic "thermal" interface, under which all
> drivers could provide their capabilities... Say if lm-sensors could keep
> system from overheating, it could say so, and system could skip loading of
> ACPI thermal driver. Problem is, lm-sensors doesn't know, what to do to
> control system. You still need to figure out, that for example turning fan #3
> on helps to decrease temp #2... It's not possible to associate termal devices
> of ACPI with those from lm-sensors, so lm-sensors cannot steal info about 
> trip-points from ACPI, or use ACPI as a governor.

Well this is quite a different level of abstraction. I believe that thermal
control for laptops should be left alone, or driven by ACPI.

My current focus is to stop changing the registers from ACPI AML same time as
other drivers are using same device. (on desktop/server systems) This causes
problems to APCI and also to other drivers. Once such collision is detected we
may warn the user to use for example just the thermal module and not lm-sensors
one...

In ideal case user should use the ACPI thermal policy OR the lm-sensors, but
without the actual inspection of ACPI bytecode there is no chance to know if
ACPI and lm-sensors driver are talking to same chip? (maybe through the I/O
space regions it may work, however not for smbus bused stuff, because it will
advertise the controller and not the actual smbus device)

> Returning to your example, there are two registers in ACPI space, access to
> which should be locked by single mutex. So you could provide mapping from I/O
> address to mutex. So if ACPI wants to access IO register, it asks, which
> mutex it should acquire. Question on how to extend mutex lock until access to
> second register remains open...

So if I understand correctly you propose something like I did in 3) in my
original post. However this will not help much because we need to hold the mutex
longer time. If I look from the "other" side, typical driver just sets the bank,
do the reads/writes and then does not care about it. This could be generalized -
the driver guards its "transactions" - once done it does not care what happens
with the device (suppose the driver preserves the chip state after transaction
is done - this is easy for monitoring chips but hard for smbus cotrollers)

I studied ACPI spec once a while and there is only global lock (this is used for
SMM ) and also there might be some per device mutexes, but I never seen them
implemented. Maybe there might be implemented some per ACPI device mutex, so
regions belonging to this device will be locked if the code execution is still
in device methods. I dont know if it would work for the "globaly" declared
regions...

Second possibility is to have some kind of that port forwarder, which will
direct the actual access from ACPI to the Linux driver. The driver then knows if
is safe to read or write from/to that location.

This principle would be also handy for the super I/O because this chips needs
some magic sequence to open them, read the config and close them. There are many
drivers (watchdog, parport, irda, mmc, lm-sensors) in the kernel trying to write
to same super I/O port (0x2e/0x2f) this generic port forwarder would solve it too.

Question for ACPI people: If I would come with some kind of this port-forwarder
class - will you accept it as solution if all technical stuff is solved? I mean
- will be solution acceptable in principle for you?

Thanks,

Regards
Rudolf

Keep me CCed thanks.


