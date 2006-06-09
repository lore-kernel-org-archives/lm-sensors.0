From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 09 Jun 2006 23:46:25 +0000
Subject: [lm-sensors] LM Sensors Autoconfig Tool - Database aspects
Message-Id: <448A0851.2070508@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44862F5D.6090404@gmail.com>
In-Reply-To: <44862F5D.6090404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:

hi Hans,

> Jim Cromie wrote:
>   
>> This is an important choice of directions.  Setting that aside for the 
>> moment,
>> the database has great value in its own right, esp if this is recognized 
>> early, and maximized.
>>
>> Id suggest looking for available fingerprint-worthy items - they offer 
>> the possiblity of
>> setting up multiple indices which at minimum could help to optimize the 
>> implementation.
>>
>>     
>
> I agree after seeing some of the dmidecode posts here it has become
> clear to me that dmidecode output alone will not be enough (sigh) as
> many bioses don't have proper tables.
>
>
>   
Ooh that sounds like agreement of sorts -

I went back to the webite you posted links to, what you said there seems
more reliant on dmidecode than I think you're thinking now..

We have a quality of information problem.  This is true on many levels .
We're trying to improve an untenable situation ( trying to make optimized
configuration decisions based upon incomplete info about nearly
un-knowable mobo environs, at least wrt probing currently) with other 
imperfect info.
- improve Q of the data which drives choices
- use more data
    - must learn which data is good


>> `checksum /proc/cpuinfo`
>>
>> that almost works, but is devalued / diffused by the characteristic that
>> both cpu-mhz and bogo-mips vary with the current cpufreq.
>> Still, it results in a small-finite number for each CPU ( 4-5 for my 
>> pentium-M )
>>
>> `grep -vE 'cpu MHz|bogomips' /proc/cpuinfo | cksum`
>>
>>     
>
> I think this is the better one to use, not sure if we should use
> checksums though, it might be better to actually have the output of the
> grep command since thats human readable.

Id say we want both and both:
    checksum and content,
    modified content and modified checksum.
Both contain unifying report-number.

why both ? we can learn (in this particular case)
- how many different frequencies this CPU/MOBO can run at
- whether this CPU can do more than this MOBO
- for CPUs that match on a group of frequencies,
    how many reported into each bucket ?
- the raw data can be cleaned out if
    we need the space
    many rows (thousands) collapse to single cooked one
    thousands means mature, uninteresting here..

The key is storing chunks that are profitably comparable.


>  Also we want to identify the
> mainboard not the CPU afaik. Then again some cpu's have build in sensors
> connected to the smbus, right?
>
>   
The CPU and the MOBO are highly correlated - which seems important
in this "recognize good data automatically" world we're in.


