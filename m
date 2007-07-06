From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 06 Jul 2007 15:52:41 +0000
Subject: Re: [lm-sensors] Sensors working on DL360?
Message-Id: <191fb4ca0707060852wd1b2a7r9bbd203b6084ef58@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <57849.83.87.167.242.1183707511.squirrel@webmail4.transip.nl>
In-Reply-To: <57849.83.87.167.242.1183707511.squirrel@webmail4.transip.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bart,

Please post the output of lspci. Also, use the SVN version of
sensors-detect and post that output too. Your server most likely
requires the ipmisensors driver which the SVN version of
sensors-detect should correctly identify.

Regards
...juerg


On 7/6/07, Bart van Kuik <lmsensors@vankuik.nl> wrote:
> Hi list,
>
> I'm trying to get sensor readouts on a Compaq DL360 (not the later HP
> branded ones, but the series with a Pentium 3). sensors-detect didn't
> return any possible chipsets, but if you're interested, here's the output:
>
>  http://www.vankuik.nl/download/Compaq_sensors-detect_readout
>
> Output of lspci -v -v gives:
>
>  00:04.0 System peripheral: Compaq Computer Corporation Advanced System
>          Management Controller
>          Subsystem: Compaq Computer Corporation Unknown device b0f3
>          Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
>                   ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>                  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>          Interrupt: pin A routed to IRQ 255
>          Region 0: I/O ports at 1800 [disabled] [size%6]
>          Region 1: Memory at c3ffef00 (32-bit, non-prefetchable) [size%6]
>
> Output of ls-pci -n gives for this peripheral:
>  00:04.0 0880: 0e11:a0f0
>
> I've found references to a "Compaq health & Welness driver" but it's
> binary and very old (pre 2.6). I'm running CentOS 5 (i.e. a RedHat AS
> clone), kernel version 2.6.18 and lm_sensors 2.10.
>
> Has anyone gotten this working?
>
> Thanks,
> Bart
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
