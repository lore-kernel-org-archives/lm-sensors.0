From: Pinkel <pinkel@gmail.com>
Date: Tue, 15 May 2007 15:06:20 +0000
Subject: [lm-sensors] Sensors-detect with DMI information,
Message-Id: <dba8564e0705150806s3376a205ma0b965253c88c7d4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <005401c79618$f9873e00$a6813491@pinkeltje>
In-Reply-To: <005401c79618$f9873e00$a6813491@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey all,

Sorry if you receive this message twice; I seem to have problems with
the mailing list. Therefore, I removed all attachments and uploaded
them to a webhost. Sorry for that.

Patch can be found at:
http://www.pinkelmans.nl/prive/sensors/sensors-detect.patch

= original messsage =

Please find attached the (patch for) first version of the updated
sensors-detect. This patch adds support for looking up sensors
configurations while using DMI information. It applies to the 3.0.0 branch
of lmsensors.

Information about the patch:
* Adds command line parameters
(--automatic, --manual, --version, --verbose, --help, --update)
* Looks up DMI information and tries to match this with a config file in
/usr/share/lmsensors/motherboards
* Ability to update /usr/share/lmsensors/motherboards with database (Note:
This database is currently a DUMMY and does not contain any usuable
information suitable for anything besides testing).
* Proccesses the config file if found.

It seems like it's already near to a complete working version. Every comment
will be appriciated.
If you want to find a checklist with the implemented functions, please
check: http://www.pinkelmans.nl/prive/sensors/Checklist.pdf

Note 1: The script currentently does not yet escapes backslashes for
filenames, this will be added soon.
Note 2: To make the patch more readable, there are no spaces added to nearly
every line inside the mainfunction of sensors-detect. Therefor the patched
verion of sensors-detect itself might be hard to read. A patch with the
added spaces (etc) will be submitted next week or so.
Note 3: The ability to only download configurations suitable for the current
architecture will be added if time permits.

Requirements for sensors-detect (Ivo Manca):
http://www.pinkelmans.nl/prive/sensors/sensors_detect-req.pdf
Requirements for website (Jasper Alias):
http://www.pinkelmans.nl/prive/sensors/website-req.pdf
Please feel free to comment on these requirements or to ask us to eleberate
them.

Information about the sensors-detect discussion can be found:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/thread.html#19332
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/thread.html#19008
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/thread.html#18932

Ivo Manca
Jasper Alias
Gijs van der Weg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
