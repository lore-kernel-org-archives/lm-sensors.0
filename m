From: Chris Pattenden <chris@aeryon.com>
Date: Mon, 08 Jul 2013 14:15:42 +0000
Subject: [lm-sensors] Displaying Voltage as Temperature?!?
Message-Id: <51DAC98E.3090203@aeryon.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Howdy.

I have a thermistor connected to a voltage sensing port (in0_input) on 
my ADC chip. I have everything running (i.e, /etc/sensors.conf has the 
voltage->temperature conversion curve programmed into a 'convert' line 
and 'sensors' is displaying the correct temperature) but the temperature 
is being displayed as "+21.0 V". Obviously, I'd like to display "+21.0 C".

Is there any way to force sensors to display the reading as a 
temperature without rewriting my ADC driver to fake a temperature 
sensing device (which it isn't)?

Thanks,
Chris




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
