From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 07 Nov 2014 09:15:27 +0000
Subject: Re: [lm-sensors] Fancontrol memory consumption
Message-Id: <20141107101527.3dcbebb6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141105175729.39a88ab1@endymion.delvare>
In-Reply-To: <20141105175729.39a88ab1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 5 Nov 2014 17:57:29 +0100, Jean Delvare wrote:
> As I can reproduce the issue, I tried it myself, and my results are as
> follows:
> bash 3.0.16: Memory consumption (RSS) is steady
> bash 3.1.14: Memory consumption (RSS) increases
> bash 4.2.53: Memory consumption (RSS) increases
> bash 4.3.30: Memory consumption (RSS) increases
> 
> So apparently this is a regression introduced in bash 3.1 and not fixed
> yet.

I have created a ticket to track this issue:

http://www.lm-sensors.org/ticket/2391

After discussing the issue with upstream bash maintainer Chet Ramey,
this is not a memory leak and works as intended, even though this
behavior is undesirable in the case of the fancontrol script.

Taz, feel free to try the following experimental patch for the time
being, I believe it should solve the increasing memory consumption
issue:

---
 prog/pwm/fancontrol |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lm-sensors.orig/prog/pwm/fancontrol	2014-11-05 22:59:21.823226428 +0100
+++ lm-sensors/prog/pwm/fancontrol	2014-11-07 09:52:14.178257104 +0100
@@ -546,7 +546,7 @@ function UpdateFanSpeeds
 		  	echo $minsa > $pwmo
 			# Sleep while still handling signals
 			sleep 1 &
-			wait $!
+			wait
 		  fi
 		fi
 		echo $pwmval > $pwmo # write new value to pwm output
@@ -585,5 +585,5 @@ do
 	UpdateFanSpeeds
 	# Sleep while still handling signals
 	sleep $INTERVAL &
-	wait $!
+	wait
 done


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
