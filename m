From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 23:15:23 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <253818670505191414175ca12@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051703479bd0c29@mail.gmail.com>
	 <e9iUj0EZ.1116327879.1515720.khali@localhost>
	 <2538186705051704181a70dbbf@mail.gmail.com>
	 <253818670505172136613abb43@mail.gmail.com>
	 <20050519220235.3946f880.khali@linux-fr.org>
In-Reply-To: <20050519220235.3946f880.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On 5/19/05, Jean Delvare <khali@linux-fr.org> wrote:
> I finally gave a try to your patches, including the one for it87 which I
> used for testing. It all works like a charm, pretty impressive
> considering the overall complexity of the change. Congratulations :)

I'm impressed too ;), and very happy to finally have confirmation it
works as planned without blowing up anything.

> I'd like to add that the technical solution you came up with pleases me
> much (which may or may not be relevant).

Well I guess a happy Jean doesn't hurt! I really can't accept full
credit for this though, I think the end solution was a good mix of
ideas/comments from a range of people especially Greg, Russell and
you.

I like the idea of aggregating the related sensor attributes into
arrays, I did things the same way in bmcsensors but of course that was
all dynamic, and would just use more memory if we tried to do that
here. As Greg points out there is probably a nicer way to create the
arrays and register the attributes, but the basic idea has merit I
think, and if we can standardize a method across all the sensors then
its even better.

Thanks,
Yani
