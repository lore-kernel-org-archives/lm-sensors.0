From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <4001BC6C.3080106@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>>I don't see any difficulty here. They are in0, in1 and in2. We never
>>>give names to the channels, only number. Labels are set with
>>>sensors.conf.
>>
>>Ok, so everything is like before, besides the values beeing unscaled.
> 
> Correct. Please consider updating the 2.4 driver in a similar way once
> you're over with the 2.6 driver, so that the same sensors.conf works
> with both versions.

Ok.

>>BTW: I'm not on the ML.
> 
> Want to be?

Not yet. Maybe soon, if I get further documentation from Fujitsu-Siemens.

>>Ok, but then I should complete the output of sensors for fscher and
>>also include alarms and watchdog.
> 
> You wanted to do so anyway, DIDN'T YOU? ;)

As I'm now more familar with sensors, shure!

>>>You like reading and writing to /proc files directly, don't you? ;)
>>
>>Maybe, I was just to lazy to look for a different solution. From
>>coding the module, I knew that it would work that easy ;-).
> 
> Adding a few lines to sensors.conf isn't that difficult, really. I'd
> even find it easier than setting up a startup script that echoes values
> to /proc files. But that's a matter of taste I guess.

It's time to change to sensors, because it solves dual-boot issues (2.4.x: 
procfs, 2.6.x: sysfs).

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
