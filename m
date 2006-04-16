From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 16 Apr 2006 16:57:10 +0000
Subject: [lm-sensors] ridicolous sensors output?
Message-Id: <20060416185710.b9b5a618.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
In-Reply-To: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Roy,

> > My first guess is that this W83627THF chip is not used for hardware
> > monitoring on your board. You probably have another chip for that.
> >
> > Please provide the following information:
> > * Kernel version.
> 
> 2.6.16.2 custom built
> 
> > * Version of lm_sensors.
> 
> sensors version 2.9.1 with libsensors version 2.9.1

That's a bit old, see below.

> Next adapter: SMBus I801 adapter at 0500
> (...)
> Client found at address 0x2f
> (...)
> Probing for `Winbond W83792D'... Success!
>     (confidence 7, driver `to-be-written'), other addresses: 0x4b 0x4f

OK, that's your hardware monitoring chip. sensors-detect thinks there
is no driver for it, but by now, there is. Try:
  rmmod w83627hf
  modprobe i2c-i801
  modprobe w83792d
And sensors output should be better.

However, user-space support for that chip was just added in lm_sensors
2.9.1 and many bugs have been fixed since, so you are invited to update
lm_sensors to a later version for better results.

-- 
Jean Delvare

