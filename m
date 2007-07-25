From: "Jean Delvare" <khali@linux-fr.org>
Date: Wed, 25 Jul 2007 09:46:52 +0000
Subject: Re: [lm-sensors] lm78 platform driver conversion breaks certain
Message-Id: <P9gkwQIU.1185356812.5992730.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A65C7B.6030905@hhs.nl>
In-Reply-To: <46A65C7B.6030905@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hans,

On 7/24/2007, "Hans de Goede" <j.w.r.degoede@hhs.nl> wrote:
>Please go here:
>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id$9428
>
>For the full story. I think this is caused by this patch:
>http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019227.html
>
>Where you not only converted it to a platform driver but also made the
>detection more stringent (shouldn't that have been a seperate patch?).

You're right, it should have been a separate patch, sorry for the mess :(

>I'll be working with the reporter to see whats up, but since you are the
>expert your input would be valued very much. I think the easiest would be
>if you could join the discussion in Fedora's bugzilla. Setting up an
>account is a breeze.

I copied the (better) detection code from sensors-detect, thinking that
we would know by now if it wasn't working correctly, so I did not
expect any regression. But for some reason I missed one of the possible
chip IDs for the LM78 in the process. It seems that you already found
out. Thanks for fixing my bugs.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
