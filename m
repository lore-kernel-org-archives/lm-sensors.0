From: bezaur@gmail.com (Charles Spirakis)
Date: Fri, 03 Feb 2006 18:17:34 +0000
Subject: [lm-sensors] kernel driver (2.6.15.1) for w83791d...
Message-Id: <5bfe43f80602031017u1e588306v9a51ce258b65d479@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All --

I noticed that there is partial support for the w83791d chip in the
older 2.4 drivers but not in the 2.6 kernel drivers. In looking at the
chip datasheets, it appears that the 83791d is somewhere between the
83781d and 83792d, but different enough that it seemed like the right
answer was a new driver file (based partially on the w83781d and
partly on the w83792d).

I have the a patch for the 2.6.15.1 tree available, but I also have a
couple of questions:

1) Should I just post the patch on this mailing list or is there some
sort of repository where I should place it (the patch is ~1700 lines)?
2) Is this the right place for this discussion?
3) Any suggestions on how to get this into the 2.6 kernel tree?

Thanks!

-- charles

