From: henryvician@gmail.com (Henry)
Date: Wed, 27 Jul 2005 16:05:16 +0000
Subject: [lm-sensors] Fancontrol
Message-Id: <1122472854.7900.2.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

here is the output of the lsmod command

Henry

On Wed, 2005-07-27 at 09:23 +0200, Rudolf Marek wrote:
> Please what modules are you using for monitoring?
> If you dont know which one. Please include output of lsmod command and I will pick them up :)
> 
> Thanks
> 
> Regards
> 
> Rudolf
-------------- next part --------------
Module                  Size  Used by
vfat                   16961  1 
fat                    44897  1 vfat
usb_storage            62857  0 
parport_pc             27777  1 
lp                     14893  0 
parport                40969  2 parport_pc,lp
autofs4                21700  0 
w83627hf               29161  0 
eeprom                 12385  0 
i2c_sensor              7489  2 w83627hf,eeprom
i2c_isa                 6081  0 
i2c_i801               11597  0 
i2c_dev                13249  0 
i2c_core               25921  6 w83627hf,eeprom,i2c_sensor,i2c_isa,i2c_i801,i2c_dev
sunrpc                136997  1 
dm_mod                 56773  0 
button                 10449  0 
battery                12485  0 
ac                      8773  0 
md5                     8001  1 
ipv6                  235105  14 
ohci1394               35033  0 
ieee1394              302965  1 ohci1394
joydev                 12545  0 
uhci_hcd               32729  0 
ehci_hcd               31941  0 
emu10k1_gp              7617  0 
gameport                8513  1 emu10k1_gp
snd_emu10k1            83529  0 
snd_rawmidi            27109  1 snd_emu10k1
snd_pcm_oss            50809  0 
snd_mixer_oss          20929  1 snd_pcm_oss
snd_pcm                89669  2 snd_emu10k1,snd_pcm_oss
snd_timer              27077  1 snd_pcm
snd_seq_device         11849  2 snd_emu10k1,snd_rawmidi
snd_ac97_codec         65169  1 snd_emu10k1
snd_page_alloc         13641  2 snd_emu10k1,snd_pcm
snd_util_mem            8641  1 snd_emu10k1
snd_hwdep              13125  1 snd_emu10k1
snd                    54821  9 snd_emu10k1,snd_rawmidi,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_hwdep
soundcore              12961  1 snd
e1000                  80205  0 
floppy                 57297  0 
ext3                  117961  4 
jbd                    59353  1 ext3
sata_promise           13509  0 
libata                 43077  1 sata_promise
sd_mod                 20289  0 
scsi_mod              112136  4 usb_storage,sata_promise,libata,sd_mod
