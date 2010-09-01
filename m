From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Wed, 01 Sep 2010 16:57:14 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <265904.16463.qm@web50001.mail.re2.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9106538354246706045=="
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============9106538354246706045==
Content-Type: multipart/alternative; boundary="0-1378397757-1283360234=:16463"

--0-1378397757-1283360234=:16463
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>=A0 sudo aptitude reinstall lm-sensors=0AThat didn't work. So I managed to=
 completely remove lm-sensors with "sudo =0Aapt-get --purge remove lm-senso=
rs".=0AAfter that I enterd progs/detect and ran "sudo ./sensors-detect":=0A=
=0Amahmood@localhost:detect$ sudo ./sensors-detect=0A# sensors-detect revis=
ion 5853 (2010-08-13 02:00:13 +0430)=0A# System: Gigabyte Technology Co., L=
td. P55-USB3=0AThis program will help you determine which kernel modules yo=
u need=0Ato load to use lm_sensors most effectively. It is generally safe=
=0Aand recommended to accept the default answers to all questions,=0Aunless=
 you know what you're doing.=0ASome south bridges, CPUs or memory controlle=
rs contain embedded sensors.=0ADo you want to scan for them? This is totall=
y safe. (YES/no): y=0ASilicon Integrated Systems SIS5595...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AVIA VT82C686 Integ=
rated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No=0AVIA VT8231 Integrated Sensors...=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AAMD K8=
 thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AAMD Family 10h therma=
l sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No=0AAMD Family 11h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AIntel Core f=
amily thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Success!=0A=A0=A0=A0 (driver `coretemp')=0AIntel Atom=
 thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AIntel AMB FB-DIMM thermal sensor.=
..=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
No=0AVIA C7 thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AVIA Nano =
thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ASome Super I/O chips contai=
n embedded sensors. We have to write to=0Astandard I/O ports to probe them.=
 This is usually safe.=0ADo you want to scan for Super I/O sensors? (YES/no=
): y=0AProbing for Super-I/O at 0x2e/0x2f=0ATrying family `National Semicon=
ductor'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATryin=
g family `SMSC'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATrying family `VIA=
/Winbond/Nuvoton/Fintek'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0A=
Trying family `ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes=0AFound `I=
TE IT8720F Super IO Sensors'=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 Success!=0A=A0=A0=A0 (address 0x290, driver `it87'=
)=0AProbing for Super-I/O at 0x4e/0x4f=0ATrying family `National Semiconduc=
tor'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATrying f=
amily `SMSC'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATrying family `VIA/Wi=
nbond/Nuvoton/Fintek'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATry=
ing family `ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ASome systems=
 (mainly servers) implement IPMI, a set of common interfaces=0Athrough whic=
h system health data may be retrieved, amongst other things.=0AWe first try=
 to get the information from SMBIOS. If we don't find it=0Athere, we have t=
o read from arbitrary I/O ports to probe for such=0Ainterfaces. This is nor=
mally safe. Do you want to scan for IPMI=0Ainterfaces? (YES/no): y=0AProbin=
g for `IPMI BMC KCS' at 0xca0...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `IPMI BMC SMIC' at 0xca8...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ASome hardware moni=
toring chips are accessible through the ISA I/O ports.=0AWe have to write t=
o arbitrary I/O ports to probe them. This is usually=0Asafe though. Yes, yo=
u do have ISA I/O ports even if you do not have any=0AISA slots! Do you wan=
t to scan the ISA I/O ports? (yes/NO): y=0AProbing for `National Semiconduc=
tor LM78' at 0x290...=A0=A0=A0=A0=A0=A0 No=0AProbing for `National Semicond=
uctor LM79' at 0x290...=A0=A0=A0=A0=A0=A0 No=0AProbing for `Winbond W83781D=
' at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0APr=
obing for `Winbond W83782D' at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No=0ALastly, we can probe the I2C/SMBus adapters for con=
nected hardware=0Amonitoring devices. This is the most risky part, and whil=
e it works=0Areasonably well on most systems, it has been reported to cause=
 trouble=0Aon some systems.=0ADo you want to probe the I2C/SMBus adapters n=
ow? (YES/no): y=0AUsing driver `i2c-i801' for device 0000:00:1f.3: Intel 34=
00/5 Series (PCH)=0AModule i2c-i801 loaded successfully.=0AModule i2c-dev l=
oaded successfully.=0ANext adapter: NVIDIA i2c adapter=A0 (i2c-0)=0ADo you =
want to scan it? (YES/no/selectively): y=0ANext adapter: NVIDIA i2c adapter=
=A0 (i2c-1)=0ADo you want to scan it? (YES/no/selectively): y=0AClient foun=
d at address 0x49=0AProbing for `National Semiconductor LM75'...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Dallas Semiconductor=
 DS75'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing f=
or `National Semiconductor LM77'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 No=0AProbing for `Dallas Semiconductor DS1621/DS1631'...=A0=A0=A0=A0=
=A0=A0=A0=A0 No=0AProbing for `National Semiconductor LM73'...=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `National Semiconductor =
LM92'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Nat=
ional Semiconductor LM76'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 N=
o=0AProbing for `Maxim MAX6633/MAX6634/MAX6635'...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No=0AClient found at address 0x50=0AProbing for `Analog Dev=
ices ADM1033'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 No=0AProbing for `Analog Devices ADM1034'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `SPD EEPROM'...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 No=0AProbing for `EDID EEPROM'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes=0A=
=A0=A0=A0 (confidence 8, not a hardware monitoring chip)=0ANext adapter: NV=
IDIA i2c adapter=A0 (i2c-2)=0ADo you want to scan it? (YES/no/selectively):=
 y=0ANext adapter: NVIDIA i2c adapter=A0 (i2c-3)=0ADo you want to scan it? =
