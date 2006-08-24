From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 24 Aug 2006 14:52:17 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060824165217.bd1b43be.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anthony,

> > What update is this?
> 
> 
> -- In the change log for kernel 2.6.9-42 from redhat enterprise, it
> says:
> 2006-05-02 22:00:00 
> Jason Baron <jbaron at redhat.com> [2.6.9-35]: 
> -revert: fix hanging serial console
> -Introduce netpoll over bonded interfaces (Thomas Graf)
> -fix USB error handling (Kimball Murray) [189279]
> -qla2xxx update v. 8.01.04-d7 (Mike Christie) [188912]
> -Fix coredump vs exec deadlock (David Howells) [168112]
> *****-add i2c sensors drivers (Eric Paris) [171507]*****
> -s390: fix sysrq backtrace oops (Jan Glauber) [185736]
> -s390: fix crypto driver memory overwrite (Jan Glauber)
> -s390: lcs driver fixes (Jan Glauber)
> -add hpet_period finetuning to allow correction of hpet drift (Brian
> Maly) [169876]
> -bonding updates (Thomas Graf) [180431]
> -Add MSI/MSI-X support to cciss (Tom Coughlan) [179860]
> -add modern_apic() tests (Jim Paradis) [166885]
> -SUNRPC: rpcbind should retry if server's portmapper becomes unavailable
> (Steve Dickson) [172082]
> -device-mapper mirroring: error on log failure override (Jonathan
> Brassow)
> -make aic7xxx and aic79xx Drivers Support 16-byte CDBs (Chip Coldwell)
> -fix ipmi driver broken on HP Integrity platform (Brian Maly) [174986]
> -fix mmap wastes too much virtual address space for 32-bit environment
> (Larry Woodman) [173662]
> -IPMI: Resolve startup race condition (Peter Martuccelli) [189390]
> -ati sb600 support (John Linville) [189844]
> -Emulex lpfc/lpfcdfc drivers re-organizations (Chip Coldwell) [179752]
> 
> -- I tried to research the bug from redhat but didn't have the right
> access.

I asked for access, that may or may not be accepted.

Anyway, I was asking out of curiousity. It certainly has nothing to do
with your current problems.

-- 
Jean Delvare

