From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 30 Jan 2014 04:31:19 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <52E9D597.4000201@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 01/29/2014 07:39 PM, Alun Evans wrote:
>
> On 29 Jan 2014, at 17:42, Guenter Roeck <linux@roeck-us.net> wrote:
>
>> On Wed, Jan 29, 2014 at 05:30:14PM -0800, Guenter Roeck wrote:
>>> On Wed, Jan 29, 2014 at 05:12:48PM -0800, Alun Evans wrote:
>>>>
>>>> On 29 Jan 2014, at 11:48, Alun Evans <alun@badgerous.net> wrote:
>>>>
>>>>> Thanks for the responses everyone, inline,
>>>>>
>>>>> On 29 Jan 2014, at 10:25, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>>> On Wed, Jan 29, 2014 at 05:42:24PM +0100, Jean Delvare wrote:
>>>>>>> Hi Alun,
>>>>>>> <snip>
>>>>>>
>>>>>>> Please ask Supermicro about it.
>>>>>
>>>>> I have put a request in=85 We=92ll see if I get a response.
>>>>>
>>>>>>> If the memory slots are behind an I2C
>>>>>>> multiplexer, ask them if the multiplexer is I2C-based or GPIO-based=
. If
>>>>>>> I2C-based, ask for the multiplexer type and address. If GPIO-based,=
 ask
>>>>>>> for the chip name and pin numbers for the GPIOs. In both case, plea=
se
>>>>>>> ask which GPIO combinations map to which memory slots.
>>>>
>>>> I inlined the above hunk with my question, and the first response was:
>>>>
>>>>> Received feedback; The memory address does not use mux.  It is hardwa=
re defined by Intel.
>>>>
>>>> So I went and clarified I was not talking about the DDR physical addre=
ss setup by the memory reference code, and I got:
>>>>
>>>>> Per our engineer; There is no hardware connecting to DIMM.
>>>>
>>>> I=92m not sure I=92ve found the right help here...
>>>>
>>> Actually you might have. On some HW the DIMMs are connceted to a separa=
te
>>> SMBus channel which is not visible to SW.
>>>
>> I had a quick glance into the Patsburg (c600) datasheet. The chip has
>> up to four SMBus channels, depending on chip variant. Are you sure
>> that you are talking to the correct one ? What do you see with lspci ?
>
> I am talking to that one:
>
> $ sudo lspci -v -v -v -s 0000:00:1f.3
> 00:1f.3 SMBus: Intel Corporation C600/X79 series chipset SMBus Host Contr=
oller (rev 05)
>          Subsystem: Super Micro Computer Inc Device 0661
>          Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Interrupt: pin C routed to IRQ 18
>          Region 0: Memory at fba20000 (64-bit, non-prefetchable) [size=3D=
256]
>          Region 4: I/O ports at 1180 [size=3D32]
>          Kernel driver in use: i801_smbus
>          Kernel modules: i2c-i801
>
Anything else that looks like an SMBus controller ? The datasheet says that=
 "SRV/WS SKUs Only"
would have additional SMBus controllers.

> Whether or not the DIMMs are connected to it is a good question.
>
> It=92s a C602:
> http://www.supermicro.com/products/motherboard/xeon/c600/x9srg-f.cfm
>

>
> Thinking about it, this Xeon has an integrated memory controller with 4 D=
DR3 channels, each of which can have 3 DIMMs per channel. That=92s potentia=
lly 12 DIMMs on a board, which exceeds the 8 addressable SPDs given the 3 p=
ins for addressing (SA{0-2}). While this board only has 8 DIMMs, it would m=
ake some sense if they were split in half with a mux somewhere.
>

Presumably there must be a means for the BIOS to read the SPD data to be ab=
le to
program the DRAM controller correctly. No idea how that works in detail, th=
ough.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
