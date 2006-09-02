From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 02 Sep 2006 17:42:50 +0000
Subject: [lm-sensors] Question on piix4
Message-Id: <44F9C29A.7010601@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200609021929.30351.dieter.jurzitza@t-online.de>
In-Reply-To: <200609021929.30351.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dieter

> Sep  2 13:04:06 linux kernel: piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 
> device
> Sep  2 13:04:06 linux kernel: piix4_smbus 0000:00:0f.0: Unusual config 
> register value
> Sep  2 13:04:06 linux kernel: piix4_smbus 0000:00:0f.0: Try using fix_hstcfg=1 
> if you experience problems
> Sep  2 13:04:06 linux kernel: piix4_smbus 0000:00:0f.0: Illegal Interrupt 
> configuration (or code out of date)!

We fixed that already. This happened with serverworks chipset and HT1000


> Is this potentially harmful? Should I do something about it?
> I reinserted the module with parameter fix_hstcfg=1, sensors-detect finds no 

Ignore it please.

Regards
Rudolf

