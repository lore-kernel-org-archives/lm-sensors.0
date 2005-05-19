From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: Problem with eeprom module in 2.9.0
Message-Id: <41FBE04E.7040009@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DDAE4F.9030606@earthlink.net>
In-Reply-To: <41DDAE4F.9030606@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for working on this
(amazing what you can accomplish with two scope probes, huh?)
you're right about the bit0 and the DAT1 changes.

Is the done bit set for all but the last byte,
or does it never set it?
If it's all but the last one, I don't think it's in E32B mode...
maybe just a quirk of i2c read.
Also may depend on whether slave stops the transfer or the
host reads a full 32 bytes...


Mark M. Hoffman wrote:
> Hi again:
> 
> 
>>* Mark D. Studebaker <mds4@verizon.net> [2005-01-22 11:54:37 -0500]:
>>
>>>good diagnosis khali.
>>>the 6300ESB definitely supports i2c block so there must be a bug in there 
>>>somewhere.
>>>I just reviewed the code and didn't see anything obvious.
>>>David can you recompile i2c-i801 with the DEBUG=1 uncommented and
>>>send us the dmesg output?
> 
> 
> * Mark M. Hoffman <mhoffman@lightlink.com> [2005-01-25 00:01:45 -0500]:
> 
>>I may have found it.  There is a note on page 240 of the ICH5 datasheet
>>that says:
>>
>>	For I2C Read command, the value written into bit 0 of the
>>	Transmit Slave Address Register (SMB I/O register, offset
>>	04h) needs to be 0.
>>
>>We're writing a 1 (as would be expected: it's a read after all).  I'll
>>test this hypothesis tomorrow evening... right now I need sleep.
> 
> 
> Before I made the change above, my 'scope wasn't even triggering when
> I tried to do an I2C block read.  After making that change, at least I
> had something to look at...
> 
> Next, I found that the "command" field for I2C block read must be
> written into SMBHSTDAT1 instead of SMBHSTCMD.  After making that change,
> the picture on the 'scope is correct, but...
> 
> The driver still complains "bus timeout".  Now, I guess that the host
> block data byte register is in "block buffer" mode for the I2C block read
> command, regardless of the value of E32B.  That's the only thing I can
> think of that explains why it never gets a "byte done status" in the
> host status reg.  As it stands, the block transfer loop looks for "byte
> done" but ignores "intr", and again that would explain what I'm seeing
> on the 'scope and in the kernel logs.
> 
> Here's my patch so far.  There's some noise because I tried to make a
> better xfer-killer (though it didn't seem to help any).  The important
> changes are in the last chunk.  I probably won't get to play with this
> again before the weekend.
> 
> Regards,
> 
