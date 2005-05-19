From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: w83l785ts inserted but no readings right away
Message-Id: <20040802222227.31c49e37.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <410E4CA4.6070601@johanneshuebner.com>
In-Reply-To: <410E4CA4.6070601@johanneshuebner.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have an Asus A7N8X-X mainboard with the asb100 (bach) and the 
> w83l785ts chip. Latter one reads the internal CPU-temp-diode. When
> all needed modules are loaded it works really well including
> fancontrol.
>
> But the w83l785ts doesn't always work. When the module is inserted
> trough the lm_sensors start-script it is listed when doing lsmod but
> there is no /sys/bus/i2c/devices/1-002e/ directory. After I rmmod and
> modprobe the module (sometimes several times) everything works. When
> using Windows I realized that Speed Fan also sometimes failes to
> detect the w83l785ts-chip. Is this a known problem and do you know a
> workaround? There are no error-messages from modprobe, dmesg or
> anybody else.

This much reminds me this bug report:
http://bugzilla.kernel.org/show_bug.cgi?id(99

Please read the whole thread and confirm, or detail why your case is
different.

Next step would be to apply the proposed patch and recompile your
kernel, including "I2C chip debugging messages", then compare a working
case with a failing one, and report. I suspect that reads are sometimes
wrong with no error reported, due to the BIOS messing up with the SMBus.
If that's the case there's (unfortunately) not much we can do...

> BTW: I had to change pwmconfig a bit for it to detect the fanX_pwm
> lines of the asb100. In it s current state it only finds pwmX . I can
> send it to you if you don't know what I mean.

Yes, please provide your changes in the form of a patch. We'll review it
and see if it's acceptable.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
