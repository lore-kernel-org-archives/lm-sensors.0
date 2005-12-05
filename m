From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 05 Dec 2005 08:19:55 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <4393E9DD.5040500@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Yuan,

Please can you help (and new datasheet would be nice too :) ?
I'm afraid that I cant move any further without your help.

Thanks
Regards
Rudolf

Daniel Nilsson wrote:
> Hi Rudolf,
> 
> On Wed, Nov 30, 2005 at 11:11:00PM +0100, Rudolf Marek wrote:
> 
>>Never give up, never surrender :) Lets focus on SMI. This should disable
>>the SMI from this chip. So we can at least eliminate this source.
>>OVT# is also unused so this should point if you have HW or SW (bus driver)
>>problem.
> 
> 
> That's the spirit :-)
> 
> 
>>Please can you try with this sequence, which is same except of new first
>>line.
>>
>>Quoting Jean:
>>
>>You can use the i2cset program to write to the W83792D chip directly. You
>>can try using the following commands in your script, without loading the
>>w83792d driver. Let us know if it hangs of not.
>>
>>i2cset -y 0 0x2c 0x40 0x1  # DISABLE SMI
>>i2cset -y 0 0x2c 0x2b 0xff # in0_max
>>... 
>>This should completly disable the SMI.	Lets see how it works :)
> 
> 
> Ok, I've tried this and a few other things. First of all, I can't shut
> off SMI which seems really odd.
> 
> The first time a ran this sequence I got this result and the machine
> did not hang:
> 
> oden:~# ./set_safe_direct_wo_smi.sh
> + i2cset -y 0 0x2c 0x40 0x1
> No size specified (using byte-data access)
> Warning - data mismatch - wrote 0x01, read back 0x06
> + i2cset -y 0 0x2c 0x2b 0xff
> No size specified (using byte-data access)
> Value 0xff written, readback matched
> + i2cset -y 0 0x2c 0x2c 0x00
> [all the remaining writes succeeded]
> 
> The second time I got this result and the machine did still not hang:
> 
> oden:~# ./set_safe_direct_wo_smi.sh
> + i2cset -y 0 0x2c 0x40 0x1
> No size specified (using byte-data access)
> Warning - data mismatch - wrote 0x01, read back 0x03
> + i2cset -y 0 0x2c 0x2b 0xff
> No size specified (using byte-data access)
> Value 0xff written, readback matched
> + i2cset -y 0 0x2c 0x2c 0x00
> [all the remaining writes succeeded]
> 
> Finally the third time the machine just got this far and then hung:
> 
> oden:~# ./set_safe_direct_wo_smi.sh
> + i2cset -y 0 0x2c 0x40 0x1
> No size specified (using byte-data access)
> 
> 
> So according to the datasheet writing 0x01 to this register should
> shut off EN_SMI, but that doesn't seem to work since the readback
> still shows 0x03 (should be 0x01, right?). I've been trying all sorts
> of things to disable this EN_SMI bit but I can't seem to do it.
> 
> For example, writing 0x80 should re-init the whole chip:
> 
> oden:~# i2cset -y 0 0x2c 0x40 0x80
> No size specified (using byte-data access)
> Warning - data mismatch - wrote 0x80, read back 0x03
> 
> But that still has the EN_SMI bit set??? It shouldn't according to my
> datasheet at least, that bit should be reset to '0'...
> 
> I've also played around in the BIOS for a while, there seems to be
> some king of "MiniBMC" functionality in the BIOS that is logging
> overtemp events someplace. That log was filled with events since BIOS
> enabled all fan monitors by default. I've shut off all those monitors
> and even the whole MiniBMC funtionality but I still get the same hangs
> when writing the sensor limits. I honestly don't know if there is some
> other device on this bus that is communicating with the w82792d chip
> to read these levels as well that might be interfering here. Since
> this MiniBMC thing might be of interest I actually wrote Gigabyte
> support about this whole issue, I'm keeping my fingers crossed but I
> doubt that the question will reach the appropriate people at Gigabyte.
> 
> One more thing I observed;
> 
> oden:~# i2cdump -y 0 0x2c
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 64 64 bf 00 00 63 00 ff 00 00 f5 00 8f 80    ..dd?..c....?.??
> 20: d3 d4 b9 b9 b8 b8 cd 15 ff ff ff ff 00 96 64 d7    ????????.....?d?
> 30: af d9 b1 d9 b1 d7 af ff 00 25 00 f0 f0 f0 2f 39    ???????..%.???/9
> 40: 03 00 00 00 00 ff ff 11 2c 13 40 c3 51 ff 80 5c    ?......?,?@?Q.?\
> 50: ff ff ff ff ff ff ff ff 7a 60 ff 11 11 c1 05 7f    ........z`.?????
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: 01 8f 01 8f 00 00 00 00 11 11 ff ff 3c 3c 0a 0a    ????....??..<<??
> 90: 00 00 00 01 8f ff 00 00 11 ff 3c 00 00 01 01 ff    ...??...?.<..??.
> a0: 01 01 01 8f 8f 8f 8f ff 3e e2 00 e0 ff ff 00 00    ???????.>?.?....
> b0: d3 cb ff ff ff 00 e2 b9 ff ff ff f0 f0 f0 ff ff    ??....??...???..
> c0: f2 80 02 39 00 3c 00 ff 2c 00 00 5d 00 60 00 ff    ???9.<..,..].`..
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: 8b 8b 8b 28 3c 50 28 3c 50 28 3c 50 ff ff ff ff    ???(<P(<P(<P....
> f0: ff ff 80 ff 00 01 00 00 ff 02 ff 00 00 00 00 ff    ..?..?...?......
> 
> Look at index 49, it says "13". According to the datasheet I have a
> revision C chip should have "12". Is this a newer chip then what the
> datasheet covers? In this case there might be some confusion on
> disabling SMI...
> 
> Yuan, could you offer some help and guidance as to why the EN_SMI bit
> can't be turned off and what this revision "13" chip is? My
> motherboard is a Gigabyte GA-4MXSV by the way.
> 
> Regards
