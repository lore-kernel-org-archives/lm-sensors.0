From: lepalom@wol.es (Leopold Palomo Avellaneda)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Some nice feature
Message-Id: <200310011619.49340.lepalom@wol.es>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I cannot avoid to send you a part of a mail that I have read in the beowulf 
list, we have talking about the option to use lmsensors to monitorizing the 
cluster with a cron command. Someone have said that is not a good option, so 
says:


[....]
On a system equipped with an internal sensor, lm_sensors can often read
e.g. core CPU temperature on the system itself.  A polling cron script
can then read this and take action, e.g. initiate a shutdown if it
exceeds some threshold.

The bad thing is that it does NOT give you any sort of measure of room
temperature per se, although if you have the poweroff script send you
mail first, getting deluged with N messages as the entire cluster shuts
down would be a good clue that your room cooling failed:-).  Also,
lm_sensors has the API from hell.  In fact, I would hardly call it an
API.  One has to pretty much craft a polling script on the basis of each
supported sensor independently, which requires you to know WAY more than
you ever wanted to about the particular sensor your system may or may
not have.

Alas, if only somebody would give the lm_sensors folks a copy of a good
book on XML for christmas, and they decided to take the monumental step
of converting /proc/sensors into a single xml-based file with the
RELEVANT information presented in toplevel tags like

  <cpu_temp id="0" units="C">50.4</cpu_temp>

and the irrelevant information presented in tags like

  <hardware><name>lm78</name><version>1.22a</version></hardware>

then we could ALL reap the fruits of their labor without needing a copy
of the lm78 version 1.22a API manual and having to write an application
that supports each of the sensors THROUGH THEIR INTERFACE one at a
time...;-)

[....]

What do you think?

Best regards,

Leo
