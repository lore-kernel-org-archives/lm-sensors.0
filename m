From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 14 Sep 2012 11:56:40 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <20120914135640.78586673@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry I forgot to reply to the list last time, adding it back...

On Thu, 13 Sep 2012 15:07:30 +0100, MrNice wrote:
> On 13/09/12 10:15, Jean Delvare wrote:
> > On Thu, 13 Sep 2012 09:19:39 +0100, MrNice wrote:
> >> Following the advice
> >> http://lm-sensors.org/browser/lm-sensors/trunk/doc/fan-divisors
> > This doesn't apply to the NCT6776. See in the output above, there is no
> > "div =" on the fan lines.
> >
> > Maybe the document should be clarified.

I just did so [1], hopefully the updated document is clearer and users
will understand whether they have to read it or not.

[1] http://www.lm-sensors.org/changeset/6071

> Do you know if is there any way to collect the right speeds as UEFI 
> values are good.

No idea. Check the motherboard documentation. If the fans are really
connected to the NCT6776, this may be a driver bug. BTW you said you're
using the w83627ehf driver from groeck, but there is a better driver
for the NCT6776 now:
  https://github.com/groeck/nct6775
Guenter, maybe this driver should be listed at
  http://roeck-us.net/linux/drivers/
so that users find it?

If the new driver doesn't help, maybe the fans are connected to another
monitoring chip.

> Does the mean all the AMD FX CPU have the same issue? What to do? Is a 
> patch on the way?

There's no relation between fan speed monitoring and the CPU your
system is using.

> Temperatures in the hardware area have a load of loose vocabulary.
> I try to be accurate:
> Could you confirm that CPUTIN is the temperature read by the sensor in 
> the socket of the motherboard called Tjunction?

I don't think so. AFAIK Tjunction refers to a temperature limit inside
the CPU, and it related to the digital thermal sensor in the CPU.
CPUTIN OTOH is an analog thermal sensor. As it is a thermistor in your
case, it is likely under the CPU, in the middle of the CPU socket.

> Could you confirm that K10temp, temp1 is what AMD call Tctl (sliding 
> scale) accessible through D18F3xA4[CurTmp] register (from BIOS and 
> Kernel Developer's Guide)?

Yes, this is correct.

> Could you tell me what is SYSTIN (system temp input) and AUXTIN 
> (auxiliary temp input)?

These are analog thermal sensor inputs. As already mentioned, AUXTIN is
apparently not used on your board, you can ignore it. SYSTIN could be
anywhere on the motherboard, we can't tell. Maybe the technical
documentation for your board has the information.

> Are they in the list bellow?

I have no idea where this list comes from, so I can't really comment on
that, sorry. Other than:

> TJunction is the temperature where the pins hit the board
> 
> TJunction is still a diode on the board, under the processor

This is completely wrong. At least this is not what the rest of the
world, starting with Intel technical documentation, refers to as
Tjunction.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
