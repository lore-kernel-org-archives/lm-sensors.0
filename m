From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Thu, 02 Nov 2006 10:00:46 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG
Message-Id: <200611021100.46481.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

..2nd try

Hi David

I am still researching on the fans on the asus board. 

One problem I came across:
for fan5 the reading drops sharply from about 1325 rpm to zero when I lower 
the voltage. Note the fan is definitely moving still, the fan physicall can 
do much slower.

fan5_div shows 4 and does not step up as with fan 1 and 4 where I can see _div 
on 128.

fans 1,4 and 5 seem all to be controlled by pwm4 on this board.

to my understanding fan5 should behave as the others and step up the divider 
when lowering the voltage, isn?t it?

Best regards
????????Christian
Am Montag, 30. Oktober 2006 00:12 schrieb David Hubbard:
> Hi Christian,
>
> > Sorry, I should have explained. The CPU-Fan connector on the P5BDeluxe
> > Wifi is a 4-pin, but my CPU-Fan itself has only 3 pins. As I tried to use
> > the marked 3 pins(the 3-pin connector still fits into the 4 pin) I could
> > not control the speed via the Bios (this is probably the purpose of the
> > 4th pin on a 4 pin connector?) --> it stayed on a somewhat noisy speed.
> >
> > So I decided to use one of the 3-pin-CHA1_FAN-connector (all other Fan
> > connectors do have 3 pins) for the CPU-fan and tried this one instead -->
> > it works. All calm cool and quiet now.
>
> Okay, your sensors.conf will be different from the "standard" one for
> this motherboard, because you map the CPU fan to a different fan
> number.
>
> > This is pretty neat as the Bios apparently cannot handle this correctly.
> > If the speed is below, say, 700 rpm or so, the Bios (when the "FAN page"
> > is opened) becomes very slow and behaves strange sometimes.
> >
> > Is this a "auto-div" function of the chip or the driver?
> >
> > Does this mean you do not need to set it in the sensors.conf ? This
> > should be mentioned later specifically in the comments in sensors.conf,
> > isn?t it?
>
> You don't need to set the divs. In fact, I don't think you can. The
> driver does the div scaling.
>
> > Interestingly enough the "sys" is very close to "CPU" in temperature
> > wheras Bios shows 7 degrees more for the CPU (???).
>
> The "sys" temperature is measured inside the W83627DHG. You can test
> this, if you like, by chilling a large metal object and then holding
> it to the chip. But your chip may be integrated with the rest of the
> chipset. Your mileage may vary.
>
> > Question:
> >
> > Which CPU sensor is meant here? The Core2Duo has got 2 of them internally
> > (see coretemp driver) - is this a 3rd one?
> >
> > > The AUX temp may need to be configured correctly. Can you see any
> > >
> > > variation? It may also be that the pin on the chip is not connected to
> > >
> > > anything, and just floating.
>
> The AUX temperature input is a pin on the W83627DHG which measures the
> voltage from a thermal diode or thermistor. It is up to the
> motherboard manufacturer to decide whether to connect it to a sensor,
> or leave it floating. I don't know what it is measuring. The coretemp
> driver measures the temperature of your CPU using a completely
> different interface, and is not related to temperatures reported by
> the W83627DHG.
>
> David



	
		
___________________________________________________________ 
Der fr?he Vogel f?ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de


