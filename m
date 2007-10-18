From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 18 Oct 2007 04:53:42 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <191fb4ca0710172153k5e7d7004oafff3972d7441708@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_282_19510368.1192683222802"
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
To: lm-sensors@vger.kernel.org

------=_Part_282_19510368.1192683222802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jean, Juergen,


On 10/17/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
> On Wed, 17 Oct 2007 12:43:16 -0700, Juerg Haefliger wrote:
> > On 10/17/07, Juergen Bausa <Juergen.Bausa@web.de> wrote:
> > > Here is what I found in /var/log:
> > >
> > > /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
> > > /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
> > > /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: Found a DME1737 chip at 0x2e (rev 0x8a)
> > >
> > > /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
> > > /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
> > > /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)
> >
> > These are all errors that occur when the drivers (i2c and dme1737) get
> > loaded. The dme1737 is not printing any errors so they are not
> > transactions initiated by the dme1737. The 0x10 means "SMBus Device
> > Address Not Acknowledged" according to the ACPI spec. Not sure how
> > this can happen... Signal integrity problems on the board level? In
> > any case, these errors should probably be retried. Not sure at what
> > level though. Jean?
>
> These are not errors at all, it's only i2c-core probing at work. The
> dme1737 driver specifies three possible addresses (0x2c, 0x2d, 0x2e),
> the probes at 0x2c and 0x2d on bus 0 fail, these are the first two
> "SMBus Timeout!" messages above. Then the probe at 0x2e succeeds. Then
> i2c-core goes on with bus 1. There should have been 3 failing probes
> there, but surprisingly, there's only one "SMBus Timeout!" for bus 1. I
> can't explain it.
>
> Juergen, can you please attach the output of:
>
> modprobe i2c-dev
> i2cdetect -y 0
> i2cdetect -y 1

Ah, Jean, you're certainly right! On my machine, I get the following
when loading the driver:

Oct 17 21:38:09 localhost kernel: i2c-adapter i2c-0: SMBus Timeout! (0x10)
Oct 17 21:38:09 localhost kernel: i2c-adapter i2c-0: SMBus Timeout! (0x10)
Oct 17 21:38:09 localhost kernel: dme1737 0-002e: Found a DME1737 chip
at 0x2e (rev 0x8a).
Oct 17 21:38:09 localhost kernel: dme1737 0-002e: Optional features:
pwm3=yes, pwm5=no, pwm6=no, fan3=no, fan4=yes, fan5=no, fan6=no.
Oct 17 21:38:09 localhost kernel: i2c-adapter i2c-0: nForce2 SMBus
adapter at 0x4c00
Oct 17 21:38:09 localhost kernel: i2c-adapter i2c-1: SMBus Timeout! (0x10)
Oct 17 21:38:09 localhost last message repeated 2 times
Oct 17 21:38:09 localhost kernel: i2c-adapter i2c-1: nForce2 SMBus
adapter at 0x4c40


> Either way these 3 log messages can safely be ignored.
>
> > > /var/log/debug:Oct 17 19:35:30 lisa kernel: i2c_adapter i2c-0: SMBus Timeout! (0x1a)
> > >
> > > /var/log/messages:Oct 17 09:16:00 lisa kernel: dme1737 0-002e: Optional features: pwm3=yes, pwm5=no, pwm6=no, fan3=no, fan4=yes, fan5=no, fan6=no.
> > > /var/log/messages:Oct 17 19:35:30 lisa kernel: dme1737 0-002e: Write to register 0x30 failed (-1)! Please report to the driver maintainer.
> >
> > Aha, this is an error as a result of a dme1737 initiated write. 0x1a
> > means "SMBus Busy". So the dme1737 driver is colliding with something
> > else in the system that tries to talk to a chip on the same bus.
>
> This can only happen on a multi-master I2C bus, which is rather rare on
> consumer PCs. Juergen, do you have detailed technical documentation
> about your system? It would be interesting to find out what chip the
> other master is talking to. If it's the DME1737 chip, this could lead
> to problems.

Hmm... What about ACPI? Couldn't it interfere with the dme1737 module
by going after the same resources.


