From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors && bt869
Message-Id: <20040101081057.6748d6ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well...I think I could manage to change almost everything according to
> the guide and other ported files but there where 2 points where I ran
> into problems:
> 1. Section "Detect", Device Creation: Do I have to use names from the
> sysfs-interface-doc here? The problem is, that I couldn't find
> anything useable here as the bt869 isn't a sensor chip in the
> traditional way (it does neither read temperatures nor voltages or
> whatever...).
> 2. Quite the same problem is at the point where I have to define
> show and set functions: I should use names from the
> sysfs-interface-doc but there isn't anything according to the
> functions which the bt869 has...

The sysfs-interface is really meant for sensor chips IMHO, with the
exception of eeprom because it it both generic (it is a raw reading of
the whole addressing space) and special (because it is a binary file).

So you of course can't use what's documented in sysfs-interface for now.
What we should do is chose files that make sense for your chipset, while
keeping a few simple rules in mind:
* The names should not interfere with those documented in sysfs. It's
unlikely it would happen anyway.
* The names should be such that anyone doubtlessly know what the value
represents, just from the name.
* The names should follow the naming scheme described in
sysfs-interface whenever it applies (i.e. <channel>_<value><number>).
This choice is still subject to change but I want names to be consistent
until there.
* Remember that sysfs has only one value per file, which wasn't the case
with procfs. So you typically have more files in the new driver than in
the old one.
* The names you chose should be reusable by other video chips driver.
For example, you would prefer "video_norm_out" over"video_norm" because
other chips could have "video_norm_in".

Our goal with the sysfs interface is that no particular knowledge about
chip specificity should be required to read from and write to the sysfs
interface files. This hopefully should let us have a much simpler
library to access this information, with no chip specific data. The
library we have for now needs to be updated as soon as new drivers are
written or old drivers are changed.

So I invite you to submit a file names proposal on this list, as
detailed as possible when it comes to the reasons of your choices each
time it isn't obvious (and possibly even when it seems to be). We'll
discuss it together to make sure it will be a safe base for future video
drivers as well, and then you can go coding ;)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
