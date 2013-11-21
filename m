From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Nov 2013 17:11:46 +0000
Subject: Re: [lm-sensors] how to adjust properties?
Message-Id: <20131121171146.GA10783@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384981512.39249.YahooMailNeo@web122905.mail.ne1.yahoo.com>
In-Reply-To: <1384981512.39249.YahooMailNeo@web122905.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Nov 21, 2013 at 12:51:02AM -0800, jonathan stewart wrote:
>=20
> # sensors-detect revision 6031 (2012-03-07 17:14:01 +0100)
> # Board: Micro-Star International Co., Ltd. MS-1761
>=20
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>=20
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): yes
> Module cpuid loaded successfully.
> Silicon Integrated Systems SIS5595...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> VIA VT82C686 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> VIA VT8231 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD K8 thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD Family 10h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD Family 11h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD Family 12h and 14h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD Family 15h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> AMD Family 15h power sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Intel digital thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!
> =A0=A0=A0 (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> VIA C7 thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> VIA Nano thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
>=20
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): yes
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor/ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No
> Trying family `SMSC'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No
> Trying family `ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor/ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No
> Trying family `SMSC'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No
> Trying family `ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
>=20
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no): yes
> Probing for `National Semiconductor LM78' at 0x290...=A0=A0=A0=A0=A0=A0 No
> Probing for `National Semiconductor LM79' at 0x290...=A0=A0=A0=A0=A0=A0 No
> Probing for `Winbond W83781D' at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for `Winbond W83782D' at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No
>=20
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no): yes
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel Cougar Point (PCH)
> Module i2c-i801 loaded successfully.
> Module i2c-dev loaded successfully.
>=20
> Next adapter: NVIDIA i2c adapter 0 at 1:00.0 (i2c-0)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Next adapter: NVIDIA i2c adapter 1 at 1:00.0 (i2c-1)
> Do you want to scan it? (YES/no/selectively): yes
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for `Analog Devices ADM1034'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for `SPD EEPROM'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No
> Probing for `EDID EEPROM'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes
> =A0=A0=A0 (confidence 8, not a hardware monitoring chip)
>=20
> Next adapter: NVIDIA i2c adapter 2 at 1:00.0 (i2c-2)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Next adapter: NVIDIA i2c adapter 3 at 1:00.0 (i2c-3)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Next adapter: NVIDIA i2c adapter 5 at 1:00.0 (i2c-4)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Next adapter: NVIDIA i2c adapter 8 at 1:00.0 (i2c-5)
> Do you want to scan it? (YES/no/selectively): yes
>=20
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:=20
>=20
> Driver `coretemp':
> =A0 * Chip `Intel digital thermal sensor' (confidence: 9)
>=20
> Module=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Size=A0 Used by
> snd_hda_codec_hdmi=A0=A0=A0=A0 36906=A0 4=20
> coretemp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 13355=A0 0=20
> kvm_intel=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 132891=A0 0=20
> kvm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 443165=A0 1 kvm=
_intel
> ghash_clmulni_intel=A0=A0=A0 13259=A0 0=20
> aesni_intel=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 55399=A0 1=20
> aes_x86_64=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17255=A0 1 aesni_intel
> xts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 12885=A0 1 a=
esni_intel
> lrw=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 13257=A0 1 a=
esni_intel
> gf128mul=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 14951=A0 2 lrw,xts
> ablk_helper=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 13597=A0 1 aesni_intel
> cryptd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20373=A0 3 ghash_c=
lmulni_intel,aesni_intel,ablk_helper
> nvidia=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 11309139=A0 43=20
> arc4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 12615=A0 2=20
> snd_hda_codec_realtek=A0=A0=A0 78399=A0 1=20
> ath9k=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 149924=A0 0=20
> ath9k_common=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 14055=A0 1 ath9k
> snd_hda_intel=A0=A0=A0=A0=A0=A0=A0=A0=A0 39619=A0 5=20
> ath9k_hw=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 413629=A0 2 ath9k_common,=
ath9k
> snd_hda_codec=A0=A0=A0=A0=A0=A0=A0=A0 136498=A0 3 snd_hda_codec_realtek,s=
nd_hda_codec_hdmi,snd_hda_intel
> ath=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 23827=A0 3 a=
th9k_common,ath9k,ath9k_hw
> snd_hwdep=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 13602=A0 1 snd_hda_codec
> snd_pcm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 97451=A0 3 snd_hda_c=
odec_hdmi,snd_hda_codec,snd_hda_intel
> mac80211=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 606457=A0 1 ath9k
> rts5139=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 352481=A0 0=20
> snd_page_alloc=A0=A0=A0=A0=A0=A0=A0=A0 18710=A0 2 snd_pcm,snd_hda_intel
> snd_seq_midi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 13324=A0 0=20
> snd_seq_midi_event=A0=A0=A0=A0 14899=A0 1 snd_seq_midi
> snd_rawmidi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 30180=A0 1 snd_seq_midi
> microcode=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 22881=A0 0=20
> snd_seq=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 61554=A0 2 snd_seq_m=
idi_event,snd_seq_midi
> cfg80211=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 511019=A0 3 ath,ath9k,mac=
80211
> joydev=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17377=A0 0=20
> psmouse=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 95905=A0 0=20
> serio_raw=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 13215=A0 0=20
> snd_seq_device=A0=A0=A0=A0=A0=A0=A0=A0 14497=A0 3 snd_seq,snd_rawmidi,snd=
_seq_midi
> snd_timer=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 29425=A0 2 snd_pcm,snd_s=
eq
> lpc_ich=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17061=A0 0=20
> mei=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 41158=A0 0=20
> snd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 68876=A0 20 =
snd_hda_codec_realtek,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_se=
q,snd_rawmidi,snd_hda_codec,snd_hda_intel,snd_seq_device
> soundcore=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 12680=A0 1 snd
> mxm_wmi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 13021=A0 0=20
> parport_pc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 28152=A0 0=20
> bnep=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 18036=A0 2=20
> ppdev=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17073=A0 0=20
> rfcomm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 42641=A0 0=20
> bluetooth=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 228808=A0 10 bnep,rfcomm
> binfmt_misc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17500=A0 1=20
> dm_multipath=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 22843=A0 0=20
> scsi_dh=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 14843=A0 1 dm_multip=
ath
> wmi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 19070=A0 1 m=
xm_wmi
> video=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 19390=A0 0=20
> mac_hid=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 13205=A0 0=20
> lp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17759=A0 0=
=20
> parport=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 46345=A0 3 lp,ppdev,=
parport_pc
> hid_generic=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 12540=A0 0=20
> usbhid=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 47074=A0 0=20
> hid=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 101042=A0 2 hid=
_generic,usbhid
> dm_raid45=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 76725=A0 0=20
> r8169=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 67466=A0 0=20
> ahci=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 25731=A0 2=20
> libahci=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 31364=A0 1 ahci
> xor=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17116=A0 1 d=
m_raid45
> dm_mirror=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 21946=A0 0=20
> dm_region_hash=A0=A0=A0=A0=A0=A0=A0=A0 20820=A0 1 dm_mirror
> dm_log=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 18529=A0 3 dm_regi=
on_hash,dm_mirror,dm_raid45
>=20
>=20
>=20
> it is a laptop, its from xoticpc.com its a force1761 based on the msi gt7=
90dxr it has an i7-2670qm, 4gb patriot ddr3 1600mhz, nvidia gtx570m, corsai=
r performance pro 128gb ssd, 750gb seagate 7200 rpm hdd (? on actual speed =
but its not the 5k version), and a dvd burner
>=20
> it says in synaptic=20
>=20
>=20
> "Lm-sensors is a hardware health monitoring package for Linux. It allows =
you
> to access information from temperature, voltage, and fan speed sensors. It
> works with most newer systems.
>=20
> This package contains a daemon that calculates fan speeds from temperatur=
es
> and sets the corresponding PWM outputs to the computed values."
>=20
>=20
> so i am curious on how to adjust the calculations because at them moment =
my fan does not increase in rpm enough to keep itself cool. if i am playing=
 minecraft on a public server with 200+ people the cpu temps will hit 90C+ =
and sometimes it crashes my game. i have the same issue with left4dead2 onl=
y it begins lagging bad and will start temporarily disconnecting me from st=
eam. if i hit a button above my keyboard it forces the fan to 100% which th=
en cools it down and stops my lagging but also prevents me from using my mi=
c for voip as the fan is loud and sounds like a blow dryer. after i downloa=
ded/installed the fansensors thing from synaptic my minecraft temps dropped=
 to upper 80C's which is better but i would like it to be in the 60's or 70=
's which i know its capable of if the fan would just turn on so it will sta=
y moderatly cool and not cook itself.
>=20
Interesting; based on the information you provided I would have assumed
that fan control is not available in your system.

Did you run the 'pwmconfig' script ? If so, what did it report ?
Also, can you provide output from the 'sensors' command ?

Thanks,
Guenter

> sorry if this still isnt enough information i am good at building pc's an=
d judging their performance but i've just started learning about the softwa=
re/os side of things
>=20
>=20
>=20
>=20
> On Wednesday, November 20, 2013 5:02 PM, Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> =20
> On Wed, Nov 20, 2013 at 01:05:12PM -0800, jonathan stewart wrote:
>=20
> > i have downloaded/installed the lm sensors (and related packages) and f=
ancontrol through the synaptic package manager. i was wondering if you coul=
d tell me how to adjust the fan speed. i am using ubuntu 13.04 64bit and i =
only ask because my temps get up to the low 90C's and my fan doesnt spin up=
 much. i have a button that sets fan speed at 100% then temps drop to 50C's=
 but its way to noisy. sorry if this is confusing i'm not entirely sure on =
how to state my problem.
> > _______________________________________________
>=20
> Hi,
>=20
> you do not really provide enough information to enable us to help.
> Output from "sensors" command might be helpful, as well as
> some more information about your hardware.
> PC ? Laptop ? CPU type ? Super-IO chip ? fancontrol configuration ?
>=20
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
