From: "Fred ." <eldmannen@gmail.com>
Date: Tue, 17 Feb 2009 22:18:44 +0000
Subject: Re: [lm-sensors] Does lm-sensors support chassis intrusion for
Message-Id: <f188924b0902171418l5ede509veb66fb5096cbce2e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f188924b0902150713q43addf9g94851a4d581b411e@mail.gmail.com>
In-Reply-To: <f188924b0902150713q43addf9g94851a4d581b411e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I propose we make a file that we call 'intrusion', but if you want to
have it open for extension,
such as multiple detectors, we could call it intrusion1 (leaving room
for intrusion2, etc).

If the file says 0, it means everything is cool.
If the file says 1, it means its triggered, and case is open.

We might want to be able to write to the file, in order to reset it.

Should we have an alarm file?
In that case, it would be intrusion1_alarm. In the sysfs-interface
file, that would be declared as;
intrusion[0-*]_alarm
Where 0 is no alarm, and is 1 alarm.

Here we have the file sysfs-interface.
http://www.kernel.org/doc/Documentation/hwmon/sysfs-interface

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
