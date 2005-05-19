From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: LM_sensors and Toshiba laptops
Message-Id: <3C3FAEB0.90082975@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0201091514280.610-100000@home.aussec.com>
In-Reply-To: <Pine.LNX.4.33.0201091514280.610-100000@home.aussec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry to hear about your trouble.
Yours is the first report we've had about a Toshiba laptop.
Perhaps if you go into the BIOS to the sensors screen or
let the battery run down it
will re-initialize your sensors device?
But hopefully the trouble is unrelated to any probing
by our software.
Good luck.
mds


tom burkart wrote:
> 
> Hi,
> I have used the lm_sensors package to try and look at the i2c devices on a
> Toshiba Tecra 8100 laptop with little success.
> It now overheats and crashes with extended use.  I do not know wether it
> was due to probing the i2c bus and changing something or some other
> unfortunate combination of events that culminated at about the same time.
> So since I saw the warning messages for IBM laptops I thought I would
> mention it - just in case.
> I would be happy to try and trouble-shoot what may have happened if
> someone could give some guidance what to try...
> 
> CPU: Pentium 3/speedstep 750MHz, 128M RAM, 20G HDD,...
> Kernel: 2.4.17
> LM_sensors/i2c: 2.6.2
> 
> tom.
> Consultant
> 
> AUSSEC    Phone: 61 4 1768 2202
> 339 Blaxland Rd., Ryde NSW 2112
> Email: tom@aussec.com
