From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: GL520SM Problem
Message-Id: <20040509093546.037db12e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1084022241.6755.316.camel@alpine>
In-Reply-To: <1084022241.6755.316.camel@alpine>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daniel,

Quoting myself:

> I'd also like to insist on the fact that the 2.4 driver seems
> to be broken in several places.

I've fixed a number of issues in the driver:

* Discard unused variable in private driver data.
* Less agressive initialization process (do not reset the chip,
  closes ticket #1154; preserve application mode)
* Fix temp1 (instead of temp2) limits being unsettable in application
  mode 2 (tickets #894 and #1219).
* Ensure that temp2 and in4 are not used at the same time (ticket
  #894).

Please test the CVS version if possible, and take these changes into
account for your 2.6 driver if it applies.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