> So we want to identify both the mainboard and the cpu. giving each
> a seperate sensors.conf snippet. This makes me like the export the
> database as a bunch of flat files and put #include statements in
> sensors.conf idea even more, then we can haev a seperate include for
> both the mainbaord and the cpu (for cpu's with sensors).

from a user-standpoint I dont care about includes.
On the 2 machines I run regularly, one is acpi, the other is sensors.conf
is edited down to the 1 device I have.
from the admin / dist / cvs view I agree completely

and out of pure curiousity,     I would look at sensors.conf.cpu-* files 
to see who has what..

>  This does mean
> that the modules must always be loaded in such a way tha the i2c
> controller/master on who's bus are the cpu(s) is always controller0!
>
>
>   
umm  no idea what that means,
or in the end how much it would matter....
If there are 2, 5, or 10 slot variations that the database collects,
we would learn that, esp with decent web-query front ends.

Bugzilla almost surely has some established practices wrt this,
others abound too.  Thats a give-take between you, the 4 team members,
and the foundation.

>> `lspci | cksum`
>>
>> lspci output, or certain parts of it, are consistent across a batch of 
>> motherboards,
>> and hence are valuable for identification.
>>
>> There are many potential variations on lspci,
>> forex:
>> $ for device in `lspci -n | cut -d\  -f 4`; do
>>     echo lookat $device;    
>>     lspci -vv -d $device | cksum;
>> done
>>
>> Each chunk is a compact unit that is likely to have lots of commonality,
>> forex across many motherboards, this would likely be found:
>>
>> lookat 8086:24c6
>> 00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
>> AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
>>         Subsystem: Sony Corporation: Unknown device 818c
>>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0
>>         Interrupt: pin B routed to IRQ 9
>>         Region 0: I/O ports at e400 [size%6]
>>         Region 1: I/O ports at e080 [size8]
>>         Capabilities: <available only to root>
>>
>> fingerprints on each line of lspci individually are more likely to avoid
>> irrelevant variations like IO ports, etc.  Stripping the 1st column 
>> might even be better.
>>
>> 00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O 
>> Controller (rev 03)
>> 00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM 
>> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
>> 01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility 
>> Radeon 9600 M10]
>> 02:01.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
>> 02:01.2 FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI 
>> Two-Port PHY/Link-Layer Controller
>> 02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
>> 02:03.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit 
>> Ethernet Controller
>>
>>
>> Summarizing, a Mobo-ID is a composite of as many partial fingerprints as 
>> possible;
>> obviously some items would be identifiable as not part of the 
>> motherboard, but cataloging
>> them would be cheap (since duplicates are automatically and cheaply 
>> detected (by the fingerprint).
>> Referential integrity goodness follows.
>>
>>     
>
> I have been thinking along the same lines, but how can one differ
> between onboard peripherals and add in cards with lspci?
>
>   
Heres how.

Consider a new report coming in from a desktop, which is likely
to have both on-the-mobo stuff, and pci cards plugged in.
Laptops will probably have more built-ins.

If that report is 'parsed' into the right chunks, those chunks are trivially
matchable on (any) existing rows.

Ok, so the new report has been chunked, and the results are:

3664734889
517486700
1357016642
2667015379
3591110619
3186403710
1684482534
2594428371
1744699660

Ok  - not too helpful, you think.  (Im hiding the content to make a point)

If 3664734889 has been found in > 500 reports, coming from both
AMD and Intel machines, 80 % of which are desktops, its a pretty fair bet
that its a plug-in card of some flavor, and not particularly useful to 
your quest.

lets suppose you do the right thing, look at the output text, pull out the
pci device-id,and figure out that its a vortex-card, sitting in PCI slot X

    mv 3664734889  3664734889-vortex-boomerang-pci-sX

Later, we add a filter, active for lspci-chunks, that extracts the 
bus-addys, and anything
else that we might want to histogram (rather than save raw).  With 5-6 
slots max
on 90% mobos today, you get a lot by saving the histogram, and dumping 
the raw.

that identified chunk is now available for regexification, and use against
raw data, both new ones, and ones already in the database - thus we get
more info out of our data-collection.

ok - a bit fabricated.. lets try another (yeah right, like this ones not 
loaded too ;-)

suppose youve got a chunk that has showed up a dozen times, but hasnt
been annotated in any way.  All we know is that 12 reports showed the
same piece of content (quite distinct from same whole-document !!)

So, we look at it :

soekris:/sys/bus/i2c/devices/9191-6620# ls
alarms_in      in1_input   in4_min     in8_input     temp2_crit    
temp4_status
alarms_temp    in1_max     in4_status  in8_max       temp2_input   
temp5_crit
bus@           in1_min     in5_input   in8_min       temp2_max     
temp5_input
cpu0_vid       in1_status  in5_max     in8_status    temp2_min     temp5_max
driver@        in2_input   in5_min     in9_input     temp2_status  temp5_min
hwmon:hwmon0@  in2_max     in5_status  in9_max       temp3_crit    
temp5_status
in0_input      in2_min     in6_input   in9_min       temp3_input   
temp6_crit
in0_max        in2_status  in6_max     in9_status    temp3_max     
temp6_input
in0_min        in3_input   in6_min     name          temp3_min     temp6_max
in0_status     in3_max     in6_status  temp1_crit    temp3_status  temp6_min
in10_input     in3_min     in7_input   temp1_input   temp4_crit    
temp6_status
in10_max       in3_status  in7_max     temp1_max     temp4_input   uevent
in10_min       in4_input   in7_min     temp1_min     temp4_max     vrm
in10_status    in4_max     in7_status  temp1_status  temp4_min

wow - that looks familiar !  (to some of you)

Now lets suppose the 12th man to send a report that *hits* this record is
Henrik Brix Anderson (name-dropping is fun).  When he sent his report in,
he used his real email, and got an auto-reply.  He read that, saw that the
tool didnt recognize stuff about a computer that he has, and knows a 
bunch about.
He follows links in the email, and uploads his /etc/sensors.conf, and 
his url.
The app sends an email to every reporter about the event / uploaded 
goodness.

Too blue sky ! the naysayers cry (not that Im calling you one Hans,
just taking keyboard liberties).  Actually, Id think an extension to 
bugzilla
or many other working systems is the fastest & surest way to a killer app.

Another contrived example

Suppose we have a chunk in the db thats unique -
we know its a small chunk, since we adopted that strategy
but still - nobody else has encountered that hardware / thingy ?
So we look at it.  (notice that up til now, nobody has)

02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 06)
        Subsystem: Intel Corporation: Unknown device 2751
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 6000ns max), Cache Line Size 10
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at ff6fd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

