From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: lm77 on national sc1100
Message-Id: <20040707215236.13b17bed.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I understand this and do not underestimate the importance of these
> details (and of course I like to read well-aligned code - that's one
> thing I learnt from Python :-) ). Thanks again for your time and
> support, I hope this time I managed to get it right (well, if not,
> next time :)

Almost perfect. Looks like one tab is missing on line 178 of the patch
though ;)

OK, fine with me. We can now send your patch to Greg KH <greg at kroah
dot com>. If possible (i.e. if your mailer won't destroy the patch),
have the patch inlined in your mail. If you cannot do that, Greg accepts
attachements too. Don't forget to sign your patch with a "Signed-off-by:
X <contact info>" line in the mail. You may mention the fact that I
reviewed your code and approved it (it should save Greg some time).
Don't forget to CC this mailing-list too.

Thanks for the good work!

-- 
Jean Delvare
http://khali.linux-fr.org/
