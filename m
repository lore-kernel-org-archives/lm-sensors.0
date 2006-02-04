From: roger@planbit.co.uk (Roger Lucas)
Date: Sat, 04 Feb 2006 12:54:12 +0000
Subject: [lm-sensors] LM-Sensors with 2.6.14 and SMSC 47M997 on
Message-Id: <20060204125556.8E95D12E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060203091816.783B912E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20060203091816.783B912E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Pavel,

I can see voltages changing in the BIOS H/W monitor, so that gives me a lot
of confidence.

I checked SMSC's web site and they don't list the 4M997 but they do list the
4M192 which is allegedly compatible.  The 4M192 definitely has voltage
monitoring supported - the datasheet lists the registers etc etc.

I am very confident that both the 47M192 and 47M997 have full temperature,
fan and voltage measurement capability.  There is even a driver for the
Linux 2.4 kernel which has voltage and temperature monitoring capability.

I suspect that your BIOS is not giving you the full monitoring capability of
your motherboard, or (for some reason) your motherboard does not have the
full capability of the chip wired.

Best regards,

Roger

> -----Original Message-----
> From: Pavel Ruzicka [mailto:pavouk at pavouk.org]
> Sent: 03 February 2006 20:51
> To: lm-sensors at lm-sensors.org
> Cc: Roger Lucas; mdsxyz123 at yahoo.com
> Subject: Re: [lm-sensors] LM-Sensors with 2.6.14 and SMSC 47M997 on
> Gigabyte-8I865GVMF-775
> 
> Hi,
> 
> > I am looking to get full sensors support for both fan and temperature
> > monitoring on my Gigabyte 8I865GVMF motherboard.  I have run sensors-
> detect
> > and determined that I have an SMSC 47M192 or compatible (motherboard
> > inspection shows a SMSC 47M997 device which is allegedly compatible) and
> I
> > have successfully installed the sm47m1 driver which was with the kernel.
> 
> Are you sure, that this chip have support for voltages?
> I have this chip on my motherboard (RS480M2-IL), and I have not support
> for voltages. Only FAN measuring, regulation and temperatures.
> Look at your BIOS if you have voltages there.
> If not, probably voltage measuring will not be supported on your board.
> 
> Best regards,
> 
> Pavel Ruzicka


