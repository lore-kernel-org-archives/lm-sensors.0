From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 07 Sep 2006 19:34:35 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4500744B.3010509@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> -    Chip        #vin    #fan    #pwm    #temp   chip_id    man_id
>> -    w83627ehf   10      5       4       3       0x88,0xa1  0x5ca3
>> +    Chip        #vin    #fan    #pwm    #temp  sio_ID & 0xfff0 chip_id mfg_id
>> +    w83627ehf   10      5       4       3      0x8860          0xa1    0x5ca3
>> +    w83627dhg    9      5       4       3      0xa020          0xc1    0x5ca3
>>  */
> 
> As explained above, chip_id may also be 0x88 for early W83627EHFs.
> 
> I also note that our sensors-detect script was looking for chip_id =
> 0xa2 for the W83627DHG. Don't know where this value comes from. Rudolf?

Hi all,

I'm back to my mail. Bad news is that I dont know where I got 0xa2. I check all 
docs I had and it is not there. I'm sorry I can't explain where it comes from.

MIchael, or whoever with the DHG chip please:

Please unload the driver and do:

isaset -y 0x295 0x296 0x4e 0
isadump -y 0x295 0x296

This will show us the bank0 and also the ID reg. (we would need to fix it for 
the i2c...)

And BTW Jean,

	incorrectly presented itself as mallaury.nerim.net
X-Scanned: No viruses found.
X-Scan-Signature: 6c8541cafecc71ce735155c6942fb964
Cc: Marek <r.marek at sh.cvut.cz>, Michael Walle <michael at walle.cc>,
	Rudolf at ATrpms.net, LM Sensors <lm-sensors at lm-sensors.org>
Subject: Re: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
X-BeenThere: lm-sensors at lm-sensors.org

There is something wrong with the CC field of your last mail...

Thanks,
Regards
Rudolf

