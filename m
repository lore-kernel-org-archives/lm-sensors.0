From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 05 Feb 2007 03:52:32 +0000
Subject: [lm-sensors] ACPI bytecode hardware registers access
Message-Id: <4dfa50520702041952k6f92b0e1p2efca812918dd3f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C640CF.2090205@assembler.cz>
In-Reply-To: <45C640CF.2090205@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>, LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

Hi all,

I am not on the linux-acpi list, so please include me in the To: for
future replies.

> What it does? It reads the register 0x50 in bank 1 of W83627EHF chip.
> The register for bank switch is 0x4e.
>
> The w83627EHF driver update function is also changing the bank switch
> register. We have seen already that this might be wrong - you will read
> nonsense when in wrong bank... This happened in the past already - with
> some other drivers and hw :
>
> http://www.lm-sensors.org/ticket/2072

The w83627ehf driver sets the bank register, causing all the problems,
for only a short period of time. The functions in w83627ehf.c are
w83627ehf_read_value and w83627ehf_write_value.

The good news is that adding a mutex to these functions would not be
any problem. Any program accessing the sysfs to read values from the
driver should be able to wait while the ACPI does its thing.

However, the bad news is, as you already said, where to find such a
mutex for the ACPI.

Here are my thoughts on the proposed solutions:

> 1) APCI AML code based locks.

Relying on ACPI to implement a lock is a risk. Some motherboards might
have broken ACPI (happens all the time!) with no locking or broken
locking.

However, this would be the easiest solution.

I am opposed to relying on ACPI to provide locking because the
motherboard manufacturers are not likely to fix old motherboards and
broken ACPI code. Meanwhile, linux and lm-sensors will take the blame.

> 2) some ACPI subsystem locking

This has the same problems as above. I am not going to make a claim
about your suggestion:

> Is it possible to stop/resume ACPI bytecode execution

I'm not familiar enough with the ACPI specification to say whether
this would work or not.

> 3) resource region locking

A hwmon driver would not deadlock on suspend or resume, but other
drivers probably would...

> 4) port forwarding

This sounds like the best idea. It would require a gradual migration
of drivers, but a driver that provides port forwarding support would
be able to coordinate ACPI or any other SMBus access and avoid
conflicts. It might even make sense to write a generic port-sharing
driver (total size < 1K) that would be loaded by a driver like
w83627ehf. Then the generic port-sharing driver would handle all
requests--from ACPI and w83627ehf. What do you think?

David

