From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Wed, 28 Feb 2007 11:44:02 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200702281244.03841.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Dienstag, 27. Februar 2007 20:58 schrieb Hans-J?rgen Koch:
> Am Dienstag, 27. Februar 2007 19:07 schrieb Jean Delvare:
> > > Do the count, speed and config also have to be modified to follow a
> > > convention?
> >
> > The count and config files are non-standard files so they don't have to
> > follow any specific convention. In fact I would even remove these
> > files, in particular the config file infringes the fundamental sysfs
> > rule. And the count file isn't particularly useful.
>
> Well, the current implementation assumes that the MAX6650 is initialized by
> the BIOS. On the other hand, the 5V/12V setting is done by the driver, the
> value is hardcoded in the source. This doesn't look like a clean solution.
>
> I suggest to add module parameters to allow configuration of 5V/12V,
> prescaler, count and mode. Then we _know_ the settings and can drop the
> config and the count file. We also get rid of the hardcoded 5V/12V setting
> and don't need to rely on a BIOS that might or might not do what we want.
>

I added these changes. If you modprobe max6650 without any parameters, the 
driver makes no changes to the chip's configuration. With one or more 
parameter, you can change whatever you like. I think this is a good solution 
because it doesn't assume there's a BIOS that does what you want.

Please test, review, comment...

Note: Documentation is not updatet yet.

Thanks,
Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: max6650.patch
Type: text/x-diff
Size: 19199 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070228/a276eee1/attachment.bin 
