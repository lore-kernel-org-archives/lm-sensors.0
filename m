From: Sean Fidler <fidlersean@gmail.com>
Date: Wed, 02 Dec 2009 19:55:37 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <alpine.OSX.2.00.0912021445220.316@blackbird.local>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4630404104378646528-1672799326-1259783745=:316"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--4630404104378646528-1672799326-1259783745=:316
Content-Type: TEXT/PLAIN; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Jean,

Sensors output:

smsc47m192-i2c-0-2d
Adapter: SMBus I801 adapter at 1880
+2.5V:       +0.00 V  (min =  +2.90 V, max =  +2.90 V)   ALARM
VCore:       +0.00 V  (min =  +2.99 V, max =  +2.99 V)   ALARM
+3.3V:       +0.00 V  (min =  +4.38 V, max =  +4.35 V)   ALARM
+5V:         +0.00 V  (min =  +6.64 V, max =  +6.64 V)   ALARM
+12V:        +3.12 V  (min = +15.81 V, max = +15.88 V)   ALARM
VCC:         +3.35 V  (min =  +4.38 V, max =  +3.83 V)   ALARM
+1.5V:       +0.05 V  (min =  +1.49 V, max =  +1.99 V)   ALARM
+1.8V:       +0.00 V  (min =  +2.39 V, max =  +2.39 V)   ALARM
Chip Temp:   +34.0°C  (low  = -17.0°C, high =  -1.0°C)  ALARM 
CPU Temp:    +28.0°C  (low  =  -1.0°C, high = -33.0°C)  ALARM 
Sys Temp:      FAULT  (low  = -65.0°C, high =  -1.0°C)  ALARM 
cpu0_vid:   +1.475 V

smsc47m1-isa-0600
Adapter: ISA adapter
fan1:       2925 RPM  (min = 2560 RPM, div = 2)  ALARM
fan2:          0 RPM  (min = 3072 RPM, div = 4)  ALARM


isaset -y -f 0x2e 0x55: "…wrote 0x55, read 0xaa back." Sorry about the 
discrepancy.

I wouldn't mind test kernel patches. I'll have to figure out how to
implement them, but I think I'll be able to manage *fingers crossed*. Whatever I can do to
help.

On Wed, 2 Dec 2009, Jean Delvare wrote:

> Hi Sean,
>
> On Tue, 1 Dec 2009 16:03:24 -0500 (EST), Sean Fidler wrote:
>> Your instructions worked!
>
> Wow. This is more than I hoped for :)
>
>> I'm assuming I have to load up fancontrol manually (via a script) each time, isaset instructions need to be
>> repeated after each boot up, right? Maybe I'm missing something.
>
> Yes, you are correct, the changes done by the isaset commands are lost
> on reboot.
>
>> I was able to set up fancontrol via the pwmconfig and the fan slowed
>> down. Hopefully, it will speed up when necessary.
>
> You should be able to check this easily by putting fake load on the CPU
> (for example with "md5sum /dev/zero").
>
> What does the output of "sensors" look like?
>
>> The first and last isaset lines returned the following:
>> isaset -y -f 0x2e 0x55 -> Data mismatch, wrote 0x0a, read 0xff back.
>                                                 ^^^^
> It really said 0x55, not 0x0a, right?
>
>> isaset -y -f 0x2e 0xaa -> Data mismatch, wrote 0xaa, read 0xff back.
>>
>> These mismatches, of course, didn't effect the end result. Maybe they
>> indicate something that I'm obviously not aware of.
>
> These warning messages were expected, sorry for not telling you in
> advance.
>
>> Your help with this issue is greatly appreciated. Thanks.
>
> You're welcome.
>
> Would you be able to test kernel patches? I think it would make sense
> to let the smsc47m1 driver enable access to the fan speed monitoring
> and control registers at least on your specific machine, and possibly
> on all systems where the base I/O address is properly defined (as the
> w83627hf and w83627ehf drivers are doing for example.) I can do these
> changes but I don't have any chip here to test the smsc47m1 driver, so
> I need someone to do the testing for me.
>
> To test kernel patches (or more specifically to build a patched
> standalone driver) you will need gcc, make, the sources of your running
> kernel (usually available as package "kernel-source" or similar) and
> probably some distribution-specific knowledge on the topic.
>
> -- 
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

--4630404104378646528-1672799326-1259783745=:316
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--4630404104378646528-1672799326-1259783745=:316--
