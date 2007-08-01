From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Wed, 01 Aug 2007 17:52:24 +0000
Subject: Re: [lm-sensors] Thinkpad ACPI "hwmon" driver needs libsensors
Message-Id: <20070801175224.GA4516@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 29 Jul 2007, Hans de Goede wrote:
> I just received this bug report:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id%0013
>
> This is caused because the thinkpad_acpi driver now exports its sensors 
> through the standard hwmon interface, while libsensors does not know how to 
> handle them  (for now).

Yeah.  I had to choose between adding support for current libsensors, and
improving hot key support a great deal in thinkpad-acpi.  Since AFAIK the
forthcoming new libsensors already knows how to deal with generic hwmon
interfaces, I decided to priorize work on the hot key support.

> As already said in various posts I'll be away on vacation for 6 days, after 
> that I will start writing libsensors support for the thinkpad_acpi "chip" 
> to resolve this issue. If anyone starts work on this, or has already 
> started please let me know ASAP to stop us from doing double work.

Feel free to add support to libsensors 2.x for thinkpad-acpi, I don't
believe anyone else is working on it.  At least, nobody told me about it,
yet.  If 3.x needs some thinkpad-acpi specific stuff, feel free to do it as
well.

You can probably do it better than I do, I don't know lm-sensors that well.

And if you have any doubts about something in thinkpad-acpi, or if you find
any bugs in the thinkpad-acpi side, drop me a note and I will be on it as
soon as possible.

> Also a word to the person implementing these changes in the thinkpad_acpi 

That would be me.

> driver, the conversion to the standard hwmon interface is a good thing! But 
> you  should have kept the old interface for backward compatibility. You 
> cannot just go and remove kernel <-> userland interfaces which have been in 
> active use for quite some time!

Well...

There is a reason why I want procfs support gone as soon as pratical, and
code like what is inside gnome sensors-applet is it.

Let's have a look at it, shall we?

(from sensors-applet-1.8.1/src/ibm-acpi-sensors-interface.c):
[...]
fscanf(fp, "%*[^\n]");   /* Skip to the End of the Line */
fscanf(fp, "%*1[\n]");   /* Skip One Newline */
if (fscanf(fp, "speed:   %d", &fan_speed) != 1) {
	(error stuff)
[...]

Is the above an acceptable way to parse a key: value list of records inside
a file?  The order of the records has never been guaranteed anywhere, and in
fact, it *did change* a little depending on thinkpad model.

All in all, whomever wrote that just took a BIG shortcut to parsing key:
value files, instead of looking after the key he wanted, skipping all the
blanks, and getting the data he needed (which is something all people using
shell scripts got right.  Go figure!).

Apparently, the applet also behaves very badly in error conditions (as your
bug reporter found out) instead of doing something sensible like showing
"N/A" in the field it couldn't read.

Whomever wrote that code never bothered asking anyone about the interface
AFAIK, or even bothered to read the kernel driver code.  From a fast look
over the code, it looks like it never handled properly the full range of
procfs output ibm-acpi could generate, either.

Also, properly written stuff that talks to ibm-acpi procfs already deals
with missing procfs files in an intelligent way: ibm-acpi used to add new
ones from time to time, so you had to always consider that they might not be
there if the user was running an older kernel.   The application should have
shown "N/A" (for not available) or somesuch if a file it wanted was not
available in procfs.

It's like trying to read a sysfs attribute, and never expecting any errors
(EIO, ENXIO, EBUSY, EAGAIN, whatever) back.  It *will* eventually break.
Badly.

> Luckily this bug ended up in my mailbox and know whats going on as I'm an 
> lm_sensors developer, but this is sure to be also causing problems 
> elsewhere!!

I suppose so.

As for it causing problems elsewhere, I didn't get any reports of other
stuff breaking.  So far.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
