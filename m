From: jo.lodewyckx@edpnet.be (Jo Lodewyckx)
Date: Wed, 05 Apr 2006 23:37:14 +0000
Subject: [lm-sensors] ali1563 problems
Message-Id: <000101c65909$dee9f490$937ba8c0@genesis>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c657ef$bd81d2c0$937ba8c0@genesis>
In-Reply-To: <000001c657ef$bd81d2c0$937ba8c0@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

The contents of /proc/ioports:


regawebdev proc # cat ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0295-0296 : pnp 00:07
03c0-03df : vga+
03f6-03f6 : ide0
0400-040f : i2c-ali1563
0680-06ff : pnp 00:07
0800-083f : 0000:00:03.1
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0810-0815 : ACPI CPU throttle
  0818-0827 : GPE0_BLK
  0830-0830 : PM2_CNT_BLK
0cf8-0cff : PCI conf1
e000-efff : PCI Bus #02
  ec00-ec3f : 0000:02:06.0
    ec00-ec3f : e1000
ff00-ff0f : 0000:00:0e.0
  ff00-ff07 : ide0
  ff08-ff0f : ide1



-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: woensdag 5 april 2006 11:03
To: Jo Lodewyckx
Cc: LM Sensors
Subject: Re: [lm-sensors] ali1563 problems

> > Do you want to scan the ISA bus? (YES/no):
> > 
> > Probing for `Winbond W83627HF'
> > Trying address 0x0290... Success!
> > (confidence 8, driver `w83781d')
> >
> > Some Super I/O chips may also contain sensors. Super I/O probes are
> > typically a bit more dangerous, as we have to write to I/O ports to do
> > this. This is usually safe though.
> > 
> > Do you want to scan for Super I/O sensors? (YES/no):
> > Probing for `Winbond W83627HF Super IO Sensors'
> > Success... found at address 0x0290/
> 
> Please can you provide dump of:
> 
> isadump 0x295 0x296

And even before that, the contents of /proc/ioports

Kernel 2.6.14 was still affected by the PNP ACPI vs w83627hf issue, we
fixed it only in 2.6.15.
(See http://bugzilla.kernel.org/show_bug.cgi?id@14 for details.)

-- 
Jean Delvare


