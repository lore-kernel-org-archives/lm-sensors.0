From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <Pine.OSF.4.50.0301120843190.23868-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Jan 2003, Mark Studebaker wrote:

> Due to the recent discussions re: kernel 2.5.54, and
> the lack of any critical problems with 2.7.0,
> I declare the two weeks over in record time :)
>
> If you intend to do any of the 2.4 cleanup you may wish
> to let people know.

Okay. I have i2c tree under inspection, removing any < 2.4 #ifdefs.
I understand you gave a green light for these commits?

Once done with that, I would like to branch in CVS for 2.5
development, and trace back changes from Linus's tree.

Also, i2c headers could use a cleanup there.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
