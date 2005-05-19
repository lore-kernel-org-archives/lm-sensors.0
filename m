From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: temperatures
Message-Id: <Pine.LNX.4.58.0406181033190.6087@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr9pzmdztlsrnb1@localhost>
In-Reply-To: <opr9pzmdztlsrnb1@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hello,

> Yes!
> It works, and I have temperatures, and the usual alarms.
> I put the modprobe lines in rc.local, as it was less cluttered.
> Both rc.local and rc.modules are shell scripts in slack9.1.

ok thanks for info.

>
> Should I be concerned about the alarms? Have checked in BIOS, and the
> voltages seem accurate.

Try to run sensors -s It will load limits to chip calculated in
/etc/sensors.conf. Also you can ignore some values, rename labels etc.

All stuff is in /etc/sensors.conf

Follow instructions at the beginning of the file. Basically you need to
find configuration section for your chip, and change either labels,
formulas, or ignore statements. Note that there can be prepared
alternative formulas in each chip section.

You can find relevant section in file by looking at your chip name.
sensors command will print the chip name (or look at your modules)

Please note that is needed to run sensors -s to "commit" the computation
formulas and limits from sensors.conf file.

If you need some GUI client you can use ksensors for KDE or gkrellm
otherwise instead of textmode "sensors".

I hope this helps, if any problem let us know and please include your
"sensors" output and any changes you made to config file.

Regards

Rudolf


