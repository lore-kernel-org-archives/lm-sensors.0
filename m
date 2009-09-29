From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 29 Sep 2009 08:20:57 +0000
Subject: [lm-sensors] sensors.conf manpage name
Message-Id: <4AC1C369.8090901@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I just received this bug report:
https://bugzilla.redhat.com/show_bug.cgi?idR6178

Which makes sense, so now I was thinking how to best handle this. We
can make a sensors3.conf.5 symlink to sensors.conf.5 or we can just
rename it. There is something to be said for both cases.

sensors3.conf is the new default name, but sensors.conf is still used
as a fallback by libsensors.

So what is your 2 cents on this ?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
