From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: upgrading lm_sensors and config file
Message-Id: <20021024181106.576d5bca.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi everyone,

One of the recurent difficulty I encounter with lm_sensors is the
maintainance on config files through upgrades. I customized sensors.conf
on most of my machines and I have to do it again each time I upgrade
lm_sensors. I have come to a fast way to do so and I think it may be
worth discussing of integrating it to lm_sensors releases.

When first installing lm_sensors, I copy /etc/sensors.conf to
/etc/sensors.conf.default. For later installs, as you know, lm_sensors
won't overwrite /etc/sensors.conf (and it should stay this way). At this
point, I make a diff between /etc/sensors.conf.default and
/etc/sensors.conf and store it in /tmp. I then try to apply it to a copy
of the new lm_sensors-2.6.x/etc/sensors.conf.eg. If the patch succeeds,
I copy the result to /etc/sensors.conf and the new (unmodified)
lm_sensors-2.6.x/etc/sensors.conf.eg to /etc/sensors.conf.default. The
upgrade is successfull. If the patch fails, I have of course to edit the
file manually.

I think that the method could be integrated to the distribution. The
following changes would be required:
1* Install lm_sensors-2.6.x/etc/sensors.conf.eg to both
/etc/sensors.conf and /etc/sensors.conf.default.
2* Include a script (placed in prog/config I suppose) that does the diff
and patch thing.
3* Add an explanation line at the end of make install if
/etc/sensors.conf already exists to invite the user to run the script if
(s)he wants to.

I of course volunteer to write the script and commit the whole thing to
CVS, in case nobody has an objection.
Any comment welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