(YES/no/selectively): y=0ANext adapter: NVIDIA i2c adapter=A0 (i2c-4)=0ADo =
you want to scan it? (YES/no/selectively): y=0ANext adapter: NVIDIA i2c ada=
pter=A0 (i2c-5)=0ADo you want to scan it? (YES/no/selectively): y=0ANext ad=
apter: NVIDIA i2c adapter=A0 (i2c-6)=0ADo you want to scan it? (YES/no/sele=
ctively): y=0ANext adapter: NVIDIA i2c adapter=A0 (i2c-7)=0ADo you want to =
scan it? (YES/no/selectively): y=0ANext adapter: SMBus I801 adapter at 0500=
 (i2c-8)=0ADo you want to scan it? (yes/NO/selectively): y=0AClient found a=
t address 0x4e=0AProbing for `National Semiconductor LM75'...=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Dallas Semiconductor DS=
75'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for =
`Dallas Semiconductor DS1621/DS1631'...=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbin=
g for `Analog Devices ADM1021'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No=0AProbing for `Analog Devices ADM1021A/ADM1023'...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Maxim MAX1617'...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 No=0AProbing for `Maxim MAX1617A'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Maxim=
 MAX1668'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Maxim MAX1805'...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=
=0AProbing for `Maxim MAX1989'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Maxim MAX66=
55/MAX6656'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 No=0AProbing for `TI THMC10'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing f=
or `National Semiconductor LM84'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 No=0AProbing for `Genesys Logic GL523SM'...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Onsemi MC1066'...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 No=0AProbing for `Maxim MAX1618'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing f=
or `Maxim MAX1619'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `National Semiconductor =
LM82/LM83'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Maxim MAX6654=
'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No=0AProbing for `Maxim MAX6690'...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0APro=
bing for `Maxim MAX6659'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Maxim MAX6647'...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 No=0AProbing for `Maxim MAX6680/MAX6681'...=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Texas Instr=
uments TMP411'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=
=0AProbing for `Texas Instruments TMP421'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Texas Instruments TMP422'...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Texas=
 Instruments AMC6821'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 No=0AProbing for `National Semiconductor LM64'...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `National Semiconductor LM73'...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Maxim MAX6633/=
