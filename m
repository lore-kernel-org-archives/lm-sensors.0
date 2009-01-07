From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Jan 2009 14:49:12 +0000
Subject: [lm-sensors] Wiki changes
Message-Id: <20090107154912.1ea91779@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

During my vacation, I made a number of changes to the wiki.

* Shorter "Starting points" list. I merged "Uses" into the project
  information page, and moved "Hardware Hacking" and "Useful Links"
  to the Documentation page.
  Rationale: make it easier for users to find their way to what they
  are most probably looking for.
  There may be one or two additional links we could move, for example
  the "Using lm_sensors with 2.6.x kernels" link, as I believe it
  has lost most of its value by now.

* Separate pages for Linux 2.4 hardware support status and Linux 2.6
  hardware support status.
  Rationale: the two device lists have diverged significantly over
  time.
  The Linux 2.4 drivers (from lm-sensors 2) are essentially frozen
  now, so that page should almost never change. And having a
  dedicated page for Linux 2.6 support will make it easier to read
  and maintain.

* "Bus type" column added to the hardware monitoring device drivers
  tables.
  Rationale: let the user know if he/she needs a working I2C or SPI
  adapter driver for his hardware monitoring chip to be found.

* Dropped news older than 2002 (inclusive).
  Rationale: old news aren't that interesting, especially considering
  that most news items are links to things which no longer exist.
  I propose that from now on we keep 5 years of old news in the
  archive, no more. I also moved the 2007 news items from the front
  page to the archive, and fixed all the broken links in the news
  archive.

Additionally, I tried to improve the text of several pages to make it
clearer and more up-to-date.

If anyone has objections to these changes, please let me know. Trac
makes it easy to revert changes.

If anyone has ideas to improve the lm-sensors website or wants to
help maintaining it, please let me know. Creating new wiki accounts
is easy.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
