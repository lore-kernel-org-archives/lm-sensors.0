From: ttoohey@toowards.com (Tim Toohey)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: segfault in sensord (lm_sensors2 2.8.5)
Message-Id: <200403080911.40544.ttoohey@toowards.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

In prog/sensord/rrd.c (since revision 1.5 I think) there's a null pointer 
dereference when used with the --load-average option. This seems to only be a 
problem when initialing creating the rrd log file (though I'm not sure).

Below is my fix.

Thanks,
Tim Toohey

cvs diff: Diffing .
Index: rrd.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/rrd.c,v
retrieving revision 1.7
diff -r1.7 rrd.c
198c198
<     switch (feature->type) { /* arbitrary sanity limits */
---
>     switch (feature!=NULL ? feature->type : 0) { /* arbitrary sanity limits 
*/
