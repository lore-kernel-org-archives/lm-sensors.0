From: "Ivo Manca" <pinkel@gmail.com>
Date: Wed, 06 Jun 2007 10:35:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform
Message-Id: <007001c7a826$63bf6620$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603174224.44353a33@hyperion.delvare>
In-Reply-To: <20070603174224.44353a33@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I've removed the kernel source, extracted a fresh tarball, applied the 
patches and recompiled the kernel&modules.
After copying them to the other pc and rebooting it, the following output 
was shown:

[root@localhost ~]# sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

If you need more information, just ask
Ivo
----- Original Message ----- 
From: "Ivo Manca" <pinkel@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: <lm-sensors@lm-sensors.org>
Sent: Wednesday 6 June 2007 0:08
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform 
driver


> Hey Jean,
>
> I succeeded in compiling and testing 2.6.22-rc3 with your submitted 
> patches. It does not seem to work. Maybe I'm doing something wrong here, 
> or am overlooking something really big? I am quite new to this, after all.
> I will patch a new and clean kernel tomorrow and compile it again, just to 
> make sure I didn't mess anything up (which might be the case). Is it 
> possible for you to send the patches as attachment? Seems like my 
> mailclient messed them up the first time, so I might have messed it up 
> trying to get them to work (even though it didn't give any errors the last 
> time I patched..) ;/. It also doesn't give errors upon modprobing.
>
> So far my output:
>
> --
> [root@localhost detect]# uname -r
> 2.6.22-rc3
>
> [root@localhost detect]# sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
>
> [root@localhost detect]# lsmod
> Module                  Size  Used by
> i2c_dev                 9860  0
> ne2k_pci               12128  0
> 8390                   11520  1 ne2k_pci
> sis5595                15500  0
> hwmon                   6404  1 sis5595
> i2c_sis630             11276  0
> i2c_sis5595            10244  0
>
> --
> [root@localhost ~]# uname -r
> 2.6.19-1.2911.fc6
>
> [root@localhost ~]# sensors
> sis5595-isa-0290
> Adapter: ISA adapter
> VCore 1:   +2.86 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> VCore 2:   +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> +3.3V:     +2.77 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> +5V:       +3.44 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> +12V:     +14.90 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
> fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
> alarms:   Board temperature input (usually LM75 chips) ALARM
>
> [root@localhost ~]# lsmod
> Module                  Size  Used by
> autofs4                25797  2
> dmfe                   24677  0
> ipv6                  276481  12
> dm_mirror              26897  0
> dm_multipath           23241  0
> dm_mod                 63449  2 dm_mirror,dm_multipath
> parport_pc             31205  1
> lp                     16905  0
> parport                40841  2 parport_pc,lp
> snd_cmipci             39521  0
> gameport               20297  1 snd_cmipci
> floppy                 61477  0
> snd_seq_dummy           8133  0
> snd_seq_oss            37057  0
> snd_seq_midi_event     11841  1 snd_seq_oss
> snd_seq                57009  5 
> snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
> snd_pcm_oss            46433  0
> snd_mixer_oss          20545  1 snd_pcm_oss
> snd_pcm                80965  2 snd_cmipci,snd_pcm_oss
> snd_page_alloc         14281  1 snd_pcm
> snd_opl3_lib           14913  1 snd_cmipci
> ne2k_pci               15265  0
> snd_timer              26693  3 snd_seq,snd_pcm,snd_opl3_lib
> 8390                   14789  1 ne2k_pci
> snd_hwdep              13637  1 snd_opl3_lib
> pcspkr                  7360  0
> i2c_sis630             11853  0
> i2c_sis5595            11717  0
> sis5595                19401  0
> hwmon                   7621  1 sis5595
> i2c_isa                 9665  1 sis5595
> snd_mpu401_uart        13249  1 snd_cmipci
> i2c_core               26049  4 i2c_sis630,i2c_sis5595,sis5595,i2c_isa
> snd_rawmidi            28481  1 snd_mpu401_uart
> snd_seq_device         12365  5 
> snd_seq_dummy,snd_seq_oss,snd_seq,snd_opl3_lib,snd_rawmidi
> snd                    58181  12 
> snd_cmipci,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
> soundcore              12193  1 snd
> ext3                  136905  2
> jbd                    65001  1 ext3
> ehci_hcd               35661  0
> ohci_hcd               25433  0
> uhci_hcd               28237  0
>
> Ivo
> ----- Original Message ----- 
> From: "Jean Delvare" <khali@linux-fr.org>
> To: "Ivo Manca" <pinkel@gmail.com>
> Cc: <lm-sensors@lm-sensors.org>
> Sent: Monday 4 June 2007 17:37
> Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform 
> driver
>
>
>> Ivo,
>>
>> On Mon, 4 Jun 2007 14:42:30 +0200, Ivo Manca wrote:
>>> I'll try to get it working on the pc. Since it's only a 333mhz Celeron 
>>> cpu
>>> with about 32MB of ram, it might take some while to fetch a new kernel 
>>> and
>>> compile it ;). Or are there any other ways I can compile it with less
>>> effort?
>>
>> If you have another system of the same architecture, you can simply
>> compile your kernel there, make a staged install (set INSTALL_PATH and
>> INSTALL_MOD_PATH) and copy all the files over the network.
>>
>> Or if you have other systems with the same architecture _and_ compiler,
>> look into distcc. I have been using it some times ago and it was
>> working fine.
>> http://distcc.samba.org/
>>
>> -- 
>> Jean Delvare
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
