From: Daniel Schenkenberger <fish@hotmail.de>
Date: Thu, 08 Sep 2011 13:11:39 +0000
Subject: [lm-sensors] Fintek F71862FG Super IO Sensors only shows coretemp
Message-Id: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1398225142046335822=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1398225142046335822==
Content-Type: multipart/alternative; boundary=90e6ba1efd501ac35404ac6dcd7d

--90e6ba1efd501ac35404ac6dcd7d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

sensors detect my chip but he only shows the core temp.

sensors-detect:

mezo@vdr:~$ sudo sensors-detect[sudo] password for mezo:
# sensors-detect revision 5861 (2010-09-21 17:21:05 +0200)
# System: OEM OEM
# Board: PCPartner G43-F71862

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Fintek F71862FG Super IO Sensors'                    Success!
    (address 0x295, driver `f71882fg')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): YES
Using driver `i2c-i801' for device 0000:00:1f.3: Intel ICH10
Module i2c-i801 loaded successfully.
Module i2c-dev loaded successfully.

Next adapter: Technotrend TT-connect S-2400 (i2c-0)
Do you want to scan it? (YES/no/selectively): YES
Adapter cannot be probed, skipping.
Next adapter: NVIDIA i2c adapter 0 at 1:00.0 (i2c-1)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 1 at 1:00.0 (i2c-2)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 2 at 1:00.0 (i2c-3)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 5 at 1:00.0 (i2c-4)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 6 at 1:00.0 (i2c-5)
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter 7 at 1:00.0 (i2c-6)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 8 at 1:00.0 (i2c-7)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 9 at 1:00.0 (i2c-8)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: SMBus I801 adapter at 0500 (i2c-9)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x4e
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              No
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1618'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `Maxim MAX6654'...                              No
Probing for `Maxim MAX6690'...                              No
Probing for `Maxim MAX6659'...                              No
Probing for `Maxim MAX6647'...                              No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Maxim MAX6695/MAX6696'...                      No
Probing for `Texas Instruments TMP411'...                   No
Probing for `Texas Instruments TMP421'...                   No
Probing for `Texas Instruments TMP422'...                   No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `National Semiconductor LM64'...                No
Probing for `National Semiconductor LM73'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `Fintek F75121R/F75122R/RG (VID+GPIO)'...       No
Probing for `Fintek F75111R/RG/N (GPIO)'...                 No
Probing for `ITE IT8201R/IT8203R/IT8206R/IT8266R'...        Yes
    (confidence 6, not a hardware monitoring chip)
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)

Driver `f71882fg':
  * ISA bus, address 0x295
    Chip `Fintek F71862FG Super IO Sensors' (confidence: 9)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
coretemp
f71882fg
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)yes
Successful!

Monitoring programs won't work until the needed modules are
loaded. You may want to run 'service module-init-tools start'
to load them.

Unloading i2c-dev... OK
Unloading i2c-i801... OK Unloading cpuid... OK


sensors show me only:

mezo@vdr:/etc/sensors.d$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=C2=B0C  (crit =3D +127.0=C2=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +55.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +55.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C)


lsmod says the module is loaded and i added
"acpi_enforce_resources=3Dlax" to my grub:

mezo@vdr:~$ lsmod
Module                  Size  Used by
lirc_serial            19165  3
snd_hda_codec_hdmi     28167  4
snd_hda_codec_realtek   336771  1
phc_intel              18278  1
cryptd                 20510  0
aes_x86_64             17208  1
aes_generic            38279  1 aes_x86_64
mperf                  12667  1 phc_intel
cpufreq_stats          13257  0
nvidia              11713775  54
snd_hda_intel          33176  3
snd_hda_codec         103804  3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel
arc4                   12529  2
snd_hwdep              13604  1 snd_hda_codec
lnbp21                 12938  1
ath9k                 118238  0
nfsd                  316512  13
tda826x                12973  1
snd_pcm                96391  6 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_co=
dec
mac80211              294370  1 ath9k
tda10086               18502  1
dvb_usb_ttusb2         21908  10
dvb_usb                24290  1 dvb_usb_ttusb2
snd_seq_midi           13324  0
ir_lirc_codec          12898  0
lirc_dev               19232  2 lirc_serial,ir_lirc_codec
exportfs               12998  1 nfsd
ath9k_common           13851  1 ath9k
ath9k_hw              323077  2 ath9k,ath9k_common
nfs                   330417  0
ir_sony_decoder        12549  0
f71882fg               35576  0
snd_rawmidi            30486  1 snd_seq_midi
ir_jvc_decoder         12546  0
ir_rc6_decoder         12546  0
coretemp               13490  0
snd_seq_midi_event     14899  1 snd_seq_midi
ir_rc5_decoder         12546  0
dvb_core              110487  1 dvb_usb
snd_seq                61621  2 snd_seq_midi,snd_seq_midi_event
snd_timer              29602  2 snd_pcm,snd_seq
snd_seq_device         14462  3 snd_seq_midi,snd_rawmidi,snd_seq
ir_nec_decoder         12546  0
snd                    67382  13
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hw=
dep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
ath                    23773  2 ath9k,ath9k_hw
serio_raw              13166  0
lp                     17825  0
lockd                  85732  2 nfsd,nfs
fscache                57123  1 nfs
nfs_acl                12883  2 nfsd,nfs
rc_core                26918  8
dvb_usb_ttusb2,dvb_usb,ir_lirc_codec,ir_sony_decoder,ir_jvc_decoder,ir_rc6_=
decoder,ir_rc5_decoder,ir_nec_decoder
auth_rpcgss            52881  2 nfsd,nfs
sunrpc                234297  14 nfsd,nfs,lockd,nfs_acl,auth_rpcgss
soundcore              12680  1 snd
joydev                 17606  0
cfg80211              178528  3 ath9k,mac80211,ath
snd_page_alloc         18529  2 snd_hda_intel,snd_pcm
parport                46458  1 lp
usbhid                 46956  0
hid                    91020  1 usbhid
r8169                  48022  0
vesafb                 13761  1


