From: przemek.kulik@neostrada.pl (=?iso-8859-2?Q?Przemys=B3aw?= Kulik)
Date: Wed, 05 Apr 2006 22:13:27 +0000
Subject: [lm-sensors] [Fwd: Re: [Fwd: Sensor readings from Gigabyte
Message-Id: <1144275207.10510.1.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

additional info: I've notice that now eeprom module fails to load at
sturtup. I'm pretty sure that has been working (giving the same temps
though)

Przemek
-------- Przesy?any list ----------
Od: Przemys?aw Kulik <przemek.kulik at neostrada.pl>
Dla: lm-sensors at lm-sensors.org
Temat: Re: [lm-sensors] [Fwd: Sensor readings from Gigabyte I915P Duo
Pro (IT8712F)]
Data: Wed, 05 Apr 2006 20:40:11 +0200

Dnia 05-04-2006, ?ro o godzinie 09:39 +0200, Rudolf Marek napisa?(a):
> 2) We can do the bios disassembly to see what is on BIOS screen. Unfortunately
>    this can take some time and I dont have one. You can check my homepage
>    http://assembler.cz (BIos hacking) if you have some assembly skills.
Unfortunately I do not
> 3) Unload the it87, get acpi working, modprobe thermal, can you see the
> temperature with the command acpi -V
>    If so I will need the cat /proc/apci/dsdt > dsdt.bin (put it somewhere online
>    or send me in private please, mailing list is dropping binary attachs)
Nothing here...
1) Here's my config:
[*] ACPI Support
  <M>   AC Adapter
  < >   Battery
  < >   Button
  <M>   Video
  < >   Generic Hotkey (EXPERIMENTAL)
  <M>   Fan
  <M>   Processor
  <M>     Thermal Zone
  < >   ASUS/Medion Laptop Extras
  < >   IBM ThinkPad Laptop Extras
  < >   Toshiba Laptop Extras
  (0)   Disable ACPI for systems before Jan 1st this year
  [ ]   Debug Statements
  [ ]   Power Management Timer Support
  < >   ACPI0004,PNP0A05 and PNP0A06 Container Driver (EXPERIMENTAL)

2) before modprobing
# lsmod
Module                  Size  Used by
hwmon_vid               3200  0
snd_pcm_oss            48800  0
snd_mixer_oss          17792  25 snd_pcm_oss
snd_seq_oss            34688  0
snd_seq_midi_event      6912  1 snd_seq_oss
snd_seq                51856  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          8076  2 snd_seq_oss,snd_seq
spca5xx               690832  0
8250_pnp                9344  0
8250                   23412  1 8250_pnp
serial_core            19200  1 8250
snd_hda_intel          15120  26
snd_hda_codec          87808  1 snd_hda_intel
snd_pcm                81540  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              22404  2 snd_seq,snd_pcm
snd                    49508  13
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          9352  2 snd_hda_intel,snd_pcm
nvidia               3462748  22

# acpi -V
No support for device type: battery
No support for device type: thermal
No support for device type: ac_adapter

3) modprobing
# modprobe thermal

4) after modprobing
# lsmod
Module                  Size  Used by
thermal                11656  0
processor              16244  1 thermal
hwmon_vid               3200  0
snd_pcm_oss            48800  0
snd_mixer_oss          17792  25 snd_pcm_oss
snd_seq_oss            34688  0
snd_seq_midi_event      6912  1 snd_seq_oss
snd_seq                51856  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          8076  2 snd_seq_oss,snd_seq
spca5xx               690832  0
8250_pnp                9344  0
8250                   23412  1 8250_pnp
serial_core            19200  1 8250
snd_hda_intel          15120  26
snd_hda_codec          87808  1 snd_hda_intel
snd_pcm                81540  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              22404  2 snd_seq,snd_pcm
snd                    49508  13
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          9352  2 snd_hda_intel,snd_pcm
nvidia               3462748  22

# acpi -V
No support for device type: battery
No support for device type: thermal
No support for device type: ac_adapter

Sorry for rhis, but I'm a n00b when it comes to hardware sensors.

Przemek


