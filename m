From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: AS99127F ceased to work when upgrading 2.5.5 to 2.6.2
Message-Id: <3C1FDB88.2F7638E4@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011216102314.GA879@schmorp.de>
In-Reply-To: <20011216102314.GA879@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hmm.
What may have hurt you is not having the chip initialized,
together with the new check for duplicate subaddresses.

You can try changing the line at the top of w83781d_init_client()
from
	if(init && type != as99127f)
to
	if(init)
This should set the subaddresses to 0x48 and 49.

mds



"pcg"@goof.com ( Marc) (A.) (Lehmann ) wrote:
> 
> I just upgraded 2.5.5 to 2.6.2. I have an ASUS-CUV4X-D, which is equipped
> with an AS99127F on the SMBUS (module i2c-viapro).
> 
> sensors-detect from 2.5.5 detected my AS99127F and it worked "perfectly"
> (as perfect as a chip driver can work without a data-sheet ;)
> 
> sensors-detect in 2.6.2 does detect my matrox-i2c, my bttv-i2c, my
> viapro-smbus, but NOT AS99127F (output is attached, watch out for the two
> errors at the beginning).
> 
> the kernel prints nothing while running sensors-detect. if I load the
> i2c-viapro and the w83781d modules (with args force_as99127f=0,0x2d), I
> get these kernel messages:
> 
>    i2c-core.o: client [AS99127F chip] registered to adapter [SMBus Via Pro adapter at e800](pos. 0).
>    w83781d.o: Duplicate addresses 0x4f for subclients.
>    i2c-core.o: client [AS99127F chip] unregistered.
>    i2c-core.o: driver unregistered: W83781D sensor driver
> 
> that is, initialization fails. If i naively comment out the check
> 
>    if(data->lm75[0].addr = data->lm75[1].addr) {
> 
> I get this:
> 
>    w83781d.o: Subclient 1 registration at address 0x4f failed.
> 
> Any chance to get it working with 2.6.2, or is it better to just downgrade
> to 2.5.5 again?
> 
> As a sidenote: is it possible to cleanly unload the i2c-modules again? If
> I naively rmmod i2c-viapro or other modules I cannot insmod them again,
> and /proc/ioports contains garbage. accessing proc files (/proc/bus/i2c-1)
> gives me kernel oopses.
> 
> Thanks for any help, thx for creating lm_sensors ;)
> 
> --
>       -----=-                                             |
>       ----=-- _                                           |
>       ---=---(_)__  __ ____  __       Marc Lehmann      +--
>       --=---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
>       -===/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
>     The choice of a GNU generation                       |
>                                                          |
> 
> 
> 
>    xName: x
>     Type: Plain Text (text/plain)