> >                                                                  That
> > should definitely get retried. I can certainly do that at the dme1737
> > level but I don't think that's the right place. Jean?
>
> Assuming that "busy" means that the nForce chip did not even attempt to
> send the message (or lost arbitration, which is equivalent), this
> specific error could be handled in i2c-nforce2, by retrying. The
> problem is that you have to decide how many times you retry, and how
> much time you wait between retries (there doesn't seem to be a way to
> test if the SMBus is busy before trying, right?)

The i2c-nforce2 driver already spins for 10 msecs before deciding to
give up. I'd just retry once after that and see what happens.

Juergen: Can you apply the attached patch and give it a whirl?

...juerg


> We have "timeout" and "retries" fields in struct i2c_adapter, which
> could be used for this. The meaning of "retries" is a bit different
> though, it's supposed to be the number of nacks the bus driver accepts
> when attempting to contact a chip before giving up. This doesn't appear
> to be very useful though so I wouldn't mind recycling this field for
> the more interesting usage you need. Most bus drivers don't set nor use
> "timeout".
>
> As a first aid solution, you could simply hardcode the timeout and
> retry values, just to confirm that it solves Juergen's problem. Then
> we can see how to make it cleaner. Error handling is an area where the
> i2c subsystem needs to be improved.
>
> --
> Jean Delvare
>

------=_Part_282_19510368.1192683222802
Content-Type: text/x-patch; name=i2c-nforce2-retry-if-busy.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f7wsfvcj
Content-Disposition: attachment; filename=i2c-nforce2-retry-if-busy.patch

SW5kZXg6IGxpbnV4LTIuNi4yMy9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW5mb3JjZTIuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBsaW51eC0yLjYuMjMub3JpZy9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW5mb3Jj
ZTIuYwkyMDA3LTEwLTE3IDIxOjMwOjIzLjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjIz
L2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbmZvcmNlMi5jCTIwMDctMTAtMTcgMjE6NTQ6MjMuMDAw
MDAwMDAwIC0wNzAwCkBAIC0xNjgsMTggKzE2OCwyMiBAQAogCX0KIAogCW91dGJfcCgoYWRkciAm
IDB4N2YpIDw8IDEsIE5WSURJQV9TTUJfQUREUik7Ci0Jb3V0Yl9wKHByb3RvY29sLCBOVklESUFf
U01CX1BSVENMKTsKIAotCXRlbXAgPSBpbmJfcChOVklESUFfU01CX1NUUyk7CisJaSA9IDE7CisJ
ZG8geworCQlvdXRiX3AocHJvdG9jb2wsIE5WSURJQV9TTUJfUFJUQ0wpOwogCi0JaWYgKH50ZW1w
ICYgTlZJRElBX1NNQl9TVFNfRE9ORSkgewotCQl1ZGVsYXkoNTAwKTsKIAkJdGVtcCA9IGluYl9w
KE5WSURJQV9TTUJfU1RTKTsKLQl9Ci0JaWYgKH50ZW1wICYgTlZJRElBX1NNQl9TVFNfRE9ORSkg
ewotCQltc2xlZXAoMTApOwotCQl0ZW1wID0gaW5iX3AoTlZJRElBX1NNQl9TVFMpOwotCX0KKwor
CQlpZiAofnRlbXAgJiBOVklESUFfU01CX1NUU19ET05FKSB7CisJCQl1ZGVsYXkoNTAwKTsKKwkJ
CXRlbXAgPSBpbmJfcChOVklESUFfU01CX1NUUyk7CisJCX0KKwkJaWYgKH50ZW1wICYgTlZJRElB
X1NNQl9TVFNfRE9ORSkgeworCQkJbXNsZWVwKDEwKTsKKwkJCXRlbXAgPSBpbmJfcChOVklESUFf
U01CX1NUUyk7CisJCX0KKwl9IHdoaWxlIChpLS0gJiYgKHRlbXAgJiBOVklESUFfU01CX1NUU19T
VEFUVVMpID09IDB4MWEpOwogCiAJaWYgKCh+dGVtcCAmIE5WSURJQV9TTUJfU1RTX0RPTkUpIHx8
ICh0ZW1wICYgTlZJRElBX1NNQl9TVFNfU1RBVFVTKSkgewogCQlkZXZfZGJnKCZhZGFwLT5kZXYs
ICJTTUJ1cyBUaW1lb3V0ISAoMHglMDJ4KVxuIiwgdGVtcCk7Cg==
------=_Part_282_19510368.1192683222802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_282_19510368.1192683222802--
