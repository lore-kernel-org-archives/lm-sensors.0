From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: Updated ADM1026 driver available for 2.7.0
Message-Id: <3EC99504.7060302@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I made some small updates to the ADM1026 driver.

I've added the fan_div/fan_min updating that Greg KH suggested.

I've improved the GPIO status reporting and updating a bit.

Mostly small fixes and tweaks.

Available as a patch against "stock" 2.7.0 at:

ftp://ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-adm1026-9.patch

I'll make a CVS patch if people are interested...

:v)
