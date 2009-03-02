From: Dieter Jurzitza <dieter.jurzitza@t-online.de>
Date: Mon, 02 Mar 2009 21:23:23 +0000
Subject: [lm-sensors] Question on kernel patch for Atom CPU
Message-Id: <200903022223.23931.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear listmembers,
this one might be answerable by Rudolf Marek. I recently integrated the pat=
ch=20
for Atom CPU in my system. This works perfectly fine with one exception:

Loading coretemp.ko results in the following message:

coretemp coretemp.0: Unable to read IA32_TEMPERATURE_TARGET MSR
coretemp coretemp.1: Unable to read IA32_TEMPERATURE_TARGET MSR

seems harmles but goes into dmesg, and, if possible, I'd like to get rid of=
=20
it. Besides everything is working just fine.

Thank you for providing this patch and thank you for your efforts!
Take care




Dieter Jurzitza

--=20
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <=B0=B0__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
