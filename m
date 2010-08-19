From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Aug 2010 13:37:23 +0000
Subject: Re: [lm-sensors] pwmconfig doesn't detect correlations properly
Message-Id: <20100819153723.5fcdd038@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
In-Reply-To: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Charles,

> On Thu, Aug 19, 2010 at 6:36 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > I think I would prefer a radically different approach:
> >
> > pwm1_enable=0
> > pwm2_enable=0
> > wait...
> > for each PWM:
> >   this pwm_enable=1
> >   this pwm=0
> >   for each fan
> >      check and store fan speed
> >   next fan
> >   this pwm_enable=0
> >
> >   for each fan
> >      verify fan speed returned to normal
> >   next fan
> >
> >   for each fan
> >      check stored fan speed
> >      if speed lower than threshold:
> >          mark fan as controlled by this pwm
> >   next fan
> > next pwm
> >
> > This idea is to split the inner for loop into individual actions. This
> > requires more code, but when dealing with hardware, doing the right
> > thing in a timely manner is more important than saving a couple lines
> > of code and CPU cycles. My approach has three merits:
> > * It is more obviously correct (or, if the code is broken, more
> >  obviously broken.) Each inner for loop will do only one thing, so
> >  hopefully it will do it well.
> > * It limits the number of PWM on/off to the minimum, as well as the
> >  zero duty cycle time (fan potentially off).
> > * It warns about stuck fans faster than other approaches do.
> >
> > Opinions?

On Thu, 19 Aug 2010 20:41:37 +0930, Charles Pillar wrote:
>    Thanks for your feedback. Jean that suggestion looks great to me, I
> guess I was going for the minimal approach, just in case I was stark
> raving mad :P but I agree, what you proposed does look like a better
> way to go.

Hmm, in the end I came up with the following fix, which is quite
different from my proposed implementation, but also way less intrusive.
The two parts could even be committed separately, as they fix different
bugs. The upper part of the patch fixes the problem you actually
reported. The lower part of the patch fixes redundant sleeps in case a
given PWM output controls more than one fan.

Can you please try this patch and confirm that it solves your problem?

Index: prog/pwm/pwmconfig
=================================--- prog/pwm/pwmconfig	(révision 5853)
+++ prog/pwm/pwmconfig	(copie de travail)
@@ -437,15 +437,19 @@
 		echo '^C received, restoring PWM and aborting...'
 		exit 1
 	fi
+
+	# Sample all current fan speeds at once, so that we can quickly
+	# disable PWM.
+	CURRENT_SPEEDS="`cat $GOODFAN`"
+	pwmdisable $i
+
 	let pwmactivecount=0
 	let count=1
 	for j in $GOODFAN
 	do
 		OS=`echo $SPEEDS | cut -d' ' -f$count`
-		# this will return the first field if there's only one (sysfs)
-		S=`cat $j | cut -d' ' -f2`
+		S=`echo $CURRENT_SPEEDS | cut -d' ' -f$count`
 		echo "  $j ... speed was $OS now $S"
-		pwmdisable $i
 		let threshold=2*$OS/3
 		if [ $S -lt $threshold ]
 		then
@@ -460,16 +464,18 @@
 				pwmactive="$i ${pwmactive}"
 				fanactive="$j ${fanactive}"
 				fanactive_min="$S ${fanactive_min}"
+
+				# Give the fans time to return to full speed
+				sleep $DELAY
+				if [ $? -ne 0 ]
+				then
+					echo '^C received, aborting...'
+					exit 1
+				fi
 			else
 				fanactive="$j+${fanactive}" #not supported yet by fancontrol
 				fanactive_min="$S+${fanactive_min}"
 			fi
-			sleep $DELAY
-			if [ $? -ne 0 ]
-			then
-				echo '^C received, aborting...'
-				exit 1
-			fi
 			# this will return the first field if there's only one (sysfs)
 			S=`cat $j | cut -d' ' -f2`
 			if [ $S -lt $threshold ]


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