that also looks familiar - lets query for text matches 2200BG , type = 
'lspci -vv'
we see a chunk with 100s of hits. whats up ?

-02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
+02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 06)

I told you it was contrived.

But its important to someone, and fairly close to 'emergent'






>>> I own lots of motheboards, however most
>>> of them are too different (i want to see, how similar are the reports of
>>> dmidecode on "similar" motheboards (i.e. different revisions)).
>>>
>>>       
>
> Do we have different motherboard revisions which are so different that
> the revison matters for sensors.conf, or do you want to know this so
> that the autoconfig tool will correctly identify all revisions?
>   
we want the database to be able to tell us over time
for that we need
- easy platform-analyse script and upload system,
    so the data becomes available,
- excellent similarity detector, to:
    maximize semantic understanding,
       leads to maximized info reuse
    learn from the histogram of the rows
       add a labelling system to further leverage info.
> --- end of reply ---
>
> My own idea for being able to configure motherboards with a broken (or
> no) dmi table was to actually use the motherboard. In my memory dos
> tools were able to provide all kinda info on the bios, like version
> string, etc. Often the version string contains the mobo model. Anyone
> know how these dos tools did this (are these strings at a fixed memory
> location, or was it a dos int?).
>   
consider this 2 liner:
    sudo dmidecode > sony-dmi-out
     perl -de'$/=undef;$b=<>;@p=split/Handle/ms,$b; print"@p"' < 
sony-dmi-out

this will parse/chunkify the dmidecode output like I described in 
earlier msg, on /Handle/.

If each chunk were fingerprinted, we could answer:

- how many bios vendors ?
    A - query for chunks with type=dmidecode' which match /DMI type 0/
    select distinct Vendor (add count and group by for more)

- how many different bioses have been released ?
    A - same as before +
    from these, select Vendor, Version, Release-date, catenate, and 
histogram.

- do any vendors reuse versions across different platforms ?
    easy, with a database.

(Implicit feature creep)

For those who didnt notice, I started 'parsing into lines' right in the 
middle there.
There are cases where the data warrants it, others where it doesnt.

Another case where its good .. lsmod
Consider this :

Module                  Size  Used by
ndiswrapper           148396  0
usbcore                99144  1 ndiswrapper
scx200_gpio             4844  0
scx200                  4688  1 scx200_gpio
pc8736x_gpio            6452  0
nsc_gpio                4384  2 scx200_gpio,pc8736x_gpio
pc87360                18096  0
hwmon_vid               2624  1 pc87360
i2c_isa                 6016  1 pc87360
i2c_core               21664  2 pc87360,i2c_isa

parse by the line, hash / partial-index the 1st token,
now you know how many times each module gets used in the linux world.
Given that some of the modules will be loaded,

size is unlikely to ever be used, and in this case, should be stripped 
to reduce
database size.  OTOH - it could be useful if someone wanted to track that -
- I can imagine some for curiosity, not for practical value atm.
- see below for another example ..




> I'm thinking about a tool which memmaps /dev/mem at 0xf0000 - 0xfffff
> where the bios is and making a hexdump to see if I can dig up any
> interesting info there which could help us identifying the mainboard.
>   
I cannot evaluate these nuggets you could dredge out.
I would only observe that they should show correlation with something before
we know how much to count upon them.

In a twisted way, they need this system up and running to help evaluate them
against the panoply of configuration files that become available once it 
is working.

> Now modern bioses are bigger then the 64k window at 0xf0000 - 0xfffff
> does anyone know how one gets to the rest of the bios? (a bios checksum
> might nbe another way to identify mainboards, yes I know we will have
> problems with multiple bios versions).
>
> Regards,
>
> Hans
>
>
>   
Im flogging this horse - to the point Im feeling self concious about it -
- but let me float 1 more example.
   
dmesg output

