From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 17 Oct 2007 02:33:54 +0000
Subject: Re: [lm-sensors] Compaq EVO W8000 Sensor/Chip Support
Message-Id: <191fb4ca0710161933r12013034x5a4450ca735d20c5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1192538331.4059.17.camel@tiger.atd.ucar.edu>
In-Reply-To: <1192538331.4059.17.camel@tiger.atd.ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Keith,


On 10/16/07, KEITH ROMBERG <k_romberg@msn.com> wrote:
> OK, I have now installed the latest version of lm_sensors 2.10.4.  Here is
> the snip from sensors-detect:
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found `SMSC LPC47B357 Super IO'
>     (no information available)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
>
> Now i ran the prog/hotplug/unhide_ICH_SMBus and here is the output:
>
> Enabling SMBus PCI device ...
> Rescanning the bus ...
> Loading i2c-i801 ...
> 00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 04)
> Done!
> Remember: system suspend/resume is no longer safe to use.
>
> I do not suspend and/or resume the machine, so I guess things will be
> OK......

Hmm... Don't count on it. I'm not sure how safe it is to unhide things...


> Rerunning sensors-detect found everything :)
>
> [root@scatha lm_sensors-2.10.4]# sensors
> adm1023-i2c-0-18
> Adapter: SMBus I801 adapter at fc00
> Board Temp:
>              +43=B0C  (low  =3D   -55=B0C, high =3D  +127=B0C)
> CPU Temp:    +47=B0C  (low  =3D   -55=B0C, high =3D   +61=B0C)
>
> adm1023-i2c-0-4c
> Adapter: SMBus I801 adapter at fc00
> Board Temp:
>              +42=B0C  (low  =3D   -55=B0C, high =3D  +127=B0C)
> CPU Temp:    +48=B0C  (low  =3D   -55=B0C, high =3D   +61=B0C)
>
> Thanks for your help Juergh!!!  Once again you helped out.  Last time was
> the IPMI sensors on my Intel SHSR server.

You're welcome. That's what we're here for :-) But now I'm curious
about the Super-I/O, I'll go ahead and ask SMSC for documentation.

...juerg


> Keith
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
