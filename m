From: mail@schaefer-raumgestaltung.de (=?iso-8859-1?Q?Sch=E4fer_Raumgestaltung?=)
Date: Sun, 30 Oct 2005 11:26:14 +0000
Subject: [lm-sensors] Re: 87431 update
Message-Id: <002b01c5dd3d$06e40ec0$fe78a8c0@doppelhertz>
List-Id: <lm-sensors.vger.kernel.org>
References: <435BD852.9040703@mds.gotdns.com>
In-Reply-To: <435BD852.9040703@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,


>Hmm it's basically working but the fan and temp values aren't read.
>Perhaps there was a sysfs name change in 2.6.13?

Do you have any idea how to check this ?
is anyone of your lm_sensors crew involved in SUSE's  OPENSUSE development ?

>Do you have sensors 2.9.2? (sensors -v)

I had sensors 2.9.1 (delivered with Suse 10.0)
now updated to sensors 2.9.2....  no effect

>
>For the labels in 'sensors', copy the label statements that appear in dmesg after bmcsensors module load
>and copy it to the bmcsensors section of /etc/sensors.conf.

OK: this will show the correct labeling but still get wrong/no reading and incorrect min/max values

e.g. from sensor:

001a SDR Full 01 34 20 04 snum 25 Proc1 Fan        = 0f OK   5602.24 RPM

from sensors:
MY_CHANGED_LABEL_FAN:        0 RPM  (min = 1343 RPM)


hope you can help me

Uli
