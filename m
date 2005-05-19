From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: 2.6 kernel - IT87 - Issues
Message-Id: <20040623225140.7f2a4fd8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I very quickly had sensors.conf configured and the only issues I
> had where that my BIOS only shows CPU temp (temp2) and it does not
> show -12 or -5 or Vcore2 which is just under Vcore1 (~0.15V).
> The output of sensors showed good agreement with all that the BIOS 
> shows and temp1 (M/B temp) and temp3 seemed reasonable I just don't
> have a BIOS output to compare with.  The sensors output of -5 and
> -12 was screwed (ex. -12 was ~-19 V!).

I just added an entry in the FAQ about -5V and -12V being way out of
range:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e6

You might as well want to read this one about Vcore1:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e3

> So, all in all sensors is working EXCEPT no fan control.  My fans
> appear to go to 100% pwm...annoying as I purchased this as my quiet
> pc in my guitar room! Now I know not everything is 2.6 ready so...
> What is the status of fan control in 2.6?

Quick summary: support is missing.

However, Jonas Munsin is working on it. Latest proposal is here:
http://archives.andrew.net.au/lm-sensors/msg07993.html
(The preliminary patch has been since modified and applied, so the
actual patch may or may not apply cleanly anymore.)

> Are the fancontrol and/or pwmconfig scripts 2.6 ready?

I don't think they are.

> Also, I don't know is this is pertinent but when I run acpi -V I
> only get the CPU temp which agrees well with temp2 (CPU temp) but
> why wouldn't I get additional information like sensors provides?
> I realize acpi might be completely separate from i2c but as I
> know next to nothing I thought I would ask.

You're correct, lm_sensors and ACPI are two completely separate worlds.
ACPI can hardly compete with us when it comes to hardware monitoring.
More often than not it provides no more than one temperature readings.
We only redirect people to ACPI when it happens that there's nothing
lm_sensors can do for them (which is quite frequent for laptops).

-- 
Jean Delvare
http://khali.linux-fr.org/
