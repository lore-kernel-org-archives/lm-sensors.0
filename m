From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: Lmsensors on Mdk10 (some bugs)
Message-Id: <20040803201441.23dff6dc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <410FB665.6070604@wp.pl>
In-Reply-To: <410FB665.6070604@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've installed lm_sensors on Mandrake 10 Official and I've found some 
> bugs. Here's what said sensors-detect (look at the comments):
> (...)
> Driver `w83781d' (may not be inserted):  <-- lmsensors detected this 
> chip but it's not mentioned in modprobe commands
> 
>    Misdetects:
>    * ISA bus address 0x0290 (Busdriver `i2c-isa')
>      Chip `Winbond W83697HF' (confidence: 8)

This is a *misdetection*, which means that this driver should not be
loaded. So there's no bug here.

> (...)
> modprobe w83627hf  <-- there's not module "w83627hf", the proper name
> is "w83627hf_wdt"

These are two different modules. w83627hf is for hardware monitoring,
w83627hf_wdt is a watchdog driver. If you don't have w83627hf, it's
because the kernel coming with MDK 10 is not recent enough. The driver
was added in version 2.6.5.

> Lm_sensors didn't work without "w83781d", I've added modprobe w83781d
> to /etc/rc.d/rc.local and corrected w83627hf. Now it works.

You have the only chip being supported by both drivers (W83627HF on ISA
bus). w83627hf driver is prefered (it's smaller in size), but w83781d
still works. You can go on with it until MDK has a kernel update.

So there's no real bug IMHO.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
