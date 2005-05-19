From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: driver design question
Message-Id: <3F255330.8060800@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728153714.7b09e0b7.khali@linux-fr.org>
In-Reply-To: <20030728153714.7b09e0b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I think we should try to read and report what we know.  If we don't read 
the limits, we probably shouldn't report them either (i.e. make them 
write-only).  Reducing overhead by introducing assumptions in the code 
(like that limits won't change), is a bad idea, imho.  At least, I think 
this is more important at the driver level than the user-space apps.

Are we having problems with performance and overhead issues?


Phil

Jean Delvare wrote:

>Hi all,
>
>Reading some code today, I noticed that most of our drivers, if not all,
>read the current values and the limit values when updated. Why that? I
>would have read the current values only. We set the limits ourself
>(either at init time or through procfs/sysfs) so they are unlikely to
>have changed. Looks like an overhead we could easily get rid of. Is
>there something obvious I am missing?
>
>Thanks.
>
>  
>
