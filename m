From: Andre Prendel <andre.prendel@gmx.de>
Date: Thu, 04 Mar 2010 09:17:41 +0000
Subject: Re: [lm-sensors] 2.6.33 on jetway nc81-lf board
Message-Id: <20100304091741.GA1995@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B8C0598.2060000@xs4all.nl>
 <20100302213709.951ee97b.akpm@linux-foundation.org>
In-Reply-To: <20100302213709.951ee97b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, Mar 02, 2010 at 09:37:09PM -0800, Andrew Morton wrote:
> (cc lm-sensors)
> 
> On Mon, 01 Mar 2010 19:21:12 +0100 Udo van den Heuvel <udovdh@xs4all.nl> wrote:
> 
> > Hello,

Hi,

> > 
> > I just compiled 2.6.33 on a Jetway NC81-LF board with AMD 235E CPU.
> > While trying to get lm_sensors to work I get in dmesg stuff like:
> > 
> > f71882fg: Found f71862fg chip at 0x220, revision 18
> > ACPI: I/O resource f71882fg [0x220-0x227] conflicts with ACPI region
> > IP__ [0x225-0x226]
> > ACPI: If an ACPI driver is available for this device, you should use it
> > instead of the native driver
> > ACPI: I/O resource piix4_smbus [0xb00-0xb07] conflicts with ACPI region
> > SOR1 [0xb00-0xb0f]
> > ACPI: If an ACPI driver is available for this device, you should use it
> > instead of the native driver
> > 
> > 
> > No other sensor-related modules are loaded.
> > 
> > What could be wrong?

See lm-sensors FAQ Chapter3 #39:

  http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

Regards,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
