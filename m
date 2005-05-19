From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Problem with eeprom module in 2.9.0
Message-Id: <41F2854D.6020503@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DDAE4F.9030606@earthlink.net>
In-Reply-To: <41DDAE4F.9030606@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

good diagnosis khali.
the 6300ESB definitely supports i2c block so there must be a bug in there somewhere.
I just reviewed the code and didn't see anything obvious.
David can you recompile i2c-i801 with the DEBUG=1 uncommented and
send us the dmesg output?

Jean Delvare wrote:
> Hi David,
> 
> 
>>>What's the PCI ID of this one? Maybe block transfers work OK for the
>>>E7501 but not for the E7520.
>>
>>The SMBus controller on the E7501 is 8086:2483 (rev 02).
>>The SMBus controller on the E7520 is 8086:25a4 (rev 02).
> 
> 
> OK, mystery explained then. 2483 is an ICH3, for which the I2C block
> transfers are not available at all - so MDS' changes did not affect
> this one. 25a4 is an 6300ESB, which is more recent and supposedly
> supports I2C block transfers, thus is affected by the change.
> 
> 
>>>(although I still can't get why lm93 doesn't trigger it).
> 
> 
> As noted by Mark Hoffman, the lm93 driver uses SMBus block transfers, not
> I2C block transfers. Second mystery explained. SMBus block transfers
> were implemented longer ago and seem to work.
> 
> So the conclusion is that the (untested as of now) I2C block transfer
> recently added to the i2c-i801 driver by Mark Studebaker doesn't work
> for you, and most presumably doesn't work at all. I will leave it to
> Mark to propose a fix or debug tests to further analyze the problem.
> 
> Thanks,
> --
> Jean Delvare
> 
> 
