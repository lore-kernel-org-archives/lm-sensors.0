From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Dell PowerEdge 300SC temps (lm79, adm1021)
Message-Id: <416B29DC.8010502@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY18-F1uQinOkrx8Bi00036235@hotmail.com>
In-Reply-To: <BAY18-F1uQinOkrx8Bi00036235@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

'board' is the internal adm1021 temperature. 'CPU' is the remote sensor.
If you have that LM79 error you have a libsensors problem, make sure you don't have
old libraries around (see FAQ).
Look at your board to verify what chips you have.

Jason Anderson wrote:
> The chips seem to be detected correctly as an lm79 and 2 adm1021, but I 
> need some help interpreting the temps.
> 
> adm1021-i2c-1-4c
> Adapter: SMBus PIIX4 adapter at 0850
> Board:       +43??C  (low  =    -5??C, high =   +90??C)
> CPU:          +0??C  (low  =  -128??C, high =  +127??C)  ALARM (N/A)
> die_code:    4
> 
> adm1021-i2c-1-18
> Adapter: SMBus PIIX4 adapter at 0850
> Board:       +41??C  (low  =    -5??C, high =  +127??C)
> CPU:         +49??C  (low  =    -5??C, high =  +110??C)
> die_code:    4
> 
> I think there are two because it supports two cpus, but I only have one 
> (PIII).  That makes sense, because CPU temp is 0 on the first one, but 
> what are the "Board" temps?  Also, the cpu temp seems to jump around a 
> lot, is that normal for a PIII?  It goes between 31 and 52 while idle, 
> and up to 69 under load.
> 
> The lm79 has some trouble, it always says "ERROR: Can't get TEMP data!", 
> even if I "ignore temp".  However, temp1_input seems like good data, 
> usually 35-36.  Is this my motherboard temp?
> 
> I also have an nVidia GeForce FX 5200, but I don't think there's a 
> sensor on it.
> 
> Thanks,
> jason
> 
> 
> 
