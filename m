From: shaul Karl <shaulkarl@yahoo.com>
Date: Wed, 05 Nov 2008 19:52:54 +0000
Subject: Re: [lm-sensors] tempx_max_hyst > tempx_max?
Message-Id: <994860.56767.qm@web58506.mail.re3.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <157004.2853.qm@web58501.mail.re3.yahoo.com>
In-Reply-To: <157004.2853.qm@web58501.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I suggest the following:

--- sensors3.conf  2008-11-02 19:06:45.000000000 +0200
+++ sensors3.conf       2008-11-05 21:49:27.000000000 +0200
@@ -192,7 +192,19 @@
 #
 # Think of tempx_max as 'alarm set' and tempx_max_hyst as 'alarm clear'
 # thresholds. In most cases the 'max' value should be higher than
-# the 'max_hyst' value by several degrees.
+# the 'max_hyst' value by several degrees. Obviously, having them equal
+# disable the hysteresis mechanism. Many chips will not accept the
+# 'max_hyst' value higher than the 'max' value because internally they
+# store the hysteresis as a delta to the max limit. Other chips will
+# behave in this case as if max_hyst = max, and some may even misbehave,
+# clearing the alarm even though the measurement is above the max limit.
+# There's one exception though: some chips out there disable the
+# hysteresis mechanism or even change the interrupt behavior or even
+# change the interrupt behavior when the hysteresis is set to special
+# value 127. Unfortunately, there is no way for the drivers to expose
+# this property to user-space, so you have to know how if your chip
+# does that. Once again, the bottom line is that the 'max' value should
+# be higher than the 'max_hyst' value by several degrees.
 #
 # All the set statements from this file are commented out by default.
 # The reason is that the proper limits are highly system-dependent,


--- On Wed, 11/5/08, Jean Delvare <khali@linux-fr.org> wrote:

> From: Jean Delvare <khali@linux-fr.org>
> Subject: Re: [lm-sensors] tempx_max_hyst > tempx_max?
> To: shaulkarl@yahoo.com
> Cc: lm-sensors@lm-sensors.org
> Date: Wednesday, November 5, 2008, 9:05 PM
> On Sun, 2 Nov 2008 07:17:58 -0800 (PST), shaul Karl wrote:
> > etc/sensors3.conf of lm-sensors-3 (1:3.0.2-1+b2) in
> Debian states that
> > 
> >     # Think of tempx_max as 'alarm set' and
> tempx_max_hyst as 'alarm clear'
> >     # thresholds. In most cases the 'max'
> value should be higher than
> >     # the 'max_hyst' value by several degrees.
> > 
> >   In what cases would you set the 'max' value
> equal to the 'max_hyst'
> > value?
> 
> If you want to disable the hysteresis mechanism.
> 
> > Is it pointless for the 'max_hyst' value to be
> higher than the
> > 'max' value? 
> 
> Yes it is, and many chips will not even let you do that
> because
> internally they store the hysteresis as a delta to the max
> limit. Other
> chips will behave as if max_hyst = hyst, and I suspect
> some may even
> misbehave, clearing the alarm even though the measurement
> is above the
> max limit.
> 
> There's one exception though: some chips out there
> disable the
> hysteresis mechanism or even change the interrupt behavior
> when the
> hysteresis is set to special value 127. There is
> unfortunately no way
> for the drivers to expose this property to user-space, so
> you have to
> know how if your chip does that.
> 
> >   I would say that the last statement about
> tempx_max_hyst > tempx_max
> > is confusing.
> 
> And I would say you did not read this statement carefully.
> All the
> value of this statement is in the last 3 words.
> 
> -- 
> Jean Delvare


      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
