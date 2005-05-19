From: jnareb@fuw.edu.pl (Jakub Narebski)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ticket #: 758, ITE IT8712F-A not detected, and not  properly
Message-Id: <Pine.LNX.4.33.0201041743230.18411-100000@flow.fuw.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0112191715470.14694-100000@flow.fuw.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0112191715470.14694-100000@flow.fuw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 4 Jan 2002, Mark Studebaker wrote:

> please rerun with the correct arguments
> 'isadump 0x295 0x296'

O.K.

> I can look at boosting the confidence for the it8712 detection
> from 7 to 8 so it will be recommended over the lm78.

What for? it87 and lm78 both have _the very same_ confidence. lm87 is
recommended over it87 only because it _comes first_. I think that if the
conflicting chipsets have the same confidence then the choice should be
left to user (look at your motherboard) and no chip should be preffered
over other.

-- 
Jakub Nar?bski
    Poland
