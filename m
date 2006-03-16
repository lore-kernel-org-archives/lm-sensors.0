From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Mar 2006 10:58:20 +0000
Subject: [lm-sensors] alarm files one file per sensor vs file with
Message-Id: <TIccfRFe.1142506700.0413450.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <441940D4.2050107@hhs.nl>
In-Reply-To: <441940D4.2050107@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hans,

On 2006-03-16, Hans de Goede wrote:
> Jean I would like to submit a version of the abituguru for merging, but
> I would like to modify it (if needed) to match your decision on this
> first. Can you take a decisision on this please?
>
> Or shall I just submit the abituguru driver as is and submit an update
> if needed later?

No, let's decide now and have your driver follow that decision right
away, that's less work for everyone, and will let you do the user-space
part faster too.

We will go with individual alarm files, as I had been proposing. I will
not have the time to submit a new documentation patch before next week,
but basically it's just what my previous patch was saying. Follow the
same naming scheme for beep, alarm_mask and shutdown (the later two
being only used by your driver AFAIK.)

Hans, I'd like to thank you for your constructive criticism with regards
to this technical choice we had to make. Some of your objections had
great merit and without Greg (and others) clearly speaking in favor of
individidual files, I would have had a hard time taking a decision. I
really hope that the sysfs polling capabilities Greg has been mentioning
will let us speed up user-space when writing this new library I have in
mind. I have to admit I don't quite see how at the moment, though.

Now I understand that its not the best thing that could happen for your
abituguru driver, but this is really only one driver amongst four
dozens, and almost all other drivers will be better with this approach.

Thanks (and sorry for being slow),
--
Jean Delvare

