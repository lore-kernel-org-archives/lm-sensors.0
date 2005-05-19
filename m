From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Testing lm-sensors for integrated sis630 mainboard using it87
Message-Id: <3C7C4ABA.9EF68017@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1014147705.473.11.camel@debian>
In-Reply-To: <1014147705.473.11.camel@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Either you don't really have a it87 (look at your board)
or else the it87 is on the i2c bus behind the 630, which we don't
support.
Sorry.
If the it87 is on the isa bus it would be found.
You can double check by 'prog/dump/isadump 0x295 0x296',
if it is all FF's then there is nothing there.
mds


Pere Casta?er sard? wrote:
> 
> well first say that I'm impressed about the work in this the
> documentation is big and extensive to all people.
> I'm sure I'doing something wrong,let's se.
> I have a debian sid and the lm package 2.6.2 and kernel 2.4.17.
> I install all via kernel patch and modules. in dmesg I can see that I
> have i2c-isa (is not i2c-sis5595) i2c-dev and i2c-core up.but as we know
> the sis5595 don't charges into kernel:
> 
> ------------dmesg trucated!--------------------------------------------
> i2c-core.o: i2c core module version 2.6.2 (20011118)
> i2c-isa.o version 2.6.2 (20011118)
> i2c-core.o: adapter ISA main adapter registered as adapter 0.
> i2c-isa.o: ISA bus access for i2c modules initialized.
> i2c-proc.o version 2.6.2 (20011118)
> sis5595.o version 2.6.2 (20011118)
> sis5595.o: Error: Looked for SIS5595 but found unsupported device 0630
> sis5595.o: SIS5595 not detected, module not inserted.
> sis5595.o version 2.6.2 (20011118)
> sis5595.o: Error: Looked for SIS5595 but found unsupported device 0630
> sis5595.o: SIS5595 not detected, module not inserted.
> ------------------dmesg truncated---------------------------------------
> 
> and I compile the module it87 as our web describes. Now I have the
> module it87 loaded into kernel but i2c-isa shows unuset:
> -------------------lsmod------------------------------------------------
> Module                  Size  Used by    Tainted: P
> it87                    6720   0  (unused)
> snd-pcm-oss            34944   1  (autoclean)
> snd-mixer-oss           8928   0  (autoclean) [snd-pcm-oss]
> snd-card-trident        1792   1  (autoclean)
> snd-trident            20160   0  (autoclean) [snd-card-trident]
> snd-ac97-codec         22848   0  (autoclean) [snd-trident]
> snd-pcm                47296   0  (autoclean) [snd-pcm-oss snd-trident]
> snd-timer              10016   0  (autoclean) [snd-pcm]
> snd-util-mem            1216   0  (autoclean) [snd-trident]
> snd-mpu401-uart         2496   0  (autoclean) [snd-card-trident
> snd-trident]
> snd-rawmidi            12064   0  (autoclean) [snd-mpu401-uart]
> snd-seq-device          3792   0  (autoclean) [snd-trident snd-rawmidi]
> snd                    24136   0  (autoclean) [snd-pcm-oss snd-mixer-oss
> snd-card-trident snd-trident snd-ac97-codec snd-pcm snd-timer
> snd-util-mem snd-mpu401-uart snd-rawmidi snd-seq-device]
> i2c-proc                6144   0  [it87]
> i2c-isa                 1220   0  (unused)
> i2c-core               12832   0  [it87 i2c-proc i2c-isa]
> vfat                    9276   2
> fat                    29112   0  [vfat]
> -----------------------------------------------------------------------
> and logically then I execute "sensors" any sensors is detected. I
> misunderstood something? I assume this is beta but I want to know if I'm
> doing something wrong or is my board unsoported
> 
> I attach some config files for your interest. Best regards.
> --
> 
> Pere Castanyer Sarda   -    XaRz69@terra.es
> Computer Management Technical Engineering Student on UOC - (www.uoc.es)
> Member of AEIGi   -   (www.aeigi.org)
> 
> ------------------------------
> Linux Registered User #232073
> Debian GNU Linux User  -   (www.debian.org)
> GNUPG public Inf:              pub  1024D/F19A252B
> 919B 48CC 835C B535 EF18  1A26 09F9 D16D F19A 252B
> ---------------------------------------------------------------------------
> 
> 
>             Name: lspci
>    lspci    Type: Plain Text (text/plain)
>         Encoding: quoted-printable
> 
>             Name: dmesg
>    dmesg    Type: Plain Text (text/plain)
>         Encoding: quoted-printable
> 
>                        Name: signature.asc
>    signature.asc       Type: application/pgp-signature
>                 Description: This is a digitally signed message part
