From: Achim Gottinger <achim@ag-web.biz>
Date: Sun, 04 May 2008 16:49:57 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <481DE935.5010407@ag-web.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare schrieb:
> On Sun, 04 May 2008 15:23:23 +0200, achim wrote:
>  =20
>> The odd thing is the Sapphire board uses the same clock chip as the M3A
>> but does not show that chip at 0x69.
>>    =20
>
> Note that there's a chip at 0x70 on the Sapphire motherboard, I've
> already seen mux chips at this address.
You lost me here, :)
>  So maybe the clock chip at 0x69
> is there but on a branch of the mux which isn't currently active.
>
> As a side note, I think it would have been really great if whatever
> chip at 0x2e was behind a gate or mux so that it can't be accessed by
> default. This would have avoided all the trouble.
>  =20
>> Maybe it is the voltage regulator chip, on the M3A it's this one
>>
>> ISL6559
>> http://www.st.com/stonline/products/literature/ds/13605.pdf
>>    =20
>
> This one is using Send Byte, which is a write transaction that starts
> the same as a Read Byte transaction. sensors-detect would effectively
> write to this chips while probing it. To make things worse, it
> apparently acks all addresses from 0x60 to 0x6f. The good news is that
> senors-detect no longer probes these addresses, so we're safe.
>
> I can only imagine that whatever chip at 0x2e is causing trouble, it
> also uses Send Byte transactions. It will see basically random writes
> from the sensors-detect script, resulting in random VID codes and in
> turn random Vcore to be applied to the CPU. No good.
>
> Unfortunately it can't be helped. Such chips could live at virtually
> any address and be found on any motherboard, so the only safe solution
> would be to plain stop probing for chips on the SMBus.
>
>  =20
Thank you for the detailed explanation.

The M3A seems to have only the clock generator in that range at 0x69.=20
0x6e has turned out to be related to pcie.
0x2e and 0x4e are common between the DFI Lanparty NF4 and the Lanparty=20
UT 790X but the first one uses
an analouge pwm and the second one an digital one, which does not need=20
an voltage gereator chip i guess.

I found one additional thing at 0x4e. When I put in the phenom 0x02 and=20
0x04 readings both change from 0x00 to 0x05. The rest stays the same.=20
The output of 0x38 and 0x6e did not change after switching the cpu's.

The M2A-VM (690G chipset) only shows an chip at 0x69 whom i was able to=20
get a dump from. It's also a clock generator chip and the output changes=20
if i change the ref HT from 200MHz to 201MHz. In opposite to the clock=20
generators on the 0x7xx chipsets this board has no chip at 0x38. So I'm=20
unsure now if the chip at 0x38 can also be associated to the clock=20
generator.
>> on the GBt board it's a ISL6323
>> http://www.intersil.com/data/fn/fn9278.pdf
>>    =20
>
>  =20
> Starting with i2c-tools version 3.0.1, you can provide a range or
> registers to read from, with -r. If you choose -r 0-0x9d, I guess you
> will avoid the lockup.
>  =20
Thanks, i'll reinspect that register.
>  =20
>> I found the part number of chip number four. :)
>> It's an ICS9DB403DGLF
>>
>> http://www.idt.com/?genID=9DB403
>>
>> I just skimmed over the specs, that chip is related to the pcie and has
>> an smbus interface.
>>    =20
>
> And lives at address 0x6e.
>  =20
Great one unknown chip sorted out. :)
>  =20
>> How did you find out the address of the 690G clock chips by looking at
>> the specs?
>>    =20
>
> Search for "slave address". The datasheet says it sends byte D2 to
> write to slave and D3 to read from it. The address byte is the 7-bit
> slave address + 1 read/write bit (0 for write, 1 for read). So you get
> the slave address by shifting address byte by 1 to the right (i.e.
> dividing it by 2): 0xD2/2 =3D 0x69.
>  =20
So in theory it might be possible to change for example the ref HT speed=20
by writing to 0x68? Is there a project alive utilising those clock=20
generator chips under linux?
For monitoring purpose an module which reads the ref HT and PCIe bus=20
speeds might be interesting. I think about trying to write one. :)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
