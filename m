From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <WrfYjmjl.1115647014.3607340.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Yani,

> The naming might make the distinction in use, but nothing is really
> stopping anyone from using one or the other and it might even confuse
> further (i.e. not understanding the difference, using both, using the
> wrong one). Since the two would be mutually exclusive I also can't
> help feel it would be a waste of space. Maybe naming the macro that
> sets the data member to something appropriate would help?

If both are actually mutually exclusive, you could use a union in the
struct definition.

Also, if we go for two different attributes, wouldn't it make sense to
have the static one an int and the per-instance one a void*? I keep
thinking that a pointer for the static case won't be of any help and is
actually error-prone.

That being said, these are only my random thoughts on the topic. I am not
going to make a decision or even emit an authoritative opinion here
(especially not when it seems that Greg has different views). Hopefully
I'll be back "soon", the worst seems to be behind me now.

Thanks,
--
Jean Delvare
