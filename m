From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Donation.
Message-Id: <20031101201315.GB29367@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
In-Reply-To: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-11-01 19:51:32 +0100]:
> 
> Just opened my two cases, nothing interesting in the first one (there's
> a mysterious 3-pin port named PWRATX (if I read it correctly) but it
> doesn't sound like what I am after) but there is a 4-pin port named SMB
> on the second one (ATV133-C). It damn sounds like what you're talking
> about. I guess that these pins are +VCC, ground, SCL and SDA? Any idea
> about the order? Pin 1 is alone, then there's a hole, then three more
> pins.

Actually, these are described in the users' manuals, at least for my
boards.  Both of my boards have five pins in a six pin block, like this:

(1) FLOATING
 *  SMBCLK
    (no pin)
 *  Ground
 *  SMBDATA
 *  +3V

With a voltmeter, you can at least determine +3V and ground.  And it
will do no harm to the hardware if you reverse SCL/SDA (besides 
simply not working).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
