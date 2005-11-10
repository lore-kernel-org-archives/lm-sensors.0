From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Thu, 10 Nov 2005 16:26:26 +0000
Subject: [lm-sensors] RFC: Correct behaviour for RO sysfs entries?
Message-Id: <20051110152524.GA17789@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have started the process of updating lm85.c to the sysfs-interface spec,
now that I have a better idea against what to patch for (I am using Greg's
git tree as the base).

What should a hwmon driver do upon a write to a sysfs entry that is
currently unchangeable?  This is missing in the sysfs-interface description.
The kernel generic sysfs guidelines seems to encourage one to return errors
where applicable.

I could silently ignore the write (most drivers currently do this) and let
the user try to figure it out why writing to something has no effect, or I
could return an error, thus failing the write right there.

Is there a good reason for not returning errors and instead just silently
ignore them (e.g. when trying to write to pwm# when auto_pwm is enabled)?
Also, can the mode of a hwmon device's sysfs entry be dynamically changed?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