MAX6634/MAX6635'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for=
 `Fintek F75121R/F75122R/RG (VID+GPIO)'...=A0=A0=A0=A0=A0=A0 No=0AProbing f=
or `Fintek F75111R/RG/N (GPIO)'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 No=0AProbing for `ITE IT8201R/IT8203R/IT8206R/IT8266R'...=A0=A0=
=A0=A0=A0=A0=A0 Yes=0A=A0=A0=A0 (confidence 6, not a hardware monitoring ch=
ip)=0AClient found at address 0x52=0AProbing for `Analog Devices ADM1033'..=
.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing =
for `Analog Devices ADM1034'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No=0AProbing for `SPD EEPROM'...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=
=0AClient found at address 0x53=0AProbing for `Analog Devices ADM1033'...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing f=
or `Analog Devices ADM1034'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 No=0AProbing for `SPD EEPROM'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0A=
Now follows a summary of the probes I have just done.=0AJust press ENTER to=
 continue:=0ADriver `it87':=0A=A0 * ISA bus, address 0x290=0A=A0=A0=A0 Chip=
 `ITE IT8720F Super IO Sensors' (confidence: 9)=0ADriver `coretemp':=0A=A0 =
* Chip `Intel Core family thermal sensor' (confidence: 9)=0ADo you want to =
overwrite /etc/sysconfig/lm_sensors? (YES/no): yes=0ACopy prog/init/lm_sens=
ors.init to /etc/init.d/lm_sensors=0Afor initialization at boot time.=0AYou=
 should now start the lm_sensors service to load the required=0Akernel modu=
les.=0AUnloading i2c-dev... OK=0AUnloading i2c-i801... OK=0A=A0=0AAs you se=
e, core-i7 is detected. Also it says: "Copy prog/init/lm_sensors.init =0Ato=
 /etc/init.d/lm_sensors=0Afor initialization at boot time." I did that. =0A=
=A0=0ANow shat should I do in the next step? I don't want to reboot. What i=
s the =0Acommand to restart the service?=0A=A0=0A// Naderan *Mahmood;=0A=0A=
=0A=0A=0A________________________________=0AFrom: Guenter Roeck <guenter.ro=
eck@ericsson.com>=0ATo: Mahmood Naderan <nt_mahmood@yahoo.com>=0ACc: lm-sen=
sors <lm-sensors@lm-sensors.org>=0ASent: Wed, September 1, 2010 8:22:03 PM=
=0ASubject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors=0A=0A=
On Wed, Sep 01, 2010 at 10:58:47AM -0400, Mahmood Naderan wrote:=0A> >The c=
urrent text is quite absolute ("Copy prog/init/lm_sensors.init to =0A>/etc/=
init.d/lm_sensors")=0A> >and really invites users to overwrite the distribu=
tion specific scripts.=0A> =0A> I really did that. See:=0A> =0A[...]=0A=0A>=
 Do you confirm that? What should I do in order to remove lm-sensor and =0A=
>reinstall it again?=0A> =0ATry=0A=0A=A0=A0=A0 sudo aptitude reinstall lm-s=
ensors=0A=0AGuenter=0A=0A=0A=0A      
--0-1378397757-1283360234=:16463
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:Courier New, courier, monaco, monospace,=
 sans-serif;font-size:10pt"><P><FONT size=3D3 face=3D"tahoma, new york, tim=
es, serif">&gt;&nbsp; sudo aptitude reinstall lm-sensors</FONT></P>=0A<P><F=
ONT size=3D3 face=3D"tahoma, new york, times, serif">That didn't work. So I=
 managed to completely remove lm-sensors with "sudo apt-get --purge remove =
lm-sensors".</FONT></P>=0A<P><FONT size=3D3 face=3D"tahoma, new york, times=
, serif">After that I enterd progs/detect and ran "sudo ./sensors-detect":<=
/FONT></P>=0A<P><BR><A href=3D"mailto:mahmood@localhost:detect$">mahmood@lo=
calhost:detect$</A> sudo ./sensors-detect<BR># sensors-detect revision 5853=
 (2010-08-13 02:00:13 +0430)<BR># System: Gigabyte Technology Co., Ltd. P55=
-USB3</P>=0A<P>This program will help you determine which kernel modules yo=
u need<BR>to load to use lm_sensors most effectively. It is generally safe<=
BR>and recommended to accept the default answers to all questions,<BR>unles=
s you know what you're doing.</P>=0A<P>Some south bridges, CPUs or memory c=
ontrollers contain embedded sensors.<BR>Do you want to scan for them? This =
is totally safe. (YES/no): y<BR>Silicon Integrated Systems SIS5595...&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>VIA VT82C686 Inte=
grated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<BR>VIA VT8231 Integrated Sensors...&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>=
AMD K8 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; No<BR>AMD Family 10h
 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>AMD Family 11h thermal sensors...&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<=
BR><FONT color=3D#ff0000>Intel Core family thermal sensor...&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!</FONT><BR>&=
nbsp;&nbsp;&nbsp; (driver `coretemp')<BR>Intel Atom thermal sensor...&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Intel AMB FB-DIMM thermal
 sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; No<BR>VIA C7 thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; No<BR>VIA Nano thermal sensor...&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; No</P>=0A<P>Some Super I/O chips contain embedde=
