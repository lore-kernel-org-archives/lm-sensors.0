From: alexey.y.starikovskiy@linux.intel.com (Alexey Starikovskiy)
Date: Mon, 05 Feb 2007 15:42:34 +0000
Subject: [lm-sensors] ACPI bytecode hardware registers access
Message-Id: <45C7506A.20402@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C640CF.2090205@assembler.cz> <3877989d0702050003w3e0be4d3q9c475d2c6706f6a8@mail.gmail.com> <45C74337.4060105@assembler.cz>
In-Reply-To: <45C74337.4060105@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

Rudolf Marek wrote:
> Problem is that the device manufacturers may do what they want in ACPI 
> bytecode.
>   We cannot expect them to implement smbus bus control as specified in the
> specs. They just drive the registers on their own.
>
> What I'm trying to implement is the ACPI isolation from selected hardware
> somehow, because the ACPI bytecode can contain code that modifies virtually any
> hardware in the system without the clue what others drivers do.
>
> Even the windows don't like it:
> http://www.microsoft.com/whdc/system/pnppwr/powermgmt/BIOSAML.mspx
> (I/O Ports Blocked from BIOS AML)
>
>   
There are no any devices in the list above (e.g. there is no 
sm-bus/fan/thermal, e.t.c chip blocked).
> Please help me find the solution.
>   
Why do you think such a solution exists? One solution would be to create generic "thermal" interface, under which all drivers could provide their capabilities... Say if lm-sensors could keep system from overheating, it could say so, and system could skip loading of ACPI thermal driver.
Problem is, lm-sensors doesn't know, what to do to control system. You still need to figure out, that for example turning fan #3 on helps to decrease temp #2... It's not possible to associate termal devices of ACPI with those from lm-sensors, so lm-sensors cannot steal info about trip-points from ACPI, or use ACPI as a governor. 

Returning to your example, there are two registers in ACPI space, access to which should be locked by single mutex. So you could provide mapping from I/O address to mutex. So if ACPI wants to access IO register, it asks, which mutex it should acquire. Question on how to extend mutex lock until access to second register remains open...

Regards,
	Alex.

