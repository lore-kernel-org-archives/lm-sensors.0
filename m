From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: SMBus via SDRAMM: Why not refer to SDRAM Pinout
Message-Id: <20040722210319.7273f1c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F42C16.30404@informatik.uni-muenchen.de>
In-Reply-To: <40F42C16.30404@informatik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i just read your instructions on how to access the SMBus via SDRAM if 
> the mainboard has no SMB-Pins:
> 
> http://secure.netroedge.com/~lm78/hardhack.html
> 
> You said i should refer to the EEPROMS datasheet to find out which
> pins are SDA/SCL ...
> but why not refer to SDRAMS Pinout, thats much simpler!
> 
> http://www.interfacebus.com/HWB_dimmsdram168unbuf.html
> 
> I think this is easier and more sure.
> And since the lines on the platine on the right-hand side on SDRAM
> are not so many you can follow them from SDRAMS's SDS/SCL connection
> to the EEPROM easyly anyway.

Feel free to provide a patch against that web page and we'll apply it.

Thanks,

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
