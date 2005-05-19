From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: Supporting Hardware monitor for VIA chipsets
Message-Id: <3CEE9C75.9020003@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <369B0912E1F5D511ACA5003048222B7555BBFE@EXCHANGE2>
In-Reply-To: <369B0912E1F5D511ACA5003048222B7555BBFE@EXCHANGE2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

anybody want the 8231 board?
It looks like all it takes for 8231 support is adding the PCI ID
to i2c-viapro, via686a, and sensors-detect...

JH Tseng wrote:
> Hi,
> 
> Attached file is the 686B/8231/8233/8233A datasheet. Basically, it should be
> the same as 686A. For i2c bus/SMBus, the register set for 8233(A) and 8231
> are the same except that the IO Base address location. I will prepare the
> motherboards based on 8231 first for your need.  Could you tell me about
> your address ??
> Here is a question about your package. If the sensor chip is a I/O device,
> then in order to get the hardware monitor component's infor, the i2c bus
> driver need to be loaded ??
> If you need any support, please feel free to contact me! thanks!
> 
> 
> JH
> 
> -----Original Message-----
> From: Mark Studebaker [mailto:mds@paradyne.com]
> Sent: Thursday, May 23, 2002 2:06 AM
> To: JH Tseng
> Cc: 'sensors@stimpy.netroedge.com'
> Subject: Re: Supporting Hardware monitor for VIA chipsets
> 
> 
> Oops, I misspoke.
> We do _not_ support the 8231 i2c bus.
> We do support 8233 and 8233A i2c busses.
> 
> Mark Studebaker wrote:
> 
>>Latest datasheets would be _greatly_ appreciated.
>>As many chips are quite similar, there often is not much programming,
>>we just need the datasheets.
>>We also need a 686B datasheet.
>>Of course if you are willing to donate motherboards please let us know,
>>that will help us quite a bit.
>>
>>We do support the 8231, 8233, and 8233A i2c drivers,
>>but not their integrated sensors (if any).
>>The latest information on driver support is here
>>
>>http://www2.lm-sensors.nu/~lm78/newdrivers.html
>>
>>thanks very much for your interest.
>>mds
>>
>>phil@netroedge.com wrote:
>>
>>>Hi, thanks for the email.  Right now, I think we support the
>>>VT8233(A), but not yet the VT8231 nor the VT8235.  We could use your
>>>help to get drivers written.  If you can, we'd appreciate you
>>>submitting bus drivers (see kernel/busses/i2c-* for examples) to
>>>integrate into the project.  We might also be able to find a developer
>>>to help out, but we seem to be a bit thin with programmers right now.
>>>
>>>Thanks!
>>>
>>>Phil
>>>
>>>On Tue, May 21, 2002 at 05:50:03PM +0800, JH Tseng wrote:
>>>
>>>>Hi Sir,
>>>>
>>>>I am a software engineer in VIA Tech Inc. According to the status
>>>
> report in
> 
>>>>your web site, we find that there are not the sensor chip drivers for
>>>
> latest
> 
>>>>VIA south bridges such as the VT8231, VT8233(A) and VT8235. Therefore,
>>>
> I
> 
>>>>need your help or I can provide some HWs and information to you to
>>>>co-develope/co-test the hardware monitor based on the VIA platform. I
>>>
> deeply
> 
>>>>appreciate you very much if you have any input.
>>>>
>>>>Best regards
>>>>
>>>>JH
>>>
>>>--
>>>Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>>>   phil@netroedge.com -- http://www.netroedge.com/~phil
>>> PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
>>


