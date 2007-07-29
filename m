From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 29 Jul 2007 17:55:11 +0000
Subject: [lm-sensors] Thinkpad ACPI "hwmon" driver needs libsensors support
Message-Id: <46ACD47F.2060003@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I just received this bug report:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id%0013

This is caused because the thinkpad_acpi driver now exports its sensors through 
the standard hwmon interface, while libsensors does not know how to handle them 
  (for now).

As already said in various posts I'll be away on vacation for 6 days, after 
that I will start writing libsensors support for the thinkpad_acpi "chip" to 
resolve this issue. If anyone starts work on this, or has already started 
please let me know ASAP to stop us from doing double work.

Also a word to the person implementing these changes in the thinkpad_acpi 
driver, the conversion to the standard hwmon interface is a good thing! But you 
  should have kept the old interface for backward compatibility. You cannot 
just go and remove kernel <-> userland interfaces which have been in active use 
for quite some time!

Luckily this bug ended up in my mailbox and know whats going on as I'm an 
lm_sensors developer, but this is sure to be also causing problems elsewhere!!

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
