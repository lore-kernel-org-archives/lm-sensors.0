From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Aug 2006 17:04:50 +0000
Subject: [lm-sensors] Call for 2.10.1
Message-Id: <20060821190450.76089f80.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060819105454.c6c438ed.khali@linux-fr.org>
In-Reply-To: <20060819105454.c6c438ed.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

> I missed the original post (to many mails, so trigger happy delete
> finger) as already described I'm working on an abituguru2 driver for a
> new much different version of the abituguru2. I would like to merge the
> userspace support for this (and only the userspace) before 2.10.1 if
> there is some time for this, so 1 questions:
> 1) is it ok to merge userspace support for a not yet released kernel
>    driver?

Yes it is, as long as you are reasonably certain that the driver's
interface won't change by the time it is merged.

> 2) how much time do I have before 2.10.1 ?

SVN freeze is scheduled for September 5th.

-- 
Jean Delvare

