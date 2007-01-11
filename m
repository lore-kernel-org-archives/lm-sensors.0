From: r.marek@assembler.cz (Rudolf Marek)
Date: Thu, 11 Jan 2007 21:50:14 +0000
Subject: [lm-sensors] FB-DIMM temperature
Message-Id: <45A6B116.70800@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A65914.6040302@assembler.cz>
In-Reply-To: <45A65914.6040302@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Vadim,

>  I think I know at least why the temperature is sometimes 0: it's a timing
> issue, apparently you can't read the sensors too quickly. If I insert
> usleep(1000) between access to the signature bytes and the temperature value,
> I can reliably read non zero values. 

Ah, that is not too convenient :/ Maybe we need to read only 4 bytes at once. I
must check the Northbridge datasheet for this. Also it might be worth to check
the 14.5.3.4 UPDATED: Update Temp Diff Bit maybe it is zero when this bit is set.

>I also looked at the values of the other
> registers described in the section 14.5.3 of Intel datasheet, here is the
> full output:

I have some news too. The registers must match by definition with the Intel
public document.

> 
> 	Sig at 0: 1d 11
> 	Device id: 80 04
> 	TEMPLO:         106.00C
> 	TEMPMID:        109.00C
> 	TEMPHI:         124.00C
> 	TEMPSTAT:       0x1
> 	TEMP:           68.50C
> 	Sig at 16: 1d 11
> 	Device id: 80 04
> 	TEMPLO:         106.00C
> 	TEMPMID:        109.00C
> 	TEMPHI:         124.00C
> 	TEMPSTAT:       0x1
> 	TEMP:           68.00C
> 	Sig at 32: 1d 11
> 	Device id: 80 04
> 	TEMPLO:         106.00C
> 	TEMPMID:        109.00C
> 	TEMPHI:         124.00C
> 	TEMPSTAT:       0x1
> 	TEMP:           59.00C
> 	Sig at 48: 1d 11
> 	Device id: 80 04
> 	TEMPLO:         106.00C
> 	TEMPMID:        109.00C
> 	TEMPHI:         124.00C
> 	TEMPSTAT:       0x1
> 	TEMP:           63.50C
> 
> So, assuming I interpret TEMPLO/MID/HI correctly (I also divided their
> values by 2 to get the temperature in degrees Celsius), it really does look
> that these DIMMs are supposed to run quite hot.

>  Please let me know if I'm wrong (before I fry them :-),

No this are thresholds for the action, when system become too hot. Your temps
are around 70C now, so your system is safe.

No need to panic ;)

Rudolf

