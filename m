From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Last Call 2.8.2
Message-Id: <3FD4F7A2.9070608@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We've scrubbed the docs. Everyone else please review.
Let's get this release out by the end of the week.

The next release after this one will probably come quickly,
because after our pending patches make it into 2.6.x we'll
need to make corresponding changes in libsensors.

Anything we're waiting for other than the following let us know.


Jean Delvare wrote:

> I've two things left
> on my todo list:
> 
> 1* asb100 in sensors-detect and sensors.conf (see my mail to MMH)
> 
> 2* I had a report that my checksum calculation for VPD records sometimes
> fails. This would make us miss IBM systems. Not had the time to
> investigate the issue yet, will do tomorrow (I hope). The exact
> checksum method isn't decribed in IBM's doc, I thought I had it correct
> but maybe not.
> 