d sensors. We have to write to<BR>standard I/O ports to probe them. This is=
 usually safe.<BR>Do you want to scan for Super I/O sensors? (YES/no): y<BR=
>Probing for Super-I/O at 0x2e/0x2f<BR>Trying family `National Semiconducto=
r'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Trying family `SMSC'...&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Trying fa=
mily `VIA/Winbond/Nuvoton/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR><FONT color=3D#000000>T=
rying family
 `ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Yes<BR>Found `ITE IT8720F Super IO Sensors'&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!</FONT><BR>&nbsp;&nbsp;&nbsp=
; (address 0x290, driver `it87')<BR>Probing for Super-I/O at 0x4e/0x4f<BR>T=
rying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N=
o<BR>Trying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; No<BR>Trying family
 `VIA/Winbond/Nuvoton/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Trying family `ITE'...&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No</P>=
=0A<P>Some systems (mainly servers) implement IPMI, a set of common interfa=
ces<BR>through which system health data may be retrieved, amongst other thi=
ngs.<BR>We first try to get the information from SMBIOS. If we don't find i=
t<BR>there, we have to read from arbitrary I/O ports to probe for such<BR>i=
nterfaces. This is normally safe. Do you want to scan for IPMI<BR>interface=
s? (YES/no): y<BR>Probing for `IPMI BMC KCS' at 0xca0...&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `IPMI BMC SMIC' at 0xca8=
...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No</P>=0A<P>Some hardware =
monitoring chips are accessible through the ISA I/O ports.<BR>We have to wr=
ite to arbitrary I/O ports to probe them. This is usually<BR>safe though. Y=
es, you do have ISA I/O ports even if you do not have any<BR>ISA slots! Do =
you want to scan the ISA I/O ports? (yes/NO): y<BR>Probing for `National Se=
miconductor LM78' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Pro=
bing for `National Semiconductor LM79' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; No<BR>Probing for `Winbond W83781D' at 0x290...&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<BR>Probing for `Winbond W83782D' at 0x290...&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; No</P>=0A<P>Lastly, we can probe the I2C/SMBus adap=
ters for connected hardware<BR>monitoring devices. This is the most risky p=
art, and while it works<BR>reasonably well on most systems, it has been rep=
orted to cause trouble<BR>on some systems.<BR>Do you want to probe the I2C/=
SMBus adapters now? (YES/no): y<BR>Using driver `i2c-i801' for device 0000:=
00:1f.3: Intel 3400/5 Series (PCH)<BR>Module i2c-i801 loaded successfully.<=
BR>Module i2c-dev loaded successfully.</P>=0A<P>Next adapter: NVIDIA i2c ad=
apter&nbsp; (i2c-0)<BR>Do you want to scan it? (YES/no/selectively): y</P>=
=0A<P>Next adapter: NVIDIA i2c adapter&nbsp; (i2c-1)<BR>Do you want to scan=
 it? (YES/no/selectively): y<BR>Client found at address 0x49<BR>Probing for=
 `National Semiconductor LM75'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Dallas =
Semiconductor DS75'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Nation=
al Semiconductor LM77'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Dallas Semicond=
uctor DS1621/DS1631'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<=
BR>Probing for `National Semiconductor LM73'...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probin=
g for `National Semiconductor LM92'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for
 `National Semiconductor LM76'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim M=
