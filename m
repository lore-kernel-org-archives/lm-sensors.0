From: bernardo@observit.com.pt (Bernardo Sanchez da Motta)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: Problem loading lm85 sensor module
Message-Id: <001501c30e8d$76045980$5b00a8c0@antero>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm writing you from Lisbon, Portugal.
Let me start by thanking you for
the fantastic job you are doing!

I have an Intel D845GEBV2 motherboard,
and I'm sure the sensor chip is the LM85
(but maybe a "strange" variant).

After downloading your 2.7.0 release,
I used your "sensor-detect" program
without problems, and arrived to the
conclusion that I had an SMBus (non I2C),
type "i2c-i801", and the LM85 sensor 
(but with the warning "unwritten").

Then I found a patch for the LM85 sensor in the 
following location:

ftp://ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-lm85-8
.patch

I applied the patch and everything went well.
I compiled it perfectly and ran "depmod -a" 
without any complaints.

I started by making "modprobe i2c-i801"...

The bus module i2c-i801 loaded fine,
without errors.

Then I tried "modprobe lm85" and it hung...

After a couple of minutes, I recovered
control of the prompt and the module seemed
loaded, but then, when checking the logs, I
found in "messages" the following:

"
Message from syslogd@dvs209 at Tue Apr 29 21:09:11 2003 ...
dvs209 vmunix: lm85: Detecting device at 4,0x2d with COMPANY: 0xffffffff and
VER
STEP: 0xffffffff

Message from syslogd@dvs209 at Tue Apr 29 21:09:11 2003 ...
dvs209 vmunix: lm85: Autodetecting device at 4,0x2d ...

Message from syslogd@dvs209 at Tue Apr 29 21:09:11 2003 ...
dvs209 vmunix: lm85: Autodetection failed
"

What can be causing this autodetection failure?
Do you need more info from me?
I've not tried yet to use the "sensors" program
and the "sensors.conf" file, because of this error.

Thank you in advance for your time.

Best regards,

Bernardo Motta

