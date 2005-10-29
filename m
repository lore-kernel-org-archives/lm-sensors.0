From: mstamp@gmail.com (Matthew Stamp)
Date: Sat, 29 Oct 2005 02:22:35 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch,
Message-Id: <44b951e70510281722w3a2d1e5eo1f8c872230e63d70@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,
 Since my last email I have upgraded to 2.6.14 and got all the nessasary
modules in place. Although I have nothing in my /sys/bus/i2c/devices. I do
have abituguru and i2c_adapter in the drivers section. I was talking with
ollie long ago about this also. It seems his program openguru doesn't work
on my board either, I have a AN7 bios v.19. Yes I know it is been proven to
work with this board but for some reason it does not with mine. When I use
the openguru program it just simply states that uguru was not found.

 Debian Sid 2.6.14
 desktop:/home/tfmegatron# lsmod

Module Size Used by

ipt_limit 1920 11

ipt_LOG 6080 3

ipt_state 1408 4

ip_conntrack 42576 1 ipt_state

iptable_filter 2176 1

ip_tables 20480 4 ipt_limit,ipt_LOG,ipt_state,iptable_filter

emu10k1_gp 2688 0

gameport 11848 2 emu10k1_gp

snd_emu10k1_synth 6720 0

snd_emux_synth 36544 1 snd_emu10k1_synth

snd_seq_virmidi 6080 1 snd_emux_synth

snd_seq_midi_emul 6528 1 snd_emux_synth

snd_seq_dummy 2628 0

snd_seq_oss 33344 0

snd_seq_midi 6944 0

snd_seq_midi_event 6272 3 snd_seq_virmidi,snd_seq_oss,snd_seq_midi

snd_seq 51344 9
snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event

snd_emu10k1 120036 1 snd_emu10k1_synth

snd_rawmidi 21600 3 snd_seq_virmidi,snd_seq_midi,snd_emu10k1

snd_seq_device 6988 8
snd_emu10k1_synth,snd_emux_synth,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_emu10k1,snd_rawmidi

snd_ac97_codec 93884 1 snd_emu10k1

snd_pcm_oss 50208 0

snd_mixer_oss 17536 1 snd_pcm_oss

snd_pcm 85000 3 snd_emu10k1,snd_ac97_codec,snd_pcm_oss

snd_timer 22340 3 snd_seq,snd_emu10k1,snd_pcm

snd_ac97_bus 1792 1 snd_ac97_codec

snd_page_alloc 8456 2 snd_emu10k1,snd_pcm

snd_util_mem 3328 2 snd_emux_synth,snd_emu10k1

snd_hwdep 7328 2 snd_emux_synth,snd_emu10k1

snd 47012 13
snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_hwdep

soundcore 7904 1 snd

ohci1394 33012 0

ieee1394 90164 1 ohci1394

nvidia 3904188 12

lp 9412 0

parport_pc 26116 1

parport 34888 2 lp,parport_pc

Anything else you might want to look at just ask. Thanks for your time.
 matt
 On 10/27/05, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
>
>
>
> Matt Stamp wrote:
> > I am getting an error when trying to insert module and it will not
> force.
> >
> > I get.
> >
> > insmod abituguru.ko
> > insmod: error inserting 'abituguru.ko' : -1 Unknown symbol in module
> >
> > I am using debian unstable with kernel 2.6.13.4 <http://2.6.13.4>.
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
>
> Yes, my mistake (in the docs), you should use kernel 2.6.14rc4 or newer
> 2.6.13 is not new enough.
>
> Regards,
>
> Hans
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
