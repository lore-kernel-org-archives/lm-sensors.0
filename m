From: Martin Herrman <martin.herrman@gmail.com>
Date: Thu, 16 Jan 2014 21:24:20 +0000
Subject: Re: [lm-sensors] Some questions from first user
Message-Id: <CADR1r6geErmdh58BQRTQFOvZdNmv6kHhN1CzTFTFBkCJ-Uwkeg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
In-Reply-To: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014/1/9 Jean Delvare <khali@linux-fr.org>
>
> Hi Martin,

Hi Jean,

thanks for your extensive reply!

> > My questions:
> > 1. coretemp outputs 5 temperatures. The last 4 are the cores, but what
> > is the value of the first one? (my guess: the temperature of the
> > highest core)
>
> The first temperature reported by coretemp is the "CPU package
> temperature". I can't remember if it's a separate sensor or just
> computed by the hardware as the maximum of the core temperatures.

Check!

> > 2. coretemp temperatures have (according to sensors -u) a _max, _crit
> > and _crit_alarm. How are these values determined? Does lm_sensors have
> > a database of existing cpu's and their max temperature specifications?
>
> On recent Intel processors these values are read from the CPU itself.
> On older processors the driver has heuristics to figure them out. It
> may get them wrong in a few cases. Check the driver documentation for a
> list of known limits for older processors.
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/hwmon/coretemp
>
> With a Core i5 you should be on the safe side.

Check!

> > 3. (follow-up on Q2) what is the difference between _max and _crit?
> > What happens when each of them is reached? What is the role of
> > _crit_alarm and how will the alarm be noticed?
>
> For the coretemp driver, _max is the temperature at which point all
> cooling options should be enabled at full throttle. _crit is the
> temperature at which the CPU integrity is no longer guaranteed. You
> don't want to reach that temperature, ever.
>
> _crit_alarm is raised when the measured (_input) temperature goes above
> the _crit limit. This is checked by polling as the coretemp driver
> currently doesn't have a notification mechanism. libsensors doesn't
> support such notifications anyway. This should be added but I don't
> have the time for that.

Check!

> > 4. (follow-up on Q3) how can I change the values for _max and _crit? I
> > tried 'set temp1_max 60' but that doesn't work. (sensors -s complains)
>
> These are read-only limits specific to your CPU model. You don't get to
> change them, sorry.

Clear :-)

> > 5. what is the difference between fan1_alarm and fan1_beep?
>
> fan1_alarm triggers when fan1_input goes below fan1_min. It is
> read-only. fan1_beep is writable and tells whether the alarm triggering
> will result in your system beeping or not. Note that your board must be
> properly wired (i.e. beep output of the monitoring chip routed to the
> on-board buzzer or PC speaker) for this to work, which is unfortunately
> not always the case.

Check! (I tested my board, it doesn't beep..)

> > 6. (follow-up on Q5) how do I set fan1_alarm? set fan1_alarm 1 doesn't
> > work. (sensors -s complains)
>
> You don't, this is a read-only value which gets set by the hardware by
> comparing fan1_input with fan1_min. It is set and cleared by the
> hardware. What were you trying to achieve by setting it to 1 manually?

I was expecting that I could enable/disable a notification (e.g. a
beep from the PC speaker), but your explanation makes more sense (from
the it8728 engineer perspective). Clear!

> > 7. it8728 reports 3 different temps. When CPU is at full load, one of
> > them increases, but the value is much lower than the one reported by
> > coretemp (about 10 degrees lower). sensors outputs that it is Intel
> > PECI. According to the explanation on Wikipedia
> > (http://en.wikipedia.org/wiki/Platform_Environment_Control_Interface)
> > the temperature should be negative and increase towards 0 when cpu
> > temperature rises. Why does sensors show different values?
>
> PECI is the low level specification. Users wouldn't understand that
> sensors returns negative, relative temperature values. So all drivers
> supporting PECI compute the actual temperature based on the negative
> PECI value and the base temperature (maximum temperature supported by
> the component being monitored, the CPU in this case.) For some drivers
> (such as it87) this is even done by the hardware itself. This assumes
> that the base temperature is known and correct, which is unfortunately
> not always the case. In the case of the IT8728F chip, the base
> temperature should be set by the BIOS depending on your CPU model. The
> fact that the values differ between coretemp and it87 suggests that the
> BIOS and the coretemp driver disagree about the base temperature (which
> matches temp1_crit for the coretemp driver.)

Clear again. coretemp _crit temperature is correct, so I have to
adjust the IT8728F cpu temperature with 10 degrees:

compute temp3 @+10,@+10

(Note: I wonder if this is influenced by my BIOS settings, which
allows me to change the temperature for CPU warning.)

> > 8. it8728 shows another two temps. Likely one case temp and the other
> > one the south bridge? How can I find out?
>
> Check what the BIOS says, it typically shows two temperatures so that
> should tell you what temp2 is. Check if the motherboard documentation
> mentions anything. Then experiment by yourself (see what makes each
> temperature rise the most.) It is possible that the 3rd temperature is
> just noise.

Ok, a simple cpu load test showed that temp3 is the cpu temp. When I
compare with the bios, I believe that temp1 is the system/case temp.
In that case temp2 is the noise, but the difference between temp1 and
temp2 is only about 3-4 degrees.

The user manual of my motherboard doesn't have much information about
the temperature sensors.

> > 9. (from FAQ) "Do you have a database of sensors.conf entries for
> > specific boards?
> > No. Good idea though. If you would like to set one up on your website
> > send us mail and we will set up a link to it."
> > Why hasn't this been setup yet? Some sort of a database is at the
> > wiki, but doesn't contain many boards. Is any help still appreciated?
> > Is it just a table of manufacturer, type, sensors.conf file? (and
> > maybe some user registrations and comments by registered users?)
>
> It has not been setup because nobody took the time and energy to do so.
> Yes, it's "only" a set of configuration files indexed by board
> manufacturer/model. But you need to store them somewhere in a safe way,
> provide a way to search and retrieve them, provide a way to add and
> amend them (with protection from spam or any form of abuse.) You are
> welcome to help, but no, this isn't a trivial task.

I started a new thread on this one.

> > P.S. if answers can be found somewhere.. please let me know where to
> > find the documentation!
>
> Some parts of http://www.lm-sensors.org/wiki/Documentation are worth a
> read, but it did not contain an answer to all your questions above.

Pfhew! :-)

I currently believe that my last two questions are:

10. How are temp1_min and temp1_max determined for the it8728 reportes
temperatures?

11. What is temp1_type and temp1_offset?

Thanks in advance again!

Martin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
