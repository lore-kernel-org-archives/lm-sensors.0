From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Mon, 08 Oct 2007 18:31:55 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <1678456996@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,


> Von: "Juerg Haefliger" <juergh@gmail.com>
> 
> On 10/1/07, Juergen Bausa <Juergen.Bausa@web.de> wrote:
> > Hi Juerg,
> >
> > > Von: "Juerg Haefliger" <juergh@gmail.com>
> > >
> > > On 9/25/07, Juergen Bausa <Juergen.Bausa@web.de> wrote:
> > > > What does this mean (taken from /var/log/messages)?
> > > >
> > > > Sep 23 12:11:22 lisa kernel: dme1737 0-002e: Write to register 0x30 failed! Please report to the driver maintainer.
> > >
> > > > I get this sometimes (every some hours). I use the dme1737.ko without on my asus system
> > > > (Pundit P1-AH2) with Athlon BE-2350.
> > >
> > > What apps are you running that touch the driver? Are you doing manual
> > > PWM control?
> > >
> >
> > I use the script fancontrol from lm-sensors, that controls the cpu-fan by pwm. It works
> > fine. Maybe it somtimes fails in setting the fan speed, but can set in the next cycle.
> > I newer got error messages from fancontrol.
> 
> Aha, that explains it. Can you apply the attached patch and reload the
> driver? Could you also please post the output of 'lsmod'?
> 

not much information:
/var/log/messages.0:Oct  4 00:17:43 lisa kernel: dme1737 0-002e: Write to register 0x30 failed (-1)! Please report to the driver maintainer.

And here comes lsmod:jba@lisa:~$ lsmod
Module                  Size  Used by
nvidia               4550548  22
agpgart                30216  1 nvidia
nfs                   203980  0
cpufreq_userspace       4768  1
nfsd                  199856  10
exportfs                6080  1 nfsd
lockd                  55240  3 nfs,nfsd
nfs_acl                 3904  2 nfs,nfsd
sunrpc                139772  13 nfs,nfsd,lockd,nfs_acl
ppdev                   8964  0
lp                     11300  0
button                  6928  0
ac                      5508  0
battery                 9924  0
ipv6                  228320  12
nls_iso8859_1           4544  1
ntfs                  195988  1
dm_snapshot            15904  0
dm_mirror              19600  0
dm_mod                 50776  2 dm_snapshot,dm_mirror
dme1737                28884  0
hwmon_vid               3072  1 dme1737
powernow_k8            13696  1
freq_table              4832  1 powernow_k8
kqemu                 107908  0
sbp2                   21320  0
loop                   15496  0
snd_hda_intel          17620  1
snd_hda_codec         138816  1 snd_hda_intel
snd_pcm_oss            39200  0
snd_mixer_oss          15552  1 snd_pcm_oss
snd_pcm                68996  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_seq_dummy           4164  0
snd_seq_oss            29120  0
snd_seq_midi            8544  0
snd_rawmidi            23200  1 snd_seq_midi
snd_seq_midi_event      7488  2 snd_seq_oss,snd_seq_midi
snd_seq                46224  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              21316  2 snd_pcm,snd_seq
snd_seq_device          8140  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
parport_pc             32612  1
snd                    47524  12 snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
parport                33672  3 ppdev,lp,parport_pc
usblp                  13120  0
soundcore               9568  1 snd
i2c_nforce2             7232  0
k8temp                  5952  0
rtc                    12788  0
snd_page_alloc          9928  2 snd_hda_intel,snd_pcm
i2c_core               20096  3 nvidia,dme1737,i2c_nforce2
psmouse                35336  0
serio_raw               6980  0
pcspkr                  3392  0
tsdev                   7808  0
eth1394                18756  0
evdev                   9408  1
ext3                  120584  3
jbd                    52968  1 ext3
mbcache                 8644  1 ext3
ide_cd                 36576  0
cdrom                  33056  1 ide_cd
sd_mod                 19456  6
usbhid                 37856  0
usb_storage            72832  0
sata_nv                11332  5
ohci1394               31344  0
ieee1394               88376  3 sbp2,eth1394,ohci1394
forcedeth              38788  0
amd74xx                13340  0 [permanent]
ehci_hcd               28488  0
libata                 90772  1 sata_nv
scsi_mod              124872  4 sbp2,sd_mod,usb_storage,libata
ohci_hcd               18564  0
generic                 5188  0 [permanent]
ide_core              110984  4 ide_cd,usb_storage,amd74xx,generic
usbcore               113412  6 usblp,usbhid,usb_storage,ehci_hcd,ohci_hcd
thermal                13896  0
processor              29128  2 powernow_k8,thermal
fan                     5124  0

Juergen

_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc1114


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
