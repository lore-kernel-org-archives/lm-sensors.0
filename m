From: Alan A <aaa@bright.net>
Date: Tue, 24 Mar 2009 16:25:14 +0000
Subject: [lm-sensors] help with lmsensors and intel atom
Message-Id: <loom.20090324T161504-153@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm new here so I hope you're patient with me. I recently put together Ubuntu on
an Intel Atom (D945GCLF). I'm trying to program sensor data on an external LCD.
I have no problems writing other data to the display but when I try to parse
sensor data, I can't get anything worth while. The display I', using is a
PicoLCD 256X64.

Here's the code I run in the LCD config file:

Widget Temp {
    class 'Text'
    expression i2c_sensors('temp_input3')*1.0324-67
    prefix 'Temp'
    width 9
    precision 1
    align 'R'
    update tick
}

    Row7 {
	Col1 'Temp'
    }

Maybe I'm out of luck with this board, I hope not. Any advice you might have is
greatly appreciated.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
