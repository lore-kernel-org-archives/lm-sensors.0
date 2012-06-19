From: Graham Medlin <glmedlin@ncsu.edu>
Date: Tue, 19 Jun 2012 21:45:01 +0000
Subject: Re: [lm-sensors] No sensors detected PE600SC
Message-Id: <CALK30xCN0BXuHW3iYnSHwYUqEDUwEx7STdysxLbL69s=y-=WtQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALK30xCab=jL+AuL=_y3QV0deW9U5HtB_ZoEK0NDTVe0fSZLTg@mail.gmail.com>
In-Reply-To: <CALK30xCab=jL+AuL=_y3QV0deW9U5HtB_ZoEK0NDTVe0fSZLTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Success! Thanks Jean!

To follow-up...

The kernal is 3.2.0-25-generic-pae

Sorry, I had also tried adding force=3D1, did not help
     $ modprobe i2c-piix4 force=3D1

i2c-dev was loaded, but I removed, added back, and sensors-detect
finds and installs the drivers for the two mentioned chips! "sensors"
returns lots of useful info.

Looking at the kernel log, previous times I tried to load i2c-piix4 left:
     Jun 19 15:24:20 ucns kernel: [   14.712714] lp: driver loaded but
no devices found
     Jun 19 15:24:20 ucns kernel: [   14.885674] EXT4-fs (sda1):
re-mounted. Opts: errors=3Dremount-ro
     Jun 19 15:24:20 ucns kernel: [   15.263957] piix4_smbus
0000:00:0f.0: Host SMBus controller not enabled!

However this time I see:
     Jun 19 17:25:53 ucns kernel: [ 7307.624856] piix4_smbus
0000:00:0f.0: WARNING: SMBus interface has been FORCEFULLY ENABLED!
     Jun 19 17:25:53 ucns kernel: [ 7307.624866] piix4_smbus
0000:00:0f.0: SMBus Host Controller at 0x580, revision 0


On Tue, Jun 19, 2012 at 4:47 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Tue, 19 Jun 2012 15:46:48 -0400, Graham Medlin wrote:
>> Have a Dell PowerEdge 600sc running Ubuntu 12.04 Server. Hate to
>
> Which kernel is that?
>
>> retire the golden egg laying goose, its solid. The fan is running at
>> 100%, sounds like a 747, so I wanted to check it with lm_sensors...
>>
>> Running "sensors-detect" yields no for everything except:
>> =A0 =A0 =A0...
>> =A0 =A0 =A0Do you want to scan for Super I/O sensors? (YES/no): y
>> =A0 =A0 =A0Probing for Super-I/O at 0x2e/0x2f
>> =A0 =A0 =A0Trying family `National Semiconductor/ITE'... =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Yes
>> =A0 =A0 =A0Found `Nat. Semi. PC8741x Super IO'
>> =A0 =A0 =A0 =A0 =A0(no hardware monitoring capabilities)
>> =A0 =A0 =A0...
>> =A0 =A0 =A0...
>> =A0 =A0 =A0Do you want to probe the I2C/SMBus adapters now? (YES/no): y
>> =A0 =A0 =A0Using driver `i2c-piix4' for device 0000:00:0f.0: ServerWorks
>> CSB6 South Bridge
>> =A0 =A0 =A0Sorry, no sensors were detected.
>> =A0 =A0 =A0...
>>
>> The CSB6 bus is listed as supported, but I haven't been able to track
>> down what the sensors are.
>
> This chip is how you may be able to access sensor chips, it is not a
> sensor chip itself.
>
>> Back when this was a Windows machine, I ran Everest Home, and it was
>> able to read everything, and claimed LM81 =A0 =A0 and MAX1617A chips for
>> whatever its worth...
>
> Good news is that both are supported under Linux, so if that's really
> what your system has, there is hope.
>
>> Googling found exactly one reference claiming this was possible on a
>> linux machine:
>> =A0 =A0 =A0http://lists.us.dell.com/pipermail/linux-poweredge/2005-July/=
021985.html
>
> This is a pretty old post, not sure everything said there still applies.
>
>>
>> I tried with no luck:
>> =A0 =A0 =A0modprobe -r i2c-piix4
>> =A0 =A0 =A0modprobe i2c-piix4
>
> The post said to pass force=3D1, but you did not.
>
>> I'm not sure if its related, but "i2cdetect -l" returns nothing.
>
> Do you have i2c-dev loaded? i2cdetect won't work without it. If you do
> and "i2cdetect -l" still doesn't list the SMBus, please check the
> kernel log when you try to (re)load i2c-piix4.
>
>> Below is part of the output of "lspci -nn -vv"
>> =A0 =A0 =A000:0f.0 Host bridge [0600]: Broadcom CSB6 South Bridge [1166:=
0203] (rev a0)
>> =A0 =A0 =A0 =A0 =A0 Subsystem: Broadcom Device [1166:0201]
>> =A0 =A0 =A0 =A0 =A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VG=
ASnoop-
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>> =A0 =A0 =A0 =A0 =A0 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dm=
edium
>> >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
>> =A0 =A0 =A0 =A0 =A0 Latency: 32
>> =A0 =A0 =A0 =A0 =A0 Kernel modules: i2c-piix4, sworks-agp
>
> Two drivers for the same device, looks wrong. You should try getting
> rid of (via blacklisting) sworks-agp and see if it helps any.
>
> --
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
