From: John Keates <j.keates@me.com>
Date: Mon, 11 Jun 2012 13:23:51 +0000
Subject: Re: [lm-sensors] asus_atk0110 and Asus P8H61-M
Message-Id: <994123E6-393C-45C4-A2F4-F5F109BEBE10@me.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <A9C6C2CE-B936-4600-8649-6F79007D2BE1@me.com>
In-Reply-To: <A9C6C2CE-B936-4600-8649-6F79007D2BE1@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In that case, would it be worth it to try out the HECI interface to read sensors via Intel QST?
Or maybe find out how the Asus PC Probe2 reads the data? Because I've seen that app run on other systems @ windows, 
and it does have realtime sensor output. Or is dat WMI based? Because if ASUS is moving away from atk0110, but still supplies
working probe apps, there must be another realtime interface.

John

On Jun 11, 2012, at 12:26 PM, Luca Tettamanti wrote:

> On Mon, Jun 11, 2012 at 2:54 AM, John Keates <j.keates@me.com> wrote:
>> Hi,
>> 
>> I'm having trouble setting up lm-sensors (sensord / sensors-detect) on the Asus P8H61-M.
>> I know sensors-detect reports w83627ehf as the SuperIO sensor chip and it's corresponding module as the way to get the sensor data,
>> but that doesn't work with the 3.1 kernel, with the detection of ACPI/BIOS (or EFI in this case) usage of that resource (or address space).
>> Loading the module manually gives the 'resource busy' line, so this requires the asus_atk0110 module to work.
>> 
>> Right now that module doesn't really do anything on my board. It loads, gives no output and stays loaded. (According to lsmod)
>> I understand that Asus sometimes likes to change the atk0110 spec and a DSDT is needed to add support for a specific board.
>> But I don't have a clue how to do that myself, and did see someone mailing this list with his DSDT so someone could pick it up and
>> add support if possible. The same thread had something about the string atk0110 not being in the disassembled DSDT being a problem,
>> so I apt'ed iasl only to find my DSDT not having that string! Does this mean it's not possible to read the sensors via the atk0110 virtual device on this board?
> 
> Yes, unfortunately ASUS is abandoning the ATK interface on newer boards.
> 
>> I don't really want to go back and use the lax setting on the acpi address space handling/detection, so that'd be a bummer..
> 
> The sensors is (AFAICS) only used to notify the host via WMI when the
> temperature of the CPU goes over a threshold. I don't see _what_ call
> that method, probably there's something polling it periodically.
> Using the native driver is the only solution, I don't see any other
> way to access the sensor using ACPI.
> 
>> Another thought, since this is pretty much an EFI board, does it mean you have to be booted in EFI mode to be able to use the atk0110 module?
> 
> It shouldn't matter.
> 
> Luca


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
