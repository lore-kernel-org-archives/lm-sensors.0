From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Mon, 19 Dec 2005 10:12:16 +0000
Subject: [lm-sensors] Question regarding temperature readings
Message-Id: <1134987137.4463.27.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
References: <1134675134.4454.90.camel@gimli>
In-Reply-To: <1134675134.4454.90.camel@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

On Sun, 2005-12-18 at 17:38 +0100, Jean Delvare wrote:
> I just checked and doc/developers/proc doesn't say that, which is good
> because that's not true. 

Hmm, indeed, seems that I mixed up something here. Maybe I shouldn't
report things like that after working for 14+ hours. :(
Sorry for the confusion that might have caused.

> As the LM77 reports temperature values with a resolution of 0.5 degree
> Celsius, your driver should declare a magnitude (number of digits after
> the decimal point) of 1, and should report the temperature values with
> a LSB representing 0.1 degree Celsius.

After having a closer look how the LM87 does these things (and after
enabling that sensor on a second box I have at hands for testing
purposes) I got that working now. With this and your comments in mind it
ended up to be an issue of "RTFM" - I somehow missed to check the
meaning of SENSORS_PROC_REAL_INFO, which would have cleared up a lot.

> lm75 driver for an example. The lm77 case should be very similar. If
> the driver currently reports 4200.0 for 42 degrees, it means that the
> magnitude is properly set to 1, but the temperature value has been
> multiplied by 500 (from the register value) instead of 5.

Yeah, that was exactly the kind of problem I was facing. Thanks a lot
for your comments on that and for the patience to explain it rather than
giving the "RTFM" I'd deserve :)

Bye, Mike


