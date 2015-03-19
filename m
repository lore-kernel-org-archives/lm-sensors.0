From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 19 Mar 2015 16:33:35 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] util_macros.h: add find_closest() macro
Message-Id: <20150319123335.3b6ce5e8@gandalf.local.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426775420-31350-1-git-send-email-bgolaszewski@baylibre.com>
	<1426775420-31350-2-git-send-email-bgolaszewski@baylibre.com>
	<20150319120323.375ff43c@gandalf.local.home>
	<CAMpxmJUWWVi3wWBBjJOAs=VM0q_Q4+HSBj+n6cMObePwN8LDzQ@mail.gmail.com>
	<20150319123224.5cbef752@gandalf.local.home>
In-Reply-To: <20150319123224.5cbef752@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 19 Mar 2015 12:32:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 19 Mar 2015 17:28:47 +0100
> Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:
> 
> 
> > Definitely a good idea - it should probably be added to section 12 of
> > the CodingStyle doc. What does 'fc' stand for?
> 
> fc = "find_closest" ;-)
> 

I originally was going to suggest "__find_closest_<var>_" but then it
got a bit messy. But maybe that would be better, as it make it even
more likely not to have name collisions.

-- Steve

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
