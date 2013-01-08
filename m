From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Jan 2013 07:41:59 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <20130108084159.78c57e8f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Jan 2013 17:54:23 -0600, Leslie Rhorer wrote:
> 
> 
> > -----Original Message-----
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > Sent: Monday, January 07, 2013 4:01 PM
> > To: Leslie Rhorer
> > Cc: lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
> > (...)
> > > What about the temp1 and temp2 sensors on it87?
> > 
> > You can try putting some load on the CPU to see if any of these
> > correspond to the CPU temperature (it would rise faster.)
> 
> 	Well, I tried that, but both temp1 readings soar.

That's OK. k10temp's temp1 _is_ the CPU temperature, no question about
that. It's a digital sensor built inside the CPU. it87's temp1 must be
connected to a thermistor under the CPU socket if it changes according
to CPU load too.

> > (...)
> > No idea. Some boards use multiplexing for that but I am not aware of
> > Asus doing that.
> 
> 	That might tend to explain the sensor reports jumping about as I
> reported 

Not sure what it says but there's certainly something fishy about it
all. Do you have the latest BIOS version? You might have to contact
Asus and ask them about the fan wiring details.

> > Do you see all fan speeds in the BIOS? If you do, and go from the BIOS
> 
> 	As I recall, yes.  A couple of them were off the chart, however.  I
> presumed it indicated a bad divisor.

Impossible, as the IT8721F has no fan divisors to start with.

> > to Linux directly (assuming the system support that), does it help
> 
> 	I don't understand what you mean.  Do you mean bypassing GRUB?

No, sorry. I mean that on some machines, you can visit the BIOS and if
you then chose "discard changes and exit" it carries on with the boot
process without restarting the machine. On such machines, the behavior
under Linux can differ when you do that, if the BIOS does additional
initialization steps when you visit it (e.g. hardware monitoring chip
configuration when you go to the relevant page in the BIOS setup tool.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
