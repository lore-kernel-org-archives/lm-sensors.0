From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Wed, 23 Aug 2006 21:04:21 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04704F7F7CE@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 


Anthony W. Calabro

Voice: 703.367.3138 
Email:  anthony.calabro at lmco.com

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Wednesday, August 23, 2006 11:24 AM
To: Mark M. Hoffman; Calabro, Anthony
Cc: LM Sensors
Subject: Re: [lm-sensors] Flex Scanner Jammed Problem

Hi Anthony, Mark,

> * Calabro, Anthony <anthony.calabro at lmco.com> [2006-08-22 16:19:55
-0400]:
> > I guess Im going to try to start over with this thread.  I have 
> > solved the Flex Scanner Jammed problem by going back to sensors
version 2.9.0.
> > When using 2.10.0 the best I could do is get label lines to parse 
> > correctly, but I never had any luck with the compute lines.  I also
> 
> Did you install 2.9.0 from source?  Looking back at the archives, you 
> actually started with 2.8.7 - it probably came with the distro.
> 
> If you were able to install 2.9.0 from source, but not 2.10.0... well 
> that is very strange.  The scanner didn't change between those
versions.
> 
> Anyway, if you're still interested in trying to debug the scanner
error:
> please add the flag '-d' to the last line of the Makefile.  It should 
> look like this:
> 
>  	$(FLEX) -Psensors_yy -t -d $< > $@
> 
> Then 'make clean' && 'make' && 'make install'.  That flag will cause 
> the scanner to make a lot of noise about what it's doing.  Send some 
> results back to this list and I'll have a look.

Another approach would be to perform a bisection. If 2.9.0 actually
works, and 2.10.0 doesn't, then a change must have broken it - even
though I just can't think of any. 2.9.0 is r2809, 2.10.0 is r3256. You
will converge after 11 iterations, should be fast enough.

> > upgraded my linux kernel from 2.6.9-34 to 2.6.9-42.  In this new 
> > version there is an i2c sensors update.

What update is this?


-- In the change log for kernel 2.6.9-42 from redhat enterprise, it
says:
2006-05-02 22:00:00 
Jason Baron <jbaron at redhat.com> [2.6.9-35]: 
-revert: fix hanging serial console
-Introduce netpoll over bonded interfaces (Thomas Graf)
-fix USB error handling (Kimball Murray) [189279]
-qla2xxx update v. 8.01.04-d7 (Mike Christie) [188912]
-Fix coredump vs exec deadlock (David Howells) [168112]
*****-add i2c sensors drivers (Eric Paris) [171507]*****
-s390: fix sysrq backtrace oops (Jan Glauber) [185736]
-s390: fix crypto driver memory overwrite (Jan Glauber)
-s390: lcs driver fixes (Jan Glauber)
-add hpet_period finetuning to allow correction of hpet drift (Brian
Maly) [169876]
-bonding updates (Thomas Graf) [180431]
-Add MSI/MSI-X support to cciss (Tom Coughlan) [179860]
-add modern_apic() tests (Jim Paradis) [166885]
-SUNRPC: rpcbind should retry if server's portmapper becomes unavailable
(Steve Dickson) [172082]
-device-mapper mirroring: error on log failure override (Jonathan
Brassow)
-make aic7xxx and aic79xx Drivers Support 16-byte CDBs (Chip Coldwell)
-fix ipmi driver broken on HP Integrity platform (Brian Maly) [174986]
-fix mmap wastes too much virtual address space for 32-bit environment
(Larry Woodman) [173662]
-IPMI: Resolve startup race condition (Peter Martuccelli) [189390]
-ati sb600 support (John Linville) [189844]
-Emulex lpfc/lpfcdfc drivers re-organizations (Chip Coldwell) [179752]

-- I tried to research the bug from redhat but didn't have the right
access.



--
Jean Delvare


