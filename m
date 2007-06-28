From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Jun 2007 21:04:47 +0000
Subject: Re: [lm-sensors] Hacking on libsensors
Message-Id: <20070628230447.7012e72c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070626142055.079a4d89@hyperion.delvare>
In-Reply-To: <20070626142055.079a4d89@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 27 Jun 2007 21:02:44 +0200, Jean Delvare wrote:
> On Wed, 27 Jun 2007 17:19:56 +0200, Hans de Goede wrote:
> > It sounds like an excellent plan to start working on the 3.0 branch! Let me 
> > know if you need any help, and/or when you want me to test this on the machines 
> > I have access too.
> 
> I'll let you know. However, I fear that I've been spending too much
> time on the cleanup steps. 3 days have passed already, only 2 left, and
> I still didn't have a look at the libsensors interface. Not to say that
> the work I've done wasn't needed, it certainly was, but I don't think
> there will be much to test at the end of this week. I'll have to find
> more time to keep working on it in the next few weeks.

OK, I've managed to make some significant progress today. All the
chip-specific code is gone:
http://www.lm-sensors.org/changeset/4503
http://www.lm-sensors.org/changeset/4506
http://www.lm-sensors.org/changeset/4507

Then I've unified the sensors_proc_chips and sensors_chip_features_list
arrays so the code handling the chip information gathered from sysfs is
more simple and more efficient, memory-wise:
http://www.lm-sensors.org/changeset/4508
http://www.lm-sensors.org/changeset/4510

And lastly, the parallel feature names and magnitudes are gone:
http://www.lm-sensors.org/changeset/4513

Needless to say, the size of the libsensors, in terms of both number of
lines of code, and binary size, went down drastically:
-rwxr-xr-x 1 root root 342310 jun 25 13:34 libsensors.so.3.1.3
-rwxr-xr-x 1 root root  73206 jun 28 22:59 libsensors.so.4.0.0

And same goes for sensors itself:
-rwxr-xr-x 1 root root 153255 jun 25 13:34 sensors
-rwxr-xr-x 1 root root  26535 jun 28 22:59 sensors3

But I've also hit a minor problem, which I'm an not sure how to solve.
The *_input sysfs files are handled differently in libsensors, because
they act as the main feature for each channel, so they are referenced
by the channel name instead of the sysfs file name (e.g. temp1 instead
of temp1_input). For all the other values, the symbol name is the same
as the sysfs file name. For now I've handled it with a hack in
sensors_read_proc() and sensors_write_proc() so that the right file is
accessed, but this isn't clean, and not very efficient either.

I am wondering if we shouldn't introduce the concept of channel in the
new libsensors. These would be kind of group leaders as far as feature
mappings are concerned, and they would get the label and compute
statements too. Group leaders would be special in that they wouldn't
correspond to a sysfs file. This would make things cleaner, and there
may be some room for performance and memory consumption improvements
too if we go that way. But it would also add some complexity. I need to
think about it some more, for now it's only an idea - and not one I can
implement this week, anyway. Comments are welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
