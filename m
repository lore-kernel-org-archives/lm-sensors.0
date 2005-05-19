From: rutger@nospam.com (Rutger Nijlunsing)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: w83627hf driver: one pwm value, two fan speeds?
Message-Id: <20050307192207.GA11544@nospam.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050306230902.GA17472@nospam.com>
In-Reply-To: <20050306230902.GA17472@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 07, 2005 at 10:41:55AM +0100, Jean Delvare wrote:
> 
> Hi Rutger,
> 
> > While trying to control the CPU temperature with the fan speed on a
> > P4P800 motherboard + P4 CPU with the w83627hf driver (kernel
> > 2.6.11-rc4) just like Asus's Q-Fan (see http://www.wingding.demon.nl/
> > for qfan.rb), I encountered a strange effect.
> 
> First of all I'd like to comment on this. Asus' Q-Fan isn't a real
> thing, it's a marketing name.

I know it is, but casual user don't need to know. People barely know
which motherboard they have, let alone which chipset controls their
fan. Calling it Q-Fan here has more to do about 'having an archived
mailing list for other people to search on'.

> The underlying technology is Winbond's
> automatic fan control logic embedded in their Super-I/O chips (W83627THF
> in your case, if I'm not mistaken).

Yup, using the w83627hf module, that's what I wrote.

> Winbond calls that "Cruise Mode".
> In fact there are two of these, thermal cruise mode and fan speed cruise
> mode. Q-Fan would be thermal cruise mode.

What is the difference? Thermal cruise mode probably adjusts the CPU
fan speed according to the CPU temperature, what does 'fan speed
cruise mode' do?

> For confirmation, how is Q-Fan presented in Asus' BIOS? I'd guess a
> "target CPU temperature" to be chosen by the user?

From motherboard manual: Q-Fan can be enabled/disabled, and a low fan
speed can be selected: 11/16, 12/16, 13/16, 14/16, 15/16 or full
speed. No temperature to be set.

> OTOH is seems that your qfan.rb script is a *software* fan control
> script, so it's quite different. Our driver doesn't support either
> cruise mode at the moment.

Yes, it is an software fan control script. What do you mean with
'doesn't support'? It does provide the infrastructure (reading CPU
temp, settings the pwm), so it does support it in my views.

> (Also note that we already have two fan control scripts in the lm_sensors
> package, one written in perl, one in shell, sharing a common
> configuration file.)

Yes, I tried those some time ago. Didn't work. The pwm setting is
non-lineair. I remember not to clearly, but it took a lot of time and
didn't work in the end. The script failed to find correspondance
between pwm and fan speeds.

> > Doing
> >
> > cd /sys/devices/platform/i2c-1/1-0290
> > echo 240 > pwm2
> > sleep 1
> > echo 192 > pwm2
> >
> > .will stabilize at a fanspeed of around 3229, while changing the 240
> > to 128 will give a fanspeed of around 2136.
> >
> > Somehow a 'state' is kept somewhere, or the driver has a bug. Is this
> > a known bug?
> 
> Not known, first report. I would appreciate additional experimental data:
> 1* What if you sleep for a longer time between changes, say 5 seconds?

It needs at least 1 second to be repeatable. When taking a shorter
time, its not as clearly defined. Taking longer naps than 1 second
doesn't change a thing (in the long run).

> 2* Result of a 240/128 and 128/240 combination.

Testing some combinations (echo ... in one console, watching the RPMs
in another one, fan_div is set to 8). Testing, testing, ...

0 or 64  + sleep 5 + 128 gives +-1125RPM.
     80  + sleep 5 + 128 gives +-1125RPM.
     96  + sleep 5 + 128 gives +-1900RPM.   <- change at 96
     144 + sleep 5 + 128 gives +-1900RPM.
     192 + sleep 5 + 128 gives +-1900RPM.
     240 + sleep 5 + 128 gives +-1900RPM.

