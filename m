From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: SENSORS_DDCMON_ID not defined in lm_sensors 2.8.1
Message-Id: <20031121205757.77b1a9e5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Just was trying to get sensord to work under lm_sensors 2.8.1, but
> kept getting errors.
> 
> I believe problem is due to the fact that SENSORS_DDCMON_ID appears in
> prog/sensord/chips.c but no longer defined (up until 2.8.0 it was
> defined in lib/chips.h). It appears that the naming convention for
> SENSORS_DDCMON declarations were changed between 2.8.0 and 2.8.1 in
> the chips.h file but not necessarily updated in all the other C files.

You're pefectly right. I improved the ddcmon driver some months ago,
updated the sensors program and library, but forgot about sensord
(mostly because it isn't compiled by default).

I simply removed ddcmon support from sensord. I can't see how DDC data
would change, and I just don't see the point in monitoring constant
values.

You can check lm_sensors2 CVS out to get a working version of sensord.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