my mainboard is:

http://www.ubuntu-forum.de/index.php?page=3DExternalLink&url=3Dhttp%3A%2F%2=
Fwww.zotacusa.com%2Fintel-lga-775-g43-mini-itx-g43itx-a-e.html

--90e6ba1efd501ac35404ac6dcd7d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

sensors detect my chip but he only shows the core temp.<div><br></div><div>=
sensors-detect:</div><div><span class=3D"Apple-style-span" style=3D"backgro=
und-color: rgb(255, 255, 255); "><pre style=3D"color: rgb(51, 51, 51); font=
-size: 13px; line-height: 19px; font-family: monospace; margin-top: 0px; ma=
rgin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; pa=
dding-right: 5px; padding-bottom: 0px; padding-left: 5px; ">
mezo@vdr:~$ sudo sensors-detect[sudo] password for mezo:
# sensors-detect revision 5861 (2010-09-21 17:21:05 +0200)
# System: OEM OEM
# Board: PCPartner G43-F71862

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you&#39;re doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel digital thermal sensor...                             Success!
    (driver `coretemp&#39;)
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor&#39;...                   No
Trying family `SMSC&#39;...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek&#39;...               Yes
Found `Fintek F71862FG Super IO Sensors&#39;                    Success!
    (address 0x295, driver `f71882fg&#39;)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor&#39;...                   No
Trying family `SMSC&#39;...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek&#39;...               No
Trying family `ITE&#39;...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don&#39;t find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS&#39; at 0xca0...                      No
Probing for `IPMI BMC SMIC&#39; at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
Probing for `National Semiconductor LM78&#39; at 0x290...       No
Probing for `National Semiconductor LM79&#39; at 0x290...       No
Probing for `Winbond W83781D&#39; at 0x290...                   No
Probing for `Winbond W83782D&#39; at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): YES
Using driver `i2c-i801&#39; for device 0000:00:1f.3: Intel ICH10
Module i2c-i801 loaded successfully.
Module i2c-dev loaded successfully.

Next adapter: Technotrend TT-connect S-2400 (i2c-0)
Do you want to scan it? (YES/no/selectively): YES
Adapter cannot be probed, skipping.
Next adapter: NVIDIA i2c adapter 0 at 1:00.0 (i2c-1)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 1 at 1:00.0 (i2c-2)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 2 at 1:00.0 (i2c-3)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 5 at 1:00.0 (i2c-4)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 6 at 1:00.0 (i2c-5)
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x50
Probing for `Analog Devices ADM1033&#39;...                     No
Probing for `Analog Devices ADM1034&#39;...                     No
Probing for `SPD EEPROM&#39;...                                 No
Probing for `EDID EEPROM&#39;...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter 7 at 1:00.0 (i2c-6)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 8 at 1:00.0 (i2c-7)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter 9 at 1:00.0 (i2c-8)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: SMBus I801 adapter at 0500 (i2c-9)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x4e
Probing for `National Semiconductor LM75&#39;...                No
Probing for `Dallas Semiconductor DS75&#39;...                  No
Probing for `Dallas Semiconductor DS1621/DS1631&#39;...         No
Probing for `Analog Devices ADM1021&#39;...                     No
Probing for `Analog Devices ADM1021A/ADM1023&#39;...            No
Probing for `Maxim MAX1617&#39;...                              No
Probing for `Maxim MAX1617A&#39;...                             No
Probing for `Maxim MAX1668&#39;...                              No
Probing for `Maxim MAX1805&#39;...                              No
Probing for `Maxim MAX1989&#39;...                              No
Probing for `Maxim MAX6655/MAX6656&#39;...                      No
Probing for `TI THMC10&#39;...                                  No
Probing for `National Semiconductor LM84&#39;...                No
Probing for `Genesys Logic GL523SM&#39;...                      No
Probing for `Onsemi MC1066&#39;...                              No
Probing for `Maxim MAX1618&#39;...                              No
Probing for `Maxim MAX1619&#39;...                              No
Probing for `National Semiconductor LM82/LM83&#39;...           No
Probing for `Maxim MAX6654&#39;...                              No
Probing for `Maxim MAX6690&#39;...                              No
Probing for `Maxim MAX6659&#39;...                              No
Probing for `Maxim MAX6647&#39;...                              No
Probing for `Maxim MAX6680/MAX6681&#39;...                      No
Probing for `Maxim MAX6695/MAX6696&#39;...                      No
Probing for `Texas Instruments TMP411&#39;...                   No
Probing for `Texas Instruments TMP421&#39;...                   No
Probing for `Texas Instruments TMP422&#39;...                   No
Probing for `Texas Instruments AMC6821&#39;...                  No
Probing for `National Semiconductor LM64&#39;...                No
Probing for `National Semiconductor LM73&#39;...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635&#39;...              No
Probing for `Fintek F75121R/F75122R/RG (VID+GPIO)&#39;...       No
Probing for `Fintek F75111R/RG/N (GPIO)&#39;...                 No
Probing for `ITE IT8201R/IT8203R/IT8206R/IT8266R&#39;...        Yes
    (confidence 6, not a hardware monitoring chip)
Client found at address 0x50
Probing for `Analog Devices ADM1033&#39;...                     No
Probing for `Analog Devices ADM1034&#39;...                     No
Probing for `SPD EEPROM&#39;...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM&#39;...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033&#39;...                     No
Probing for `Analog Devices ADM1034&#39;...                     No
Probing for `SPD EEPROM&#39;...                                 Yes
    (confidence 8, not a hardware monitoring chip)

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp&#39;:
  * Chip `Intel digital thermal sensor&#39; (confidence: 9)

Driver `f71882fg&#39;:
  * ISA bus, address 0x295
    Chip `Fintek F71862FG Super IO Sensors&#39; (confidence: 9)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
coretemp
f71882fg
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)yes
Successful!

Monitoring programs won&#39;t work until the needed modules are
loaded. You may want to run &#39;service module-init-tools start&#39;
to load them.

Unloading i2c-dev... OK
Unloading i2c-i801... OK Unloading cpuid... OK</pre><pre style=3D"color: rg=
b(51, 51, 51); font-size: 13px; line-height: 19px; font-family: monospace; =
margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; p=
adding-top: 0px; padding-right: 5px; padding-bottom: 0px; padding-left: 5px=
; ">
<br></pre><pre style=3D"color: rgb(51, 51, 51); font-size: 13px; line-heigh=
t: 19px; font-family: monospace; margin-top: 0px; margin-right: 0px; margin=
-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 5px; paddi=
ng-bottom: 0px; padding-left: 5px; ">
sensors show me only:</pre><pre style=3D"margin-top: 0px; margin-right: 0px=
; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 5p=
x; padding-bottom: 0px; padding-left: 5px; "><font class=3D"Apple-style-spa=
n" color=3D"#333333" size=3D"3"><span class=3D"Apple-style-span" style=3D"l=
ine-height: 19px;">mezo@vdr:/etc/sensors.d$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=C2=B0C  (crit =3D +127.0=C2=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +55.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +55.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C)<=
/span></font></pre><pre style=3D"margin-top: 0px; margin-right: 0px; margin=
-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 5px; paddi=
ng-bottom: 0px; padding-left: 5px; ">
<font class=3D"Apple-style-span" color=3D"#333333" size=3D"3"><span class=
=3D"Apple-style-span" style=3D"line-height: 19px;"><br></span></font></pre>=
<pre style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margi=
n-left: 0px; padding-top: 0px; padding-right: 5px; padding-bottom: 0px; pad=
ding-left: 5px; ">
<font class=3D"Apple-style-span" color=3D"#333333" size=3D"3"><span class=
=3D"Apple-style-span" style=3D"line-height: 19px;">lsmod says the module is=
 loaded and i added &quot;acpi_enforce_resources=3Dlax&quot; to my grub:</s=
pan></font></pre>
<pre style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margi=
n-left: 0px; padding-top: 0px; padding-right: 5px; padding-bottom: 0px; pad=
ding-left: 5px; "><font class=3D"Apple-style-span" color=3D"#333333" size=
=3D"3"><span class=3D"Apple-style-span" style=3D"line-height: 19px;">mezo@v=
dr:~$ lsmod
Module                  Size  Used by
lirc_serial            19165  3
snd_hda_codec_hdmi     28167  4
snd_hda_codec_realtek   336771  1
phc_intel              18278  1
cryptd                 20510  0
aes_x86_64             17208  1
aes_generic            38279  1 aes_x86_64
mperf                  12667  1 phc_intel
cpufreq_stats          13257  0
nvidia              11713775  54
snd_hda_intel          33176  3
snd_hda_codec         103804  3 snd_hda_codec_hdmi,snd_hda_codec_realtek,sn=
d_hda_intel
arc4                   12529  2
snd_hwdep              13604  1 snd_hda_codec
lnbp21                 12938  1
ath9k                 118238  0
nfsd                  316512  13
tda826x                12973  1
snd_pcm                96391  6 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_co=
dec
mac80211              294370  1 ath9k
tda10086               18502  1
dvb_usb_ttusb2         21908  10
dvb_usb                24290  1 dvb_usb_ttusb2
snd_seq_midi           13324  0
ir_lirc_codec          12898  0
lirc_dev               19232  2 lirc_serial,ir_lirc_codec
exportfs               12998  1 nfsd
ath9k_common           13851  1 ath9k
ath9k_hw              323077  2 ath9k,ath9k_common
nfs                   330417  0
ir_sony_decoder        12549  0
f71882fg               35576  0
snd_rawmidi            30486  1 snd_seq_midi
ir_jvc_decoder         12546  0
ir_rc6_decoder         12546  0
coretemp               13490  0
snd_seq_midi_event     14899  1 snd_seq_midi
ir_rc5_decoder         12546  0
dvb_core              110487  1 dvb_usb
snd_seq                61621  2 snd_seq_midi,snd_seq_midi_event
snd_timer              29602  2 snd_pcm,snd_seq
snd_seq_device         14462  3 snd_seq_midi,snd_rawmidi,snd_seq
ir_nec_decoder         12546  0
snd                    67382  13 snd_hda_codec_hdmi,snd_hda_codec_realtek,s=
nd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,=
snd_seq_device
ath                    23773  2 ath9k,ath9k_hw
serio_raw              13166  0
lp                     17825  0
lockd                  85732  2 nfsd,nfs
fscache                57123  1 nfs
nfs_acl                12883  2 nfsd,nfs
rc_core                26918  8 dvb_usb_ttusb2,dvb_usb,ir_lirc_codec,ir_son=
y_decoder,ir_jvc_decoder,ir_rc6_decoder,ir_rc5_decoder,ir_nec_decoder
auth_rpcgss            52881  2 nfsd,nfs
sunrpc                234297  14 nfsd,nfs,lockd,nfs_acl,auth_rpcgss
soundcore              12680  1 snd
joydev                 17606  0
cfg80211              178528  3 ath9k,mac80211,ath
snd_page_alloc         18529  2 snd_hda_intel,snd_pcm
parport                46458  1 lp
usbhid                 46956  0
hid                    91020  1 usbhid
r8169                  48022  0
vesafb                 13761  1</span></font></pre><pre style=3D"margin-top=
: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top=
: 0px; padding-right: 5px; padding-bottom: 0px; padding-left: 5px; "><font =
class=3D"Apple-style-span" color=3D"#333333" size=3D"3"><span class=3D"Appl=
e-style-span" style=3D"line-height: 19px; "><br>
</span></font></pre><pre style=3D"margin-top: 0px; margin-right: 0px; margi=
n-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 5px; padd=
ing-bottom: 0px; padding-left: 5px; "><font class=3D"Apple-style-span" colo=
r=3D"#333333" size=3D"3"><span class=3D"Apple-style-span" style=3D"line-hei=
ght: 19px;">my mainboard is:</span></font></pre>
<pre style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margi=
n-left: 0px; padding-top: 0px; padding-right: 5px; padding-bottom: 0px; pad=
ding-left: 5px; "><font class=3D"Apple-style-span" color=3D"#333333" size=
=3D"3"><span class=3D"Apple-style-span" style=3D"line-height: 19px;"><a hre=
f=3D"http://www.ubuntu-forum.de/index.php?page=3DExternalLink&amp;url=3Dhtt=
p%3A%2F%2Fwww.zotacusa.com%2Fintel-lga-775-g43-mini-itx-g43itx-a-e.html">ht=
tp://www.ubuntu-forum.de/index.php?page=3DExternalLink&amp;url=3Dhttp%3A%2F=
%2Fwww.zotacusa.com%2Fintel-lga-775-g43-mini-itx-g43itx-a-e.html</a></span>=
</font></pre>
</span></div>

--90e6ba1efd501ac35404ac6dcd7d--


--===============1398225142046335822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1398225142046335822==--
