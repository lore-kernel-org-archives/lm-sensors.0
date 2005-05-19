From: rbsteffes@nc.rr.com (Ryan Steffes)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: Ticket 1719 problems.
Message-Id: <40EC5AF8.2030100@nc.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In reference to ticket 1719:

I'm sorry if I'm making a nuisance of myself but I guess I must be being 
obtuse.  The various documentation says that you have to be careful to 
only use certain version of lm_sensors with the various versions of the 
kernel.  I'm using an Asus A7N8X which has a w83l785ts on it, apparently 
the fix came in a version after the one that Mandrake considers to work 
with my kernel.  I'm using 2.6.3-7mdk kernel and 
lm_sensors-2.8.4-2mdk.i586. I got an rpm of 
lm_sensors-2.8.7-4mdk.i586.rpm and it's kicking the procfs/sysfs thing. 
Is my only real solution to upgrade my lm_sensors AND my kernel? 

[root@HappyTrout Downloads]# sensors -s
asb100-i2c-4-2d: Can't access procfs/sysfs file for writing;
Run as root?
[root@HappyTrout Downloads]# lsmod
Module                  Size  Used by
eeprom                  7336  0 
w83l785ts               7012  0 
asb100                 20992  0 
i2c-sensor              2944  3 eeprom,w83l785ts,asb100
i2c-nforce2             6016  0 
i2c-dev                10080  0 
lirc_serial            11328  0 
lirc_dev               10952  2 lirc_serial
md5                     3872  1 
ipv6                  232352  15 
tuner                  17292  0 
tvaudio                21612  0 
msp3400                22068  0 
bttv                  146956  1 
video-buf              20388  1 bttv
i2c-algo-bit            9512  1 bttv
v4l2-common             6144  1 bttv
btcx-risc               4712  1 bttv
videodev                9536  2 bttv
btaudio                17296  0 
fglrx                 205028  0 
agpgart                31016  0 
parport_pc             32832  1 
lp                     12200  0 
parport                38952  2 parport_pc,lp
sg                     38044  0 
st                     38616  0 
sr_mod                 17028  0 
sd_mod                 16832  0 
scsi_mod              114648  4 sg,st,sr_mod,sd_mod
snd-seq-oss            31232  0 
snd-seq-midi-event      7552  1 snd-seq-oss
snd-seq                51024  4 snd-seq-oss,snd-seq-midi-event
snd-pcm-oss            51812  1 
snd-mixer-oss          17952  1 snd-pcm-oss
snd-intel8x0           32776  1 
snd-ac97-codec         58148  1 snd-intel8x0
snd-pcm                93156  2 snd-pcm-oss,snd-intel8x0
snd-timer              24484  2 snd-seq,snd-pcm
gameport                4480  1 snd-intel8x0
snd-page-alloc         11972  2 snd-intel8x0,snd-pcm
snd-mpu401-uart         7072  1 snd-intel8x0
snd-rawmidi            23616  1 snd-mpu401-uart
snd-seq-device          8008  3 snd-seq-oss,snd-seq,snd-rawmidi
snd                    52484  12 snd-seq-oss,snd-seq-midi-event,snd-seq,snd-pcm-oss,snd-mixer-oss,snd-intel8x0,snd-ac97-codec,snd-pcm,snd-timer,snd-mpu401-uart,snd-rawmidi,snd-seq-device
soundcore               9248  4 bttv,btaudio,snd
af_packet              20520  2 
i2c-core               23044  11 eeprom,w83l785ts,asb100,i2c-sensor,i2c-nforce2,i2c-dev,tuner,tvaudio,msp3400,bttv,i2c-algo-bit
hid                    53312  0 
ide-floppy             18752  0 
ide-tape               34864  0 
ide-cd                 40548  0 
cdrom                  37184  2 sr_mod,ide-cd
floppy                 59444  0 
8139too                23712  0 
mii                     4992  1 8139too
nls_iso8859-1           3904  2 
nls_cp850               4736  2 
vfat                   13760  2 
fat                    45120  1 vfat
supermount             37876  5 
usblp                  12288  1 
ehci-hcd               24196  0 
ohci-hcd               18692  0 
usbcore                99132  7 hid,usblp,ehci-hcd,ohci-hcd
rtc                    11576  0 
ext3                  110408  5 
jbd                    54328  1 ext3


Any additional help would be greatly appreciated.

Ryan
