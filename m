From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 May 2011 16:00:51 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110512180051.50b1525b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 May 2011 09:18:41 -0600, Harry G McGavran Jr wrote:
> The latest i8k insmod's ok, but when I run /usr/bin/sensors
> after loading it I get the emc report and then the i8k report.
> Right after sensors prints the i8k line and just before
> it would give me the sensors info I get a segfault
> from something related to the app, maybe /usr/bin/sensors 
> itself, but the window where the command is typed is frozen.
> No keyboard interrupts will stop it, one has to kill the
> window to stop /usr/bin/sensors.  At that point other windows
> are still active.  There are no messages in the /var/log/messages,
> syslog, or daemon log about it.  As root if I try to rmmod i8k
> that hangs in the same way.  Ps reports that the rmmod
> is in some kind of wait state and that is not interuptable either.
> 
> A reboot is the only way to clear it up.
> 
> emc6w201 seems to depend on i2c_801 and i2c_dev which I believe

There is a soft dependency between i2c-i801 and emc6w201, in that the
former is needed for the latter to reach the monitoring device, yes.
i2c-dev isn't needed other than for sensors-detect and debugging.

> i8k does as well, so I didn't load any other modules except i8k.

i8k doesn't depend on any other kernel module.

> I had removed the Ubuntu i8kutils package as I'm no longer using i8k,
> and perhaps there is some module in that package that the i8k module
> needs -- I didn't check.  That might be the reason, but I was guessing

No, i8kutils contains a user-space helper for the i8k module, and
that's all. My changes to the i8k make it partly useless (on purpose).

> the i8k modules dependencies were the came as emc6w201's.
> There was nothing in the logs about any of this and no core file
> for whatever is segfaulting. The only error message is the "segmentation fault"
> after the /usr/bin/sensors i8k announcement line.

You can check with "ulimit -c" if a core dump will be written on
segmentation fault. But it could be that no core is written because the
problem is in i8k itself and not in the user-space application.

Unfortunately I have no idea how to investigate this further. This
makes me feel sad because Luca's findings were very promising :(

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
