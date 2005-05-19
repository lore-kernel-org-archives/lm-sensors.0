From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <20040512212245.GA17307@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 12, 2004 at 02:12:45PM -0700, Philip Pokorny wrote:
> bash can handle bit operations just fine.
> 
> bash$ echo $(( 7 & 2 ))
> 2
> bash$ echo $(( 8 & 2 ))
> 0

Heh, you can tell I am not a good bash programmer :)

> So that shouldn't be a concern.

Ok, nevermind.

> I'd like to make another suggestion.  Put meaningful text strings as the 
> contents of the _status file:
> 
>   LOW  (for low alarm)
>   HIGH  (for high alarm)
>   FAIL  (for diode failure)
>   ALARM  (for generic alarm)
>   HIGH, FAIL  (for multiple alarms)
>   ""  (null string for no alarm)
> 
> Then the sensors library and other tools/languages can just "cat" the 
> contents to get the status and test for non-null string to see if there 
> is an active alarm or not.

Ah, I like this even better.  We would never need to display more than
one status at a time per device, right?

thanks,

greg k-h
