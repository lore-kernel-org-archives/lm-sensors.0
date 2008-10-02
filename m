From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 02 Oct 2008 15:39:49 +0000
Subject: Re: [lm-sensors] Looking for IT8720 datasheet.
Message-Id: <20081002173949.16d9caaf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
In-Reply-To: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean-Marc,

On Thu, 2 Oct 2008 11:25:27 -0400, Jean-Marc Spaggiari wrote:
> Does any one have the IT8720 datasheet? In ticket #2343,
> http://www.lm-sensors.org/ticket/2343 sound like the datasheet is now
> available ("We have a datasheet now.").

We have it but it's not public yet, so we can't redistribute it.

> Is there a way to get this datasheet? I'm building a patch for it87.c.
> It's working pretty fine with my motherboard, but I would like to
> double check with the datasheet before submiting the patch to LKML.

Please get in touch with Frank Myhr (Cc'd), who is supposedly working
on this already. Please do not duplicate the work here. Ideally, if
Frank is done with the code, you could give it a public review, and
then the code can be merged.

Patches should be submitted to the lm-sensors list rather than LKML.
While we still do not have a hwmon subsystem maintainer, you are more
likely to find reviewers and testers on the lm-sensors list than on
LKML.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
