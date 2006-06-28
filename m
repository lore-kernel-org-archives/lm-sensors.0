From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 28 Jun 2006 12:29:58 +0000
Subject: [lm-sensors] The Abit uGuru saga
Message-Id: <44A27646.8020703@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

With the Abit uGuru driver being upstream now it has get some more 
exposure. 3 people sofar have contacted me that the driver does not work 
with the latest generation of Abit motherboards.

One of them has been so kind todo a bit of reverse engineering and has 
managed to give me the correct handshake / protocol to atleast read the 
sensors. I'm pretty confident I've also found the sensor settings (but I 
can only read them for now).

These newer uGuru's while similar are so much different that I think 
they need / warrant a new driver. Putting support for them into the 
current driver would be a big kludge.

With this in mind the question becomes: how do we call this newer 
driver? I'm tending towards the very original "abituguru2" as name. An 
other option would be abit_ac2005 as AC2005 is how Abit seems to call 
them internally (that is what the dll is named in the new windows 
software and the name is used in Abit ini files). However it turns out 
that the older uGuru's are probably called AC2003 by Abit intern, so 
then the name of the older driver would be wrong. Also I don't think 
that calling the drivers AC200X is going to help the end user find the 
correct driver for its motherboard. Maybe abituguru2005 ?

This new uGuru stuff has also lead me to 2 more questions:
1) With the new uGuru I'm able to read a motherboard type from the uGuru
  and with this type I can determine the exact sensor configuration (of
  known motherboards) including the labels for the sensors. Now I really
  want to keep all this knowledge in one place. So I'm thinking about
  giving all the sensors a _label sysfs attribute and write a little
  userspace program which can generate a (part of) sensors.conf based on
  these _label sysfs files. Does this sound ok?

2) The current abituguru will load (as in modprobe) with the newer
  uGuru's and create its platform device, as the simple test done in
  module_init also succeeds on the uguru2005. However the more
  comprehensive test in the drivers probe function fails on the
  uguru2005. This has the end result that when the old driver gets loaded
  on the uguru2005 it will create a:
  /sys/bus/plaform/devices/abituguru.224 dir
  Which is mostly empty.

  Is there anyway to detect the driver probe function failing from
  module_init. so that then the platform device can be destroyed and
  module_init can exit with an error?

Regards,

Hans



