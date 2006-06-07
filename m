From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 07 Jun 2006 01:43:57 +0000
Subject: [lm-sensors] LM Sensors Autoconfig Tool - Database aspects
Message-Id: <44862F5D.6090404@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ivan Barrera A. wrote:
> Hi !
>
> I recently subscribed to the list, as i'll be the one developing an
> Autoconfig Tool for Lm Sensors.
>
> I've been taking a look with Hans de Goede in which way is the best to
> identify a motheboard, and each sensor. (as well, as how to write a user
> tool which will look into the database and write the configuration).
>
> The project consist en 2 main parts :
>
> 1 - A web application which will mantain a database with the info about
> motheboard - sensors and configurations. (as well as some "use notes").
> 2 - User tools which will be able to query the database and get the
> correct configuration for the motheboard/sensors detected.
>
> For this month's end i pretend to have a basic working website, as well
> as a basic user-tool.
> The next month, i'll want to work on the details (some gui, more
> advanced website, etc)
>
> Now, i'm working on how to detect correctly different motheboards and
> sensors, to build the database. 

This is an important choice of directions.  Setting that aside for the 
moment,
the database has great value in its own right, esp if this is recognized 
early, and maximized.

Id suggest looking for available fingerprint-worthy items - they offer 
the possiblity of
setting up multiple indices which at minimum could help to optimize the 
implementation.

`checksum /proc/cpuinfo`

that almost works, but is devalued / diffused by the characteristic that
both cpu-mhz and bogo-mips vary with the current cpufreq.
Still, it results in a small-finite number for each CPU ( 4-5 for my 
pentium-M )

`grep -vE 'cpu MHz|bogomips' /proc/cpuinfo | cksum`

Fixes (ie complements) the N-equivalent cpuinfo-fingerprints, and serves 
as something of a
related / grouping function.

`lspci | cksum`

lspci output, or certain parts of it, are consistent across a batch of 
motherboards,
and hence are valuable for identification.

There are many potential variations on lspci,
forex:
$ for device in `lspci -n | cut -d\  -f 4`; do
    echo lookat $device;    
    lspci -vv -d $device | cksum;
done

Each chunk is a compact unit that is likely to have lots of commonality,
forex across many motherboards, this would likely be found:

lookat 8086:24c6
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
        Subsystem: Sony Corporation: Unknown device 818c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at e400 [size%6]
        Region 1: I/O ports at e080 [size8]
        Capabilities: <available only to root>

fingerprints on each line of lspci individually are more likely to avoid
irrelevant variations like IO ports, etc.  Stripping the 1st column 
might even be better.

00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O 
Controller (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility 
Radeon 9600 M10]
02:01.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
02:01.2 FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI 
Two-Port PHY/Link-Layer Controller
02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
02:03.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit 
Ethernet Controller


Summarizing, a Mobo-ID is a composite of as many partial fingerprints as 
possible;
obviously some items would be identifiable as not part of the 
motherboard, but cataloging
them would be cheap (since duplicates are automatically and cheaply 
detected (by the fingerprint).
Referential integrity goodness follows.


> I own lots of motheboards, however most
> of them are too different (i want to see, how similar are the reports of
> dmidecode on "similar" motheboards (i.e. different revisions)).
>
>   

for dmidecode, a multiple-partial-fingerprint approach would parse on 
each chunk:

@chunks = split (/^Handle 0x\d{4}\n/ms, $buffer);

then compute checksum/fingerprints on each chunk.


A point I hope has emerged here is that ideally, we can add new
characterizations / fingerprints / thingys over time, and expect the 
database
to gracefully absorb the new data, and help relate it with the old.

Offhand, a single self-referential table, keyed entirely off the checksums,
could hold cblobs of output, and one other column could 'type' the value. 
I wonder how far 200k rows would get toward cataloging
every chunk we could reasonably throw at it.



> I've been reading the earlier posts about his, to see more ideas on how
> to detect this configurations. So, if any has ideas on this, let me know.
>
> I don't want to be a pain to the list, so, i'll keep informed on
> relevant issues working on the project. (as well, as some personal
> questions about some drivers :) )
>
>   

$.02 -  This is why the list exists - to enhance progress towards 
penguin heaven ;-)
This is emphatically on-goal, if not on-topic.

That said, I could have just gone waaay off the deep end :-D

> Well, this is just an introduction post. I'll write more as soon as i
> have more news.
>
>
>   
welcome, and thanks in advance.

> Ivan Barrera A. [Bruce]
>
> PS: Excuse my english. It's a little rusty , as i haven't practiced in
> some time.
>   
I hope Ive managed to be as clear ..

-jimc

