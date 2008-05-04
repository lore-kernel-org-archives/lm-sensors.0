From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 May 2008 07:41:39 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080504094139.0c9261f2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Achim,

On Sun, 04 May 2008 01:24:19 +0200, Achim Gottinger wrote:
> I took a picture of the board and numbered the chips.
> http://www.abload.de/image.php?img=img_6532l9j.jpg
> 
> Chip 1-2 are the two NIC chips. Chip three is interesting.
> It was hard to read but i found that chip ICS9LPRS477BKL
> 
> I found that article later explaining that chip as an clock generator.
> http://www.planet3dnow.de/vbulletin/showthread.php?t30028&garpg=6
> 
> Here are specs for a chip with an very similar number which is a clock 
> generator chip.
> http://www.idt.com/?genID=9LPRS478

There's also this one:
http://www.idt.com/?genID=9LPRS471

Maybe you misread the last 1 as a 7?

Both chips have an SMBus interface so most certainly at least one of
the addresses of i2cdetect corresponds to this chip. We'd need a
datasheet but it doesn't seem to be available for download :(

> 
> Chip four is something like ICS 7714084.

Couldn't find anything about this one.

> The five chips with number five 
> have a lable like PI2PCIE.
> Chip 8 is the via firewire controller, number nine is the sensor chip 
> and ten seems to be an ST75185C like RS-232 driver and receiver chip 
> rellated to the com port connector next to him.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
