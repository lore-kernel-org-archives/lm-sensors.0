From: juergh@gmail.com (Juerg Haefliger)
Date: Fri, 22 Dec 2006 22:11:40 +0000
Subject: [lm-sensors] HP Compaq ProLiant DL380 detect failure
Message-Id: <191fb4ca0612221411s729e744ej2e2745988e1931c6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4568C502.6070305@lymenet.org>
In-Reply-To: <4568C502.6070305@lymenet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well, I happen to work for HP, different organization though. But
we're about to be using the DL385 out of ISS to integrate into our
product line. We'll be running Debian and we need to be able to read
temp and fan information but we'll rely on hp tools to get there (not
my choice). Anyways, we might have a business need to get the source
and I might be able to pass some information along. No promise though
since we're pretty uptight about those things (not my choice either).

Anyways, let me know what you want to know and I'll see what I can do...

...juerg



On 12/22/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Thomas,
>
> On Sat, 25 Nov 2006 17:34:42 -0500, Thomas Brown wrote:
> > Anyone have any luck getting lm_sensors to work with the HP/Compaq
> > ProLiant DL series (i.e. DL380)?  With the latest 'sensors-detect'
> > script I get "Sorry, no sensors were detected."
> >
> > Here is some data for your perusal:
> >
> >
> > dmesg output:
> > piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
> > piix4_smbus 0000:00:0f.0: SMB base address uninitialized - upgrade BIOS
> > or use force_addr=0xaddr
>
> This is a fatal error. If there are sensor chips connected to the
> SMBus, you cannot reach them until the SMBus itself works. Try
> upgrading the BIOS as suggested. Or try using force_addr as instructed,
> just make sure you pick an unused I/O area (check in /proc/ioports.)
>
> But it is also possible that the sensor chips are hidden elsewhere, and
> the SMBus isn't used, and that's why it is disabled. I can't tell.
> You'd need to ask the manufacturer for technical information.
>
> > HP has a utility to read data from the Internal Lights Out Management board:
> > # hplog -t
> > ID     TYPE        LOCATION      STATUS    CURRENT  THRESHOLD
> >  1  ADM1022      Processor Zone  Nominal  113F/ 45C 143F/ 62C
> >  2  ADM1022      CPU (1)         Nominal  113F/ 45C 156F/ 69C
> >  3  ADM1022      I/O Zone        Nominal  113F/ 45C 145F/ 63C
> >  4  ADM1022      CPU (2)         Nominal  111F/ 44C 156F/ 69C
> >  5  ADM1022      Pwr. Supply Bay Nominal  100F/ 38C 129F/ 54C
>
> The driver for the ADM1022 (thmc50) wasn't ported to Linux 2.6 yet,
> only Linux 2.4 is supported. Not that it really matters until you can
> actually reach these chips.
>
> >
> > # hplog -f
> > ID     TYPE        LOCATION      STATUS  REDUNDANT FAN SPEED
> >  1  Var. Speed   Processor Zone  Nominal    Yes     Low    ( 10)
> >  2  Var. Speed   Processor Zone  Nominal    Yes     Low    ( 10)
> >  3  Var. Speed   I/O Zone        Nominal    Yes     Low    ( 20)
> >  4  Var. Speed   I/O Zone        Nominal    Yes     Low    ( 20)
> >  5  Var. Speed   Processor Zone  Nominal    Yes     Low    ( 10)
> >  6  Var. Speed   Processor Zone  Nominal    Yes     Low    ( 10)
> >  7  Var. Speed   Pwr. Supply Bay Nominal    Yes     Low    ( 20)
> >  8  Var. Speed   Pwr. Supply Bay Nominal    Yes     Low    ( 20)
> >
> > # hplog -p
> > ID     TYPE        LOCATION      STATUS  REDUNDANT
> >  1  Standard     Pwr. Supply Bay Nominal    No
> >  2  Standard     Pwr. Supply Bay Absent     No
>
> Do you have the source code of that tool? If you do, just check where
> it gets the information from.
>
> I also invite you to bug HP themselves about it. Ask them why
> lm_sensors doesn't work with their hardware, see what they answer.
>
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

