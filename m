From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 20 Jan 2007 19:01:47 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <4dfa50520701201101i2a6d24fco6f031548774de66a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

>  David Holl wrote:
> Yeah, my distro only has 2.10.1 as well.  (Gentoo -- hopefully they'll put
> it up under ~x86 soon... /me wonders how to become the Gentoo package
> maintainer for lm_sensors...)
>
>  Try 2.10.2 from http://www.lm-sensors.org/wiki/Download

I'm a gentoo fan also! If you become package maintainer, please let me
know... I'd love to see lm_sensors get more attention in gentoo.

On 1/19/07, Daniel Ceregatti <daniel at ceregatti.org> wrote:
>
>  Hi all,
>
>  Seems I also had libsensors from a manually compiled lm_sensors in
> /usr/local/lib. I've managed to remove all traces of this, installed 2.10.2
> via portage by making my own ebuild (overlay, in case you want it, is here:
> http://sh.nu/download/ebuilds) and:
>
>  w83627dhg-isa-0290
>  Adapter: ISA adapter
>  VCore:     +1.18 V  (min =  +0.00 V, max =  +1.74 V)
>  in1:      +11.14 V  (min =  +8.40 V, max = +12.04 V)
>  AVCC:      +3.20 V  (min =  +2.14 V, max =  +0.43 V) ALARM
>  3VCC:      +3.20 V  (min =  +1.15 V, max =  +2.13 V) ALARM
>  in4:       +1.18 V  (min =  +0.18 V, max =  +0.11 V) ALARM
>  in5:       +1.54 V  (min =  +0.69 V, max =  +1.71 V)
>  in6:       +5.86 V  (min =  +5.27 V, max =  +0.00 V) ALARM
>  VSB:       +3.20 V  (min =  +0.18 V, max =  +1.90 V) ALARM
>  VBAT:      +3.14 V  (min =  +2.13 V, max =  +1.34 V) ALARM
>  Case Fan:    0 RPM  (min = 4500 RPM, div = 4) ALARM
>  CPU Fan:  2083 RPM  (min = 84375 RPM, div = 8) ALARM
>  Aux Fan:     0 RPM  (min = 4066 RPM, div = 4) ALARM
>  fan4:        0 RPM  (min =  703 RPM, div = 16) ALARM
>  fan5:        0 RPM  (min = 6958 RPM, div = 2) ALARM
>  Sys Temp:    -65?C  (high =    +0?C, hyst =  +127?C)
>  CPU Temp:  +53.5?C  (high = +127.0?C, hyst =  +0.0?C)   ALARM
>  AUX Temp:  +54.5?C  (high = +127.0?C, hyst =  +0.0?C)
>
>  coretemp-isa-0000
>  Adapter: ISA adapter
>  temp1:       +56?C  (high =   +85?C)
>
>  coretemp-isa-0001
>  Adapter: ISA adapter
>  temp1:       +57?C  (high =   +85?C)
>
>  Here is a screen shot of my bios:
>
>  http://sh.nu/download/images/bios.jpg
>
>  I guess the next step is to configure it? Seems I'm missing a few things
> there.
>
>  Daniel

Daniel, I'm kicking myself right now. That's the easy solution, eh?
Now, when you modify sensors.conf, you'll be putting in
motherboard-specific information. We can push that upstream to the
lm_sensors project. I have an Asus P5B, and we should be able to find
just what's different between that and your EVGA 122-CK-NF68-AR.

I haven't gone through and fine-tuned my sensors.conf yet. I guess I
should do that this weekend.

David

