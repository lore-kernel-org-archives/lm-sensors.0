From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 19 Dec 2007 22:04:44 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0712191404g52b76d8bt47fc1194223d946e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Werner,

On Dec 19, 2007 1:26 PM, Werner Goebl <werner.goebl@mail.mcgill.ca> wrote:
>
> > That looks promising so far. Now can you run a cpu stress test like
> > cpuburn and take a couple of register dumps so that we can see which
> > register values change over time while the CPU is heating up?
> >
> > ...juerg
> >
> >
> Hi Juerg,
>
> so I documented the command: sudo isadump -f 0xc00 for core
> temperatures from 44 to 52 degrees.
>
> Greetings
> Werner
>
> idle...
>
> [sudo] password for werner:
> WARNING! Running this program can cause system crashes, data loss
> and worse!
> I will probe address range 0xc00 to 0xcff.
> Continue? [Y/n]
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0c00: 00 00 01 00 18 00 60 08 00 00 00 00 00 00 00 00
> 0c10: 02 00 60 08 00 00 40 40 00 00 00 00 00 00 03 02
> 0c20: 00 00 00 05 05 00 05 84 05 00 00 80 01 01 01 00
> 0c30: 05 05 00 01 05 01 05 00 09 84 84 04 04 08 00 05
> 0c40: 05 05 04 05 04 05 04 86 86 00 00 2b 67 2f 00 57
> 0c50: 00 e1 00 04 00 00 04 04 84 01 01 04 04 00 0f 00
> 0c60: 00 01 00 06 00 c0 00 03 00 e0 00 00 00 00 00 00
> 0c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cf0: ff ff ff ff ff ff ff ff ff 00 ff ff b9 ec 00 00
>
>
> Dellibes:~> sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +44=B0C  (high =3D  +100=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +45=B0C  (high =3D  +100=B0C)
>
> Dellibes:~> sudo isadump -f 0xc00
> WARNING! Running this program can cause system crashes, data loss
> and worse!
> I will probe address range 0xc00 to 0xcff.
> Continue? [Y/n]
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0c00: 00 00 01 00 18 00 60 08 00 00 00 00 00 00 00 00
> 0c10: 02 00 60 08 00 00 40 40 00 00 00 00 00 00 03 02
> 0c20: 00 00 00 05 05 00 05 84 05 00 00 80 01 01 01 00
> 0c30: 05 05 00 01 05 01 05 00 09 84 84 04 04 08 00 05
> 0c40: 05 05 04 05 04 05 04 86 86 00 00 2b 67 2f 00 57
> 0c50: 00 e1 00 04 00 00 04 04 84 01 01 04 04 00 0f 00
> 0c60: 00 01 00 06 00 c0 00 03 00 e0 00 00 00 00 00 00
> 0c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cf0: ff ff ff ff ff ff ff ff ff 00 ff ff b9 ec 00 00
>
>
> Dellibes:~> sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +45=B0C  (high =3D  +100=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +47=B0C  (high =3D  +100=B0C)
>
> Dellibes:~> sudo isadump -f 0xc00
> WARNING! Running this program can cause system crashes, data loss
> and worse!
> I will probe address range 0xc00 to 0xcff.
> Continue? [Y/n]
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0c00: 00 00 01 00 18 00 60 08 00 00 00 00 00 00 00 00
> 0c10: 02 00 60 08 00 00 40 40 00 00 00 00 00 00 03 02
> 0c20: 00 00 00 05 05 00 05 84 05 00 00 80 01 01 01 00
> 0c30: 05 05 00 01 05 01 05 00 09 84 84 04 04 08 00 05
> 0c40: 05 05 04 05 04 05 04 86 86 00 00 2b 67 2f 00 57
> 0c50: 00 e1 00 04 00 00 04 04 84 01 01 04 04 00 0f 00
> 0c60: 00 01 00 06 00 c0 00 03 00 e0 00 00 00 00 00 00
> 0c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cf0: ff ff ff ff ff ff ff ff ff 00 ff ff b9 ec 00 00
>
> Dellibes:~> sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +46=B0C  (high =3D  +100=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +48=B0C  (high =3D  +100=B0C)
>
> Dellibes:~> sudo isadump -f 0xc00
> WARNING! Running this program can cause system crashes, data loss
> and worse!
> I will probe address range 0xc00 to 0xcff.
> Continue? [Y/n]
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0c00: 00 00 01 00 18 00 60 08 00 00 00 00 00 00 00 00
> 0c10: 02 00 60 08 00 00 40 40 00 00 00 00 00 00 03 02
> 0c20: 00 00 00 05 05 00 05 84 05 00 00 80 01 01 01 00
> 0c30: 05 05 00 01 05 01 05 00 09 84 84 04 04 08 00 05
> 0c40: 05 05 04 05 04 05 04 86 86 00 00 2b 67 2f 00 57
> 0c50: 00 e1 00 04 00 00 04 04 84 01 01 04 04 00 0f 00
> 0c60: 00 01 00 06 00 c0 00 03 00 e0 00 00 00 00 00 00
> 0c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cf0: ff ff ff ff ff ff ff ff ff 00 ff ff b9 ec 00 00
>
> Dellibes:~> sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +47=B0C  (high =3D  +100=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +49=B0C  (high =3D  +100=B0C)
>
> Dellibes:~> sudo isadump -f 0xc00
> WARNING! Running this program can cause system crashes, data loss
> and worse!
> I will probe address range 0xc00 to 0xcff.
> Continue? [Y/n]
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0c00: 00 00 01 00 18 00 60 08 00 00 00 00 00 00 00 00
> 0c10: 02 00 60 08 00 00 40 40 00 00 00 00 00 00 03 02
> 0c20: 00 00 00 05 05 00 05 84 05 00 00 80 01 01 01 00
> 0c30: 05 05 00 01 05 01 05 00 09 84 84 04 04 08 00 05
> 0c40: 05 05 04 05 04 05 04 86 86 00 00 2b 67 2f 00 57
> 0c50: 00 e1 00 04 00 00 04 04 84 01 01 04 04 00 0f 00
> 0c60: 00 01 00 06 00 c0 00 03 00 e0 00 00 00 00 00 00
> 0c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cf0: ff ff ff ff ff ff ff ff ff 00 ff ff b9 ec 00 00
>
>
> Dellibes:~> sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +48=B0C  (high =3D  +100=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +50=B0C  (high =3D  +100=B0C)
>
> Dellibes:~> sudo isadump -f 0xc00
> WARNING! Running this program can cause system crashes, data loss
> and worse!
> I will probe address range 0xc00 to 0xcff.
> Continue? [Y/n]
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0c00: 00 00 01 00 18 00 60 08 00 00 00 00 00 00 00 00
> 0c10: 02 00 60 08 00 00 40 40 00 00 00 00 00 00 03 02
> 0c20: 00 00 00 05 05 00 05 84 05 00 00 80 01 01 01 00
> 0c30: 05 05 00 01 05 01 05 00 09 84 84 04 04 08 00 05
> 0c40: 05 05 04 05 04 05 04 86 86 00 00 2b 67 2f 00 57
> 0c50: 00 e1 00 04 00 00 04 04 84 01 01 04 04 00 0f 00
> 0c60: 00 01 00 06 00 c0 00 03 00 e0 00 00 00 00 00 00
> 0c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cf0: ff ff ff ff ff ff ff ff ff 00 ff ff b9 ec 00 00
>
>
>
>
> Dellibes:~> sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +50=B0C  (high =3D  +100=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +52=B0C  (high =3D  +100=B0C)
>
> Dellibes:~> sudo isadump -f 0xc00
>
> WARNING! Running this program can cause system crashes, data loss
> and worse!
> I will probe address range 0xc00 to 0xcff.
> Continue? [Y/n]
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0c00: 00 00 01 00 18 00 60 08 00 00 00 00 00 00 00 00
> 0c10: 02 00 60 08 00 00 40 40 00 00 00 00 00 00 03 02
> 0c20: 00 00 00 05 05 00 05 84 05 00 00 80 01 01 01 00
> 0c30: 05 05 00 01 05 01 05 00 09 84 84 04 04 08 00 05
> 0c40: 05 05 04 05 04 05 04 86 86 00 00 2b 67 2f 00 57
> 0c50: 00 e1 00 04 00 00 04 04 84 01 01 04 04 00 0f 00
> 0c60: 00 01 00 06 00 c0 00 03 00 e0 00 00 00 00 00 00
> 0c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cf0: ff ff ff ff ff ff ff ff ff 00 ff ff b9 ec 00 00

Shoot, the register values didn't change. So we're looking at the
wrong thing here. Darn...

Please run 'isadump -k 0x55 0x2e 0x2f 0x8' and 'isadump -k 0x55 0x2e
0x2f 0x9' and post the output. We have to look at a different logical
device.
And please also post the output of 'lspci -vv -nn' and the full output
of 'sensors-detect'.

...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
