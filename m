From: grimm@nickellson.com (Nick Ellson)
Date: Mon, 26 Jun 2006 17:33:25 +0000
Subject: [lm-sensors] i2c-i801 on Intel Server Board se7525gp2?
Message-Id: <Pine.LNX.4.64.0606261023280.15719@gubbie.home>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I am hoping to get some help understanding why lm_sensors is not finding 
what it need on my two servers. I am trying to follow the Identifying your 
Hardware process and this is what I get:



Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x30
Client found at address 0x42
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Client found at address 0x69
Client found at address 0x6e

gubbie ~ # modprobe i2c-i801
gubbie ~ # modprobe eeprom
gubbie ~ # /usr/bin/sensors -s
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!
gubbie ~ # dmesg
[17179569.184000] Linux version 2.6.17-gentoo (root at gubbie) (gcc version 
3.4.6 (Gentoo 3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #2 SMP PREEMPT Mon Jun 
26 09:33:18 PDT 2006

<snip>

[17179640.696000] IA-32 Microcode Update Driver: v1.14 
<tigran at veritas.com>
[17179646.016000] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
[17179939.952000] i2c /dev entries driver
gubbie ~ #

gubbie ~ #  lsmod
Module                  Size  Used by
eeprom                  8080  0
i2c_dev                10244  0
nfsd                  105192  13
snd_seq_midi            9600  0
snd_emu10k1_synth       8320  0
snd_emux_synth         37120  1 snd_emu10k1_synth
snd_seq_virmidi         8960  1 snd_emux_synth
snd_seq_midi_emul       8320  1 snd_emux_synth
evbug                   3968  0
hw_random               6808  0
snd_emu10k1           118916  1 snd_emu10k1_synth
snd_rawmidi            26624  3 snd_seq_midi,snd_seq_virmidi,snd_emu10k1
snd_ac97_codec         90528  1 snd_emu10k1
snd_ac97_bus            3328  1 snd_ac97_codec
snd_util_mem            5632  2 snd_emux_synth,snd_emu10k1
i2c_i801                9740  0
snd_hwdep              10884  2 snd_emux_synth,snd_emu10k1
e752x_edac             12932  0
edac_mc                15428  1 e752x_edac
raid10                 26112  0
raid6                 109840  0
raid5                  35968  0
xor                    16520  2 raid6,raid5
raid0                   9856  0
dm_bbr                 14368  0
dm_snapshot            18852  0
dm_mirror              24144  0
usb_storage            83520  0
usbhid                 43040  0



I have the I2C stuff and Hardware Monitoring sections in my Kernel all 
<M>odularized.


Have I over loked anything?


Nick


-- 
Nick Ellson
CCDA, CCNP, CCSP, CCAI,
MCSE 2000, Security+, Network+
Network Hobbyist, VFR Private Pilot.