AX6633/MAX6634/MAX6635'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Client found at address 0x50<BR>Probing=
 for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; No<BR>Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; No<BR>Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; No<BR><FONT color=3D#000000>Probing for `EDID
 EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes</FONT><BR>&nbsp;&nbsp;&=
nbsp; (confidence 8, not a hardware monitoring chip)</P>=0A<P>Next adapter:=
 NVIDIA i2c adapter&nbsp; (i2c-2)<BR>Do you want to scan it? (YES/no/select=
ively): y</P>=0A<P>Next adapter: NVIDIA i2c adapter&nbsp; (i2c-3)<BR>Do you=
 want to scan it? (YES/no/selectively): y</P>=0A<P>Next adapter: NVIDIA i2c=
 adapter&nbsp; (i2c-4)<BR>Do you want to scan it? (YES/no/selectively): y</=
P>=0A<P>Next adapter: NVIDIA i2c adapter&nbsp; (i2c-5)<BR>Do you want to sc=
an it? (YES/no/selectively): y</P>=0A<P>Next adapter: NVIDIA i2c adapter&nb=
sp; (i2c-6)<BR>Do you want to scan it? (YES/no/selectively): y</P>=0A<P>Nex=
t adapter: NVIDIA i2c adapter&nbsp; (i2c-7)<BR>Do you want to scan it? (YES=
/no/selectively): y</P>=0A<P>Next adapter: SMBus I801 adapter at 0500 (i2c-=
8)<BR>Do you want to scan it? (yes/NO/selectively): y<BR>Client found at ad=
dress 0x4e<BR>Probing for `National Semiconductor LM75'...&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N=
o<BR>Probing for `Dallas Semiconductor DS75'...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No<BR>Probing for `Dallas Semiconductor DS1621/DS1631'...&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Analog Devices ADM1021'..=
.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Analog De=
vices ADM1021A/ADM1023'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim
 MAX1617'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim MAX1617A'...&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim MAX1668'...&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; No<BR>Probing for `Maxim MAX1805'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Prob=
ing for `Maxim
 MAX1989'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim MAX6655/MAX66=
56'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for=
 `TI THMC10'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probi=
ng for `National Semiconductor LM84'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `G=
enesys Logic GL523SM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 No<BR>Probing for `Onsemi
 MC1066'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim MAX1618'...&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim MAX1619'...&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; No<BR>Probing for `National Semiconductor LM82/LM83'...&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim M=
AX6654'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim
 MAX6690'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim MAX6659'...&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim MAX6647'...&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; No<BR>Probing for `Maxim MAX6680/MAX6681'...&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Texas Instruments TMP411'.=
..&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Texas
 Instruments TMP421'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for =
`Texas Instruments TMP422'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probin=
g for `Texas Instruments AMC6821'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probi=
ng for `National Semiconductor LM64'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `N=
ational Semiconductor LM73'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Maxim MAX6=
633/MAX6634/MAX6635'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Fintek F75121R/F75122R/RG (VI=
D+GPIO)'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for
 `Fintek F75111R/RG/N (GPIO)'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `IT=
