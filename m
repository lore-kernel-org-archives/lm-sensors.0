From: alexey.y.starikovskiy@linux.intel.com (Alexey Starikovskiy)
Date: Mon, 05 Feb 2007 18:10:37 +0000
Subject: [lm-sensors] ACPI bytecode hardware registers access
Message-Id: <45C7731D.4050309@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C640CF.2090205@assembler.cz> <3877989d0702050003w3e0be4d3q9c475d2c6706f6a8@mail.gmail.com> <45C74337.4060105@assembler.cz> <45C7506A.20402@linux.intel.com> <45C75E20.8010101@assembler.cz>
In-Reply-To: <45C75E20.8010101@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>

Hi,

> I studied ACPI spec once a while and there is only global lock (this is used for
> SMM ) and also there might be some per device mutexes, but I never seen them
> implemented. Maybe there might be implemented some per ACPI device mutex, so
> regions belonging to this device will be locked if the code execution is still
> in device methods. I dont know if it would work for the "globaly" declared
> regions...
>
>   
Mutexes are ACPI internal things, they guard either ACPI BIOS vs. ACPI 
OS-side (Global Lock) or just ACPI os-side.
There is no requirement for mutexes to exist for a physical device, so 
using them to manage access to physical
device will not generally work.
> Second possibility is to have some kind of that port forwarder, which will
> direct the actual access from ACPI to the Linux driver. The driver then knows if
> is safe to read or write from/to that location.
>
> This principle would be also handy for the super I/O because this chips needs
> some magic sequence to open them, read the config and close them. There are many
> drivers (watchdog, parport, irda, mmc, lm-sensors) in the kernel trying to write
> to same super I/O port (0x2e/0x2f) this generic port forwarder would solve it too.
>
> Question for ACPI people: If I would come with some kind of this port-forwarder
> class - will you accept it as solution if all technical stuff is solved? I mean
> - will be solution acceptable in principle for you?
>
>   
You should be careful with such forwarder, as ACPI for example tends to 
be the last to access some ports during shutdown, for example...
As I understand your idea, if physical device driver loads, your port 
forwarder switches direct ACPI access to this driver,
so driver needs to advertise itself as capable of this to "forwarder". 
Also in case of driver suspend/shutdown/unload it needs to notify 
"forwarder",
such that ACPI is able to directly access device again. Also, driver 
should preserve "state" of the device across ACPI accesses,
because ACPI may not initialize device each time. It seems like every 
device will need in addition of having native driver to have a virtual 
one for ACPI...

I will be glad to see any implementation of this :)

Regards,
    Alex.



