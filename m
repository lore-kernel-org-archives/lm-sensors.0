From: rhp.lpt@gmail.com (rhp)
Date: Thu, 15 Sep 2005 07:26:43 +0000
Subject: [lm-sensors] no sensors found beyond eeproms - OEM laptop -
Message-Id: <a2967b6d05091422267a1cd7e0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <a2967b6d05090101374c7f1294@mail.gmail.com>
In-Reply-To: <a2967b6d05090101374c7f1294@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

15-sep-05

Hello Rudolf:

Thank you for the response.

Since my original message I have upgraded the kernel:

43 torus:~> uname -a
Linux torus 2.6.13 #1 Mon Sep 5 16:37:24 ICT 2005 i686 i686 i386 GNU/Linux

There was no change in the output of sensors-detect from the previous
kernel.

I already have the thermal_zone:
ls /proc/acpi/thermal_zone/THM0/
cooling_mode  polling_frequency  state  temperature  trip_points

Additionally, GKRELLM recognizes and displays the cpu temperature.

However, I tried your suggestion:

45 torus:~> sudo modprobe thermal
FATAL: Module thermal not found.

(So I guess the thermal zone is set up on this machine using a different
module?).

Here are the results after loading the i2c-dev module, (the i2c-sis96x
module was already loaded).

49 torus:~> sudo i2cdump 0 0x6a
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x6a, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
10: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
20: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
30: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
40: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
50: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
60: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
70: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
80: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
90: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
a0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
b0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
c0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
d0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
e0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
f0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????

50 torus:~> sudo i2cdump 0 0x10
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x10, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

In reviewing the previous 'sensors-detect' output I noticed that it found
a "sensor" but that it is flagged 'no hardware monitoring capabilites':
....
Probing for `Nat. Semi. PC8739x Super IO'
  Success... (no hardware monitoring capabilities)
....

Looking up the PC8739x chip set, it appears the notation is correct, as
I found no mention of hardware monitoring.

Additionally, I wonder if the problem could also be the BIOS ?

BIOS: Phoenix (1.0a), ACPI 1.0b)
->Advanced->Chipset Information:
Bios Rev 1.00.08
CPU Type Mobile Intel(R) Pentium(R) 4
Bios Date 11/29/02
...

There is no 'Hardware Monitor' section in the BIOS.

FWIW: Here is the 'lsmod' output:
51 torus:~> sudo lsmod

Module                  Size  Used by
i2c_dev                12032  0
parport_pc             29636  1
lp                     13832  0
parport                42056  2 parport_pc,lp
sunrpc                176196  1
pcmcia                 42420  2
ipt_LOG                 7936  1
iptable_filter          3328  1
ip_tables              20736  2 ipt_LOG,iptable_filter
dm_mod                 62748  0
video                  16004  0
button                  6928  0
battery                 9604  0
ac                      5124  0
ipv6                  278336  12
ohci1394               40884  0
ieee1394              307064  1 ohci1394
yenta_socket           24844  2
rsrc_nonstatic         14464  1 yenta_socket
pcmcia_core            44968  3 pcmcia,yenta_socket,rsrc_nonstatic
ohci_hcd               26500  0
i2c_sis96x              6148  0
i2c_core               22144  2 i2c_dev,i2c_sis96x
snd_intel8x0m          19396  3
snd_intel8x0           35648  0
snd_ac97_codec         82172  2 snd_intel8x0m,snd_intel8x0
snd_pcm_oss            54432  0
snd_mixer_oss          19200  1 snd_pcm_oss
snd_pcm               106120  6
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              34820  1 snd_pcm
snd                    60804  11
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              11360  1 snd
snd_page_alloc         11144  3 snd_intel8x0m,snd_intel8x0,snd_pcm
8139too                32640  0
mii                     6016  1 8139too
floppy                 66932  0
joydev                 10048  0
ext3                  139272  2
jbd                    87448  1 ext3

Brgds
Bob

On 9/14/05, Rudolf Marek <r.marek@sh.cvut.cz> wrote:
> Hello,
> 
> It is difficult to find out what laptops are using. Maybe the ACPI
> thermal zone will work for you.
> 
> Did you try to load:
> modprobe thermal
> acpi -V
> 
> it should tell you the temp.
> 
> If you still want to use lm_sensors please send us output of following:
> 
> modprobe i2c-sis96x
> modprobe i2c-dev
> 
> i2cdump 0 0x6a
> i2cdump 0 0x10
> 
> Jean? Any other ideas?
> 
> regards
> Rudolf
> 
> 


-- 
rhp.lpt@gmail.com
