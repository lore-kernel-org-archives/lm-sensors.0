From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Dec 2010 16:58:58 +0000
Subject: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101209165858.GA521@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am looking through libsensors and the hwmon sysfs ABI to identify and fix
inconsistencies.

One problem I noticed is powerX_alarm, which is defined as "system is drawing
more power than the cap allows".

powerX_cap is defined as " ... The *_cap files only appear if the cap is known
to be enforced by hardware".

Now there are conditions where power limits are defined and supported,
but the hardware does not enforce it. Similar, there are devices reporting power
alarms not associated with cap enforcement. Examples are ltc4215 and PMBus devices.
powerX_alarm is supported by the ltc4215 driver, but there is no _cap attribute,
and the alarm is not associated with a maximum, thus a reported alarm doesn't
really reflect the ABI.

I see a number of options:

1) Introduce powerX_max as unenforced "max" attribute, in addition to powerX_cap.
   1a) Introduce powerX_cap_alarm to reflect alarms associated with powerX_cap,
       introduce powerX_max_alarm, and redefine the semantics of powerX_alarm 
       to include all possible alarms
   1b) Redefine semantics of powerX_alarm to include all possible reasons for
       power alarms.

2) Redefine the semantics of powerX_cap to include unenforced maximum power.
   Redefine powerX_alarm to include all possible reasons for alarms.

My preferred solution would be 1) with 1b), though 2) would be fine for me as well.
Any thoughts / comments ? 

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
