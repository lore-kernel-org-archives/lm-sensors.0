From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <200406251315.i5PDFvcC020412@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I thought you were not yet asleep at 4:30am... Should I now admit that
you had actually already gotten up? ;)

>> First of all we want to disable temp1 and temp2 (thermal diode channels).
>> First unload the driver, then:
>>
>> isaset -f 0x6649 0
>> isaset -f 0x664a 0
>> isaset -f 0x6649 1
>> isaset -f 0x664a 0
>
>Ok, I hit a snag running the second command here:
>
>soekris1# isaset -f 0x664a 0
>WARNING! Running this program can cause system crashes, data loss and worse!
>I will write value 0x00 to address 0x664a
>You have five seconds to reconsider and press CTRL-C!
>
>Warning: Data mismatch, wrote 0x00, read back 0xcc
>
>I stopped at this point.

This is OK. This is even expected, maybe I should have told you so that
you don't worry. The register you are writing to is only partly
writable, so this is no wonder most bits will now bow before your
command and stay the way they were.

BTW, please undestand that these commands go by pair. First command of a
pair selects a channel, second writes to a specific register for that
channel. They must *always* be run in turn and in this order, or you'll
end up writing to a random channel.

As you may have guessed, the fourth command will return a "Data
mismatch" message as well, which is OK.

OTOH, if you receive a similar message when reconfiguring the Super-I/O
chip (command starting with "isaset 0x2e 0x2f"), then this is *not* OK
and you'll have to report to me.

>The configuration file I'm using is a slightly tweaked version of something
>you had posted to a mailing list. I'll attach it. Below is the output I see
>from sensors using it. It obviously still needs some tweaking. Some of the
>voltage calculations must be inappropriate in this case.

Aha, forget about it then. All PC87366 chips I have see so far had
different configurations. By "different" I mean different voltages
monitored, different order and different resistor combinations.
Theoretically, National has recommendations, but unfortunately nobody
seems to be following these :( I was hoping you got information from the
board maker, and didn't realize the file was from me...

>Is Soekris going to have to let us know how the voltage inputs are wired
>before we can have any idea what these represent?

Yes, definitely. There's nothing we can do without them telling us what
each voltage channel is supposed to measure, and which resistors are in
use.

>soekris1# sensors
>pc87366-isa-6620
>Adapter: ISA adapter
>+5V:       +8.50 V  (min =  +4.49 V, max =   5.50 V)       ALARM
>Vcore:     +2.78 V  (min =  +0.00 V, max =   2.95 V)
>+12V:     +23.54 V  (min = +10.83 V, max =  13.20 V)       ALARM
>5VSB:      +0.00 V  (min =  +4.49 V, max =   5.50 V)       ALARM
>Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
>Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
>Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
>AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM

No comment...

BTW, do you have an idea on what the Vcore for your CPU is supposed to be?

Thanks,
Jean Delvare
