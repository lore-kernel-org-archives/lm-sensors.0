From: James Cloos <cloos@jhcloos.com>
Date: Wed, 27 Apr 2011 17:31:55 +0000
Subject: Re: [lm-sensors] f71889ed temp alarm polarity reversed.
Message-Id: <m3vcxzmwgs.fsf@jhcloos.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3wrikmw1g.fsf@jhcloos.com>
In-Reply-To: <m3wrikmw1g.fsf@jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "JD" = Jean Delvare <khali@linux-fr.org> writes:

JD> Actually value 100000 and directory /sys/class/hwmon/hwmon#,
JD> or /sys/class/hwmon/hwmon#/device. But it may be easier to add:

JD> chip "f71889ed-*"

JD>    set temp1_max   90
JD>    set temp1_crit 100
JD>    set temp3_max   90
JD>    set temp3_crit 100

JD> to /etc/sensors.d/f71889ed.conf and run "sensors -s".

That alleviated the false alarms.  Thanks.

The fact that the temp sensor which is not connected was not in alarm,
whereas the two which are were, led to my false diagnosis.

Thanks both!

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
