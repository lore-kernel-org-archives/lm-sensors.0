From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 07 Jun 2006 20:24:51 +0000
Subject: [lm-sensors] LM Sensors Autoconfig Tool - Database aspects
Message-Id: <44873613.10906@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44862F5D.6090404@gmail.com>
In-Reply-To: <44862F5D.6090404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jim Cromie wrote:
> This is an important choice of directions.  Setting that aside for the 
> moment,
> the database has great value in its own right, esp if this is recognized 
> early, and maximized.
> 
> Id suggest looking for available fingerprint-worthy items - they offer 
> the possiblity of
> setting up multiple indices which at minimum could help to optimize the 
> implementation.
> 

I agree after seeing some of the dmidecode posts here it has become
clear to me that dmidecode output alone will not be enough (sigh) as
many bioses don't have proper tables.


> `checksum /proc/cpuinfo`
> 
> that almost works, but is devalued / diffused by the characteristic that
> both cpu-mhz and bogo-mips vary with the current cpufreq.
> Still, it results in a small-finite number for each CPU ( 4-5 for my 
> pentium-M )
> 
> `grep -vE 'cpu MHz|bogomips' /proc/cpuinfo | cksum`
> 

I think this is the better one to use, not sure if we should use
checksums though, it might be better to actually have the output of the
grep command since thats human readable. Also we want to identify the
mainboard not the CPU afaik. Then again some cpu's have build in sensors
connected to the smbus, right?

So we want to identify both the mainboard and the cpu. giving each
a seperate sensors.conf snippet. This makes me like the export the
database as a bunch of flat files and put #include statements in
sensors.conf idea even more, then we can haev a seperate include for
both the mainbaord and the cpu (for cpu's with sensors). This does mean
that the modules must always be loaded in such a way tha the i2c
controller/master on who's bus are the cpu(s) is always controller0!


> `lspci | cksum`
> 
> lspci output, or certain parts of it, are consistent across a batch of 
> motherboards,
> and hence are valuable for identification.
> 
> There are many potential variations on lspci,
> forex:
> $ for device in `lspci -n | cut -d\  -f 4`; do
>     echo lookat $device;    
>     lspci -vv -d $device | cksum;
> done
> 
> Each chunk is a compact unit that is likely to have lots of commonality,
> forex across many motherboards, this would likely be found:
> 
> lookat 8086:24c6
> 00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
> AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
>         Subsystem: Sony Corporation: Unknown device 818c
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 9
>         Region 0: I/O ports at e400 [size%6]
>         Region 1: I/O ports at e080 [size8]
>         Capabilities: <available only to root>
> 
> fingerprints on each line of lspci individually are more likely to avoid
> irrelevant variations like IO ports, etc.  Stripping the 1st column 
> might even be better.
> 
> 00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O 
> Controller (rev 03)
> 00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM 
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
> 01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility 
> Radeon 9600 M10]
> 02:01.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
> 02:01.2 FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI 
> Two-Port PHY/Link-Layer Controller
> 02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
> 02:03.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit 
> Ethernet Controller
> 
> 
> Summarizing, a Mobo-ID is a composite of as many partial fingerprints as 
> possible;
> obviously some items would be identifiable as not part of the 
> motherboard, but cataloging
> them would be cheap (since duplicates are automatically and cheaply 
> detected (by the fingerprint).
> Referential integrity goodness follows.
>

I have been thinking along the same lines, but how can one differ
between onboard peripherals and add in cards with lspci?

>> I own lots of motheboards, however most
>> of them are too different (i want to see, how similar are the reports of
>> dmidecode on "similar" motheboards (i.e. different revisions)).
>>

Do we have different motherboard revisions which are so different that
the revison matters for sensors.conf, or do you want to know this so
that the autoconfig tool will correctly identify all revisions?

--- end of reply ---

My own idea for being able to configure motherboards with a broken (or
no) dmi table was to actually use the motherboard. In my memory dos
tools were able to provide all kinda info on the bios, like version
string, etc. Often the version string contains the mobo model. Anyone
know how these dos tools did this (are these strings at a fixed memory
location, or was it a dos int?).

I'm thinking about a tool which memmaps /dev/mem at 0xf0000 - 0xfffff
where the bios is and making a hexdump to see if I can dig up any
interesting info there which could help us identifying the mainboard.

Now modern bioses are bigger then the 64k window at 0xf0000 - 0xfffff
does anyone know how one gets to the rest of the bios? (a bios checksum
might nbe another way to identify mainboards, yes I know we will have
problems with multiple bios versions).

Regards,

Hans