0 or 64  + sleep 5 + 144 gives +-1400RPM.
     80  + sleep 5 + 144 gives +-1400RPM.
     96  + sleep 5 + 144 gives +-1400RPM.
     112 + sleep 5 + 144 gives +-1400RPM.
     128 + sleep 5 + 144 gives +-2250RPM.   <- change at 128
     240 + sleep 5 + 144 gives +-2250RPM.

0        + sleep 5 + 176 gives +-1875RPM.
     128 + sleep 5 + 176 gives +-1875RPM.
     192 + sleep 5 + 176 gives +-1875RPM.
     208 + sleep 5 + 176 gives +-1875RPM.
     224 + sleep 5 + 176 gives +-2909RPM.   <- change at 224
     240 + sleep 5 + 176 gives +-2909RPM.

0 or 64  + sleep 5 + 192 gives +-2136RPM.
     128 + sleep 5 + 192 gives +-2136RPM.
     224 + sleep 5 + 192 gives +-2136RPM.
     240 + sleep 5 + 192 gives +-3308RPM.   <- change at 240

0        + sleep 5 + 208 gives +-2350RPM.
     128 + sleep 5 + 208 gives +-2350RPM.
     192 + sleep 5 + 208 gives +-2350RPM.
     240 + sleep 5 + 208 gives +-2350RPM.

0 or 64  + sleep 5 + 240 gives +-2760RPM.
     128 + sleep 5 + 240 gives +-2760RPM.
     192 + sleep 5 + 240 gives +-2760RPM.
     224 + sleep 5 + 240 gives +-2760RPM.

Strange, the point of change increases faster than the final speed
does...

> Make sure you wait long enough before you conclude, fans may take up to a
> minute to stabilize speed.

I also hear the difference. 3300RPM sounds a lot different from 2100.
Furthermore, the speeds stabilize within several seconds; I'm
monitoring it myself.

> Did you check that reading from the pwm2 file would always return the
> last written value?

Yes. the granularity appears to be 16, therefore I write values like
128, 144, 192, ...

This granularity corresponds to the BIOS Q-Fan settings: 11/16 is
probably 176, etc.

> Are you loading the w83627hf driver with init=0?

No, since I want the Q-Fan disabled since I want to do it myself in
software. What should I retry with init=0?

> 
> Could you please provide a dump of your chip?
> (isadump 0x295 0x296)

Good luck :)

root /sys/devices/platform/i2c-1/1-0290# isadump 0x295 0x296
  WARNING! Running this program can cause system crashes, data loss and worse!
  I will probe address register 0x0295 and data register 0x0296.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff 01 cf 00 00 00 00 01 01 01 01 3c 3c 0a 0a 
10: 01 ff 00 00 00 01 01 3c 43 00 ff ff 24 32 00 e2 
20: a3 c4 d2 be ff 0a 00 1e 6f 4f ff f0 00 de 57 fe 
30: c2 2c 20 80 24 71 41 dd 4a 49 08 1a 12 0d 00 00 
40: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
50: ff ff 80 ff ff ff 00 80 90 70 ff ff 11 84 ff 05 
60: a3 c4 d2 be ff 0a 00 1e 6f 4f ff f0 00 de 57 fe 
70: c2 2c 20 80 24 71 41 dd 4a 49 08 1a 12 0d 00 00 
80: 01 ff 01 cf 00 00 00 00 01 01 01 01 3c 3c 0a 0a 
90: 01 ff 00 00 00 01 01 3c 43 00 ff ff 24 32 00 e2 
a0: a3 c4 d2 be ff 0a 00 1e 6f 4f ff f0 00 de 57 fe 
b0: c2 2c 20 80 24 71 41 dd 4a 49 08 1a 12 0d 00 00 
c0: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
d0: ff ff 80 ff ff ff 00 80 90 70 ff ff 11 84 ff 05 
e0: a3 c4 d2 be ff 0a 00 1e 6f 4f ff f0 00 de 57 fe 
f0: c2 2c 20 80 24 71 41 dd 4a 49 08 1a 12 0d 00 00 

> 
> Would you have the possibility to test kernel patches?

No problem.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