E IT8201R/IT8203R/IT8206R/IT8266R'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Yes<BR>&nbsp;&nbsp;&nbsp; (confidence 6, not a hardware monitoring chi=
p)<BR>Client found at address 0x52<BR>Probing for `Analog Devices ADM1033'.=
..&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Analog D=
evices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probi=
ng for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Clie=
nt found at address 0x53<BR>Probing for `Analog Devices
 ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for=
 `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N=
o<BR>Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No</P>=0A<P>Now follows a summary of the probes I have just done.<BR>Just p=
ress ENTER to continue:</P>=0A<P>Driver `it87':<BR>&nbsp; * ISA bus, addres=
s 0x290<BR>&nbsp;&nbsp;&nbsp; Chip `ITE IT8720F Super IO Sensors' (confiden=
ce: 9)</P>=0A<P>Driver `coretemp':<BR>&nbsp; * Chip `Intel Core family ther=
mal sensor' (confidence: 9)</P>=0A<P>Do you want to overwrite /etc/sysconfi=
g/lm_sensors? (YES/no): yes<BR><STRONG><FONT color=3D#c00000>Copy prog/init=
/lm_sensors.init to /etc/init.d/lm_sensors<BR>for initialization at boot ti=
me.<BR></FONT></STRONG>You should now start the lm_sensors service to load =
the required<BR>kernel modules.</P>=0A<P>Unloading i2c-dev... OK<BR>Unloadi=
ng i2c-i801... OK</P>=0A<P>&nbsp;</P>=0A<DIV></DIV>=0A<DIV><FONT size=3D3 f=
ace=3D"tahoma, new york, times, serif">As you see, core-i7 is detected. Als=
o it says: "Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors<BR>for=
 initialization at boot time." I did that. </FONT></DIV>=0A<DIV><FONT size=
=3D3 face=3D"tahoma, new york, times, serif"></FONT>&nbsp;</DIV>=0A<DIV><FO=
NT size=3D3 face=3D"tahoma, new york, times, serif">Now shat should I do in=
 the next step? I don't want to reboot. What is the command to restart the =
service?</FONT><BR>&nbsp;</DIV>=0A<DIV>=0A<DIV><FONT style=3D"BACKGROUND-CO=
LOR: #ffffff" color=3D#0080ff size=3D2 face=3D"arial, helvetica, sans-serif=
"><STRONG>// Naderan *Mahmood;</STRONG></FONT></DIV></DIV>=0A<DIV><BR></DIV=
>=0A<DIV style=3D"FONT-FAMILY: Courier New, courier, monaco, monospace, san=
s-serif; FONT-SIZE: 10pt"><BR>=0A<DIV style=3D"FONT-FAMILY: tahoma, new yor=
k, times, serif; FONT-SIZE: 12pt"><FONT size=3D2 face=3DTahoma>=0A<HR SIZE=
=3D1>=0A<B><SPAN style=3D"FONT-WEIGHT: bold">From:</SPAN></B> Guenter Roeck=
 &lt;guenter.roeck@ericsson.com&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold"=
>To:</SPAN></B> Mahmood Naderan &lt;nt_mahmood@yahoo.com&gt;<BR><B><SPAN st=
yle=3D"FONT-WEIGHT: bold">Cc:</SPAN></B> lm-sensors &lt;lm-sensors@lm-senso=
rs.org&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Sent:</SPAN></B> Wed, Se=
ptember 1, 2010 8:22:03 PM<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Subject:=
</SPAN></B> Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<BR></=
FONT><BR>On Wed, Sep 01, 2010 at 10:58:47AM -0400, Mahmood Naderan wrote:<B=
R>&gt; &gt;The current text is quite absolute ("Copy prog/init/lm_sensors.i=
nit to /etc/init.d/lm_sensors")<BR>&gt; &gt;and really invites users to ove=
rwrite the distribution specific scripts.<BR>&gt; <BR>&gt; I really did tha=
t. See:<BR>&gt; <BR>[...]<BR><BR>&gt; Do you confirm that? What should I do=
 in order to remove lm-sensor and reinstall it again?<BR>&gt;
 <BR>Try<BR><BR>&nbsp;&nbsp;&nbsp; sudo aptitude reinstall lm-sensors<BR><B=
R>Guenter<BR></DIV></DIV></div><br>=0A=0A=0A=0A=0A=0A=0A=0A      </body></h=
tml>
--0-1378397757-1283360234=:16463--


--===============9106538354246706045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9106538354246706045==--
