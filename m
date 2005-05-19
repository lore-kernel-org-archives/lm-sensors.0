From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: Possible hardware damage Dell Optiplex GX1p?
Message-Id: <3F00E72A.4050003@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.56.0306231730330.681@p500>
In-Reply-To: <Pine.LNX.4.56.0306231730330.681@p500>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

might be an interrupt or I/O conflict.
doubtful it is hardware damage.
I'd go get a $10 PCI sound card.
ISA sound cards are way way more trouble than they are worth
(and the sound skips so easily when there is CPU load that they aren't worth anything).
They can work one day and not the next and it's almost impossible
to figure out why.

war wrote:
> While trying to get lm_sensors running on a Dell Optiplex GX1p, I played
> around with the io option.
> 
> There are two options for the smbus, force=1, and force=1
> io=some_address_here.
> 
> force=1 is what is needed to get it to work, but before I tried that, I
> tried setting an io address.
> 
> Now, whenever I boot off the Dell ICU PnP disk (allows you to set/play
> with interrupts/irqs, etc), it freezes/stops when it tries to detect the
> Crystal Audio ISA PNP sound board in the system.
> 
> I have two of these machines, the other box which I have not played with
> lm_sensors on works fine and it detects the board and continues booting
> into dos (using dos bootdisk)... then to load the ICU Dell utility.
> 
> However, mine just 'hangs' on the soundcard and does not continue.
> 
> I ran the dell diagnostics disks, they said the sound card is fine, even
> though there was an unusual(?) pause while probing for it.
> 
> The sound works OK/fine in Linux, no problems.
> 
> Is it possible to have ruined the hardware or have there been any reports
> of problems such as these?
> 
> Is there anyway to further diagnose the problem?
> 
> I was using latest lm_sensors and lm_sensors 2.5.x while testing/trying to
> get temperature monitoring to work properly.
> 
> Module Parameters
> -----------------
> 
> * force: int
>   Forcibly enable the PIIX4. DANGEROUS!
> * force_addr: int
>   Forcibly enable the PIIX4 at the given address. EXTREMELY DANGEROUS!
> 
> 
> On some computers (most notably, some Dells), the SMBus is disabled by
> default. If you use the insmod parameter 'force=1', the kernel module
>  will try to enable it. THIS IS VERY DANGEROUS! If the BIOS did not
> set up a correct address for this module, you could get in big trouble
> (read: crashes, data corruption, etc.). Try this only as a last resort
> (try BIOS updates first, for example), and backup first! An even more
> dangerous option is 'force_addr=<IOPORT>'. This will not only enable the
> PIIX4 like 'force' foes, but it will also set a new base I/O port address.
> The SMBus parts of the PIIX4 needs a range of 8 of these addresses to
> function correctly. If these addresses are already reserved by some other
> device, you will get into big trouble! DON'T USE THIS IF YOU ARE NOT VERY
> SURE ABOUT WHAT YOU ARE DOING!
> 
> Is there anyway to fix the problem, or is it permanently damaged (sound
> board issue with the dell boot disk)..
> 
> Anyway to check what is normal or what is not?
> 
> Any feedback would be greatly appreciated.
> 
> Thank you.
> 
> 
> 
