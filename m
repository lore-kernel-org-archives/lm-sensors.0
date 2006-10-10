From: bunk@stusta.de (Adrian Bunk)
Date: Tue, 10 Oct 2006 05:10:19 +0000
Subject: [lm-sensors] 2.6.19-rc1: known regressions (v3)
Message-Id: <20061010051019.GB3650@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: alsa-devel@alsa-project.org, Thierry Vignaud <tvignaud@mandriva.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Torsten Kaiser <kernel@bardioc.dyndns.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org, pavel@suse.cz, Andrew de Quincey <adq_dvb@lidskialf.net>, Jens Axboe <jens.axboe@oracle.com>, linux-usb-devel@lists.sourceforge.net, Steve Fox <drfickle@us.ibm.com>, Andreas Schwab <schwab@suse.de>, Magnus Damm <magnus.damm@gmail.com>, lm-sensors@lm-sensors.org, art@usfltd.com, Mel Gorman <mel@skynet.ie>, Michael Krufky <mkrufky@linuxtv.org>, Sylvain BERTRAND <sylvain.bertrand@gmail.com>, jgarzik@pobox.com, Prakash Punnoor <prakash@punnoor.de>, fastboot@osdl.org, Olaf Hering <olaf@aepfle.de>, discuss@x86-64.org, Trond Myklebust <Trond.Myklebust@netapp.com>, Alex Romosan <romosan@sycorax.lbl.gov>

This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
that are not yet fixed Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?idr55
Submitter  : Thierry Vignaud <tvignaud at mandriva.com>
Status     : unknown


Subject    : monitor not active after boot
References : http://lkml.org/lkml/2006/10/5/338
Submitter  : Olaf Hering <olaf at aepfle.de>
Caused-By  : Antonino Daplas <adaplas at pol.net>
             commit 346bc21026e7a92e1d7a4a1b3792c5e8b686133d
Status     : unknown


Subject    : SMP x86_64 boot problem
References : http://lkml.org/lkml/2006/9/28/330
             http://lkml.org/lkml/2006/10/5/289
Submitter  : art at usfltd.com
Status     : submitter was asked to git bisect
             result of bisecting seems to be wrong


Subject    : sleep/wakeup on powerbooks apparently busted
References : http://lkml.org/lkml/2006/10/5/13
Submitter  : Benjamin Herrenschmidt <benh at kernel.crashing.org>
Handled-By : Benjamin Herrenschmidt <benh at kernel.crashing.org>
Status     : Benjamin will investigate


Subject    : w83781d modprobing failure
References : http://bugzilla.kernel.org/show_bug.cgi?idr93
Submitter  : Sylvain BERTRAND <sylvain.bertrand at gmail.com>
Caused-By  : David Hubbard <david.c.hubbard at gmail.com> (?)
             commit 8202632647278eba7223727dc442f49227c040d0 (?)
Handled-By : Jean Delvare <khali at linux-fr.org>
Status     : Jean is investigating


Subject    : CD/DVD drives lost capabilities
References : http://lkml.org/lkml/2006/10/1/45
             http://bugzilla.kernel.org/show_bug.cgi?idr84
Submitter  : Olaf Hering <olaf at aepfle.de>
             Johannes Berg <johannes at sipsolutions.net>
Caused-By  : Jens Axboe <jens.axboe at oracle.com>
             commit 4aff5e2333c9a1609662f2091f55c3f6fffdad36
Handled-By : Jens Axboe <jens.axboe at oracle.com>
Status     : Jens is working on a fix


Subject    : snd-hda-intel <-> forcedeth MSI problem
References : http://lkml.org/lkml/2006/10/5/40
             http://lkml.org/lkml/2006/10/7/164
Submitter  : Prakash Punnoor <prakash at punnoor.de>
Status     : suggested workaround for 2.6.19:
             deactivate MSI in snd-intel-hda by default


Subject    : DVB frontend selection causes compile errors
References : http://lkml.org/lkml/2006/10/8/244
Submitter  : Adrian Bunk <bunk at stusta.de>
Caused-By  : "Andrew de Quincey" <adq_dvb at lidskialf.net>
             commit 176ac9da4f09820a43fd48f0e74b1486fc3603ba
Handled-By : Michael Krufky <mkrufky at linuxtv.org>
             "Andrew de Quincey" <adq_dvb at lidskialf.net>
Status     : possible workaround: don't allow CONFIG_DVB_FE_CUSTOMISE=y


Subject    : ueagle-atm Oops
References : http://lkml.org/lkml/2006/10/6/390
Submitter  : Ernst Herzberg <list-lkml at net4u.de>
Caused-By  : Greg Kroah-Hartman <gregkh at suse.de>
             commit e7ccdfec087f02930c5cdc81143d4a045ae8d361
Handled-By : Matthieu Castet <castet.matthieu at free.fr>
             Laurent Riffard
Patch      : https://mail.gna.org/public/ueagleatm-dev/2006-10/msg00022.html
Status     : "patch available, but some cleaning is needed"


Subject    : oops in xfrm_register_mode
References : http://lkml.org/lkml/2006/10/4/170
Submitter  : Steve Fox <drfickle at us.ibm.com>
Handled-By : Vivek Goyal <vgoyal at in.ibm.com>
Status     : patch available


Subject    : doesn't boot on iBook G4
References : http://lkml.org/lkml/2006/10/5/305
Submitter  : Andreas Schwab <schwab at suse.de>
Handled-By : Mel Gorman <mel at skynet.ie>
Patch      : http://lkml.org/lkml/2006/10/6/80
Status     : patch available


Subject    : airo suspend fails
References : http://lkml.org/lkml/2006/10/6/3
Submitter  : Alex Romosan <romosan at sycorax.lbl.gov>
Caused-By  : Sukadev Bhattiprolu <sukadev at us.ibm.com>  (?)
             commit 3b4c7d640376dbccfe80fc4f7b8772ecc7de28c5  (?)
Handled-By : Dave Kleikamp <shaggy at austin.ibm.com>
Patch      : http://lkml.org/lkml/2006/10/7/139
Status     : patch available


Subject    : kexec broken on x86_64
References : http://lkml.org/lkml/2006/10/5/86
Submitter  : Magnus Damm <magnus.damm at gmail.com>
Handled-By : Vivek Goyal <vgoyal at in.ibm.com>
Patch      : http://lkml.org/lkml/2006/10/5/199
Status     : patch available


Subject    : NFSv4 fails to mount (timeout)
References : http://bugzilla.kernel.org/show_bug.cgi?idr74
Submitter  : Torsten Kaiser <kernel at bardioc.dyndns.org>
Caused-By  : Trond Myklebust <Trond.Myklebust at netapp.com>
             commit 51b6ded4d9a94a61035deba1d8f51a54e3a3dd86
Handled-By : Trond Myklebust <Trond.Myklebust at netapp.com>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?idr74
Status     : patch available



