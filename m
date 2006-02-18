From: tyranix@gmail.com (tyranix)
Date: Sat, 18 Feb 2006 17:53:38 +0000
Subject: [lm-sensors] MSI KT4V - Strange sensors output.
Message-Id: <ec3d44da0602180953w4c95640dtcd0dcf3f9069310e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
In-Reply-To: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'll paste in what my motherboard reports for the readings with alarm status.

On 2/18/06, Jean Delvare <khali at linux-fr.org> wrote:
> >       -5V:       -5.35 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
-5.0V:  -5.327V

> >       V5SB:      +5.56 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
+5V SB: 5.042V

> This will still not make it for 5VSB though; it would need 15%, which I
> admit is a bit too much. Are there values displayed for these voltages
> in the BIOS setup screen? If so, do the values there match the ones
> displayed by "sensors"?

I re-ran sensors and it still reports 5.59 V for V5SB but my BIOS says 5.042V.

> >       temp1:       +30?C  (high =   -86?C, hyst =   +59?C)   sensor > thermistor

> I'd guess the limits for temp1 were simply never initialized.

I checked and there is only a section for CPU critical temperature.  I
cannot set the system temperature limit.

Thanks!