For info extraction, we definitely want to chunkify to the line, strip 
out leading timestamps.
If we want to go Full-RI,  the dmesg-parse-captures table has these cols;
a content-hash - PK
a report-key - FK  (or a dmesg-rpt-key, which links up)

Once we collect dozens of reports, *many* dmesg lines will emerge as 
known-good,
and conversely, error messages become immediately obvious.

Freeing initrd memory: 1065k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO

Simple regexs could compress out the irrelevancies, trivially,
and could easily evolve (given enough time) where the maintainer
of a driver supplies you with regexs of messages they dont want to see 
anymore.

forex, ACPI folks might supply rex to suppress this.

ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKB] -> GSI 9 (level, low) 
-> IRQ 9
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 7 (level, low) 
-> IRQ 7

Or, if they were hungry for mapping info, and the facilities were there..

s/ACPI: PCI Interrupt 0*?)\[()\] -> Link \[(\w+)\]  ... / 
insert(pcidev=>$1, lnk=>$3,...)/e;

this perl regex captures interesting parts of the line, and calls a 
routine ..
Obviously doable other (wordier) ways, and completely untested too.



I know this smells like mission-creep, but Id re-phrase that (were I 
asked ;) as
 
taking advantage of a tactical situation that incurred no new risk,
instead lowering it by reducing reliance on possibly bad data,
from our (as yet non-existent) data-content.

Im also convinced that theres value to be mined here -      
-a possible "kill-many-birds-with-one-great-throw" outcome.



Ok, I sat on this for 8 more hours, and Im still not all wound out.

GIT:
- git repo works entirely by checksums - it holds the development 
process together.
- the A*S*M configs could trivially be added to git repos, where the

--  the march-of-versions that each *-config undergoes,  over  2.6.1[6789].*
    carries a clear and concise record of what configs and modules were 
added,
    and when they changed enough to affect the xconfig experience.
    As such, it is valuable.

-- when bugs are reported, a .config often comes with.
    it could be a diff instead :
        against any of the 'predefined+platform-defaults'
          virtue of brevity
          maybe of clarity

-- its really nothing less than the foundation of kernel-genetics

- Having a finite universe of .configs (by dropping the date),
and collecting Confinger-prints and key CONFIG vars, allows great leaps
in tracability of changes (and the bugs they cause, fix),
which could soon benefit the guys who needs it most:

- the kconfig-twizzler hobbyist  ;-)
- Google's back room uber-gurus
    that keep 1000's of servers humming,
    and dozens of mini-clusters busy, spinning plates, folding protiens, 
and stuff.
       (FTR, im making that stuff up, but it could be)

- Im quite off topic now on this, and Im becoming a zealot -
I hope folks will challenge me to explain what doesnt make sense to them.

if this project LMS-AT - (or maybe LMS-aCT), with its 
fedora-core-associations,
has ability to widen the perspective, and scale up to big iron,
the finger-printing system could be exploited by numerous benchmarking 
and QA projects.

XENOMAI: ( one last example )

xenomai.org has a xeno-test script which runs a series of RT latency tests,
after it collects a snapshot of the platform.  It has nascent code to bundle
and email/upload the results tarball, but lacks either;
    a site to send emails, upload testdata and platform-data to.
    OR the ability to send a spam-filter-safe-message

Once they have data that is comparable, they can look for intra-platform
similarities, and inter-platform differences, in a 
data->analysis->inference->bugfix
process.  Or thats the hope.  But clearly a multi-vector 
correllation->identification
system would help them select tailored datasets for their investigations.
Query services connecting to the raw, or prepared data would complete 
the picture.

an egghead abstract wrt scale-space theory
http://www.visionscience.com/mail/vslist/2000/0264.html
an egghead book on subject
http://springerlink.metapress.com/(osdyeu55e3x1wi45hi2lb4fm)/app/home/contribution.asp?referrer=parent&backto=issue,89,179;journal,1171,3854;linkingpublicationresults,1:105633,1

Im not saying I understand that stuff, only that it seems to resonate
somehow as a unifying viewpoint on many problems.

Id hope that fedora-foundation could see fit to host a pass-thru service 
that
collects uploads/emails, extracts and fingerprints the 'known' stuff.
Known is an evolving thing, and here would include knowing that the
performance data is not finger-printable, and it is passed thru to 
client projects,
along with all/some of the fingerprints, per their preferences - ML 
being common.
Each project might want to manage custom finger-print vectors,
that are more or less particular about stuff.

whew!
-jimc

.. one more thing .. <ducks>


