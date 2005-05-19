From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: velleman doc
Message-Id: <3FE8CB03.3000300@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031222204231.6db9944c.khali@linux-fr.org>
In-Reply-To: <20031222204231.6db9944c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The driver has said K9000 at the top since the 1.1 revision 1998.
When we got the documentation contribution in 2002, it was about
the K8000, and I put in the K9000 reference at the top, since
I didn't know at the time what was right.
It does seem like there is no 9000; I couldn't find anything either.
If you do patch it, don't forget drivers/i2c/Config.in.

Jean Delvare wrote:
> Hi all,
> 
> The Velleman docs and driver sometimes refer to a K9000 model. Most
> of the time they refer to the K8000 model. After searching the web and
> Velleman's web site, it turns out that no K9000 model exists. Thus I
> suppose that this is a typo and that the driver is really for the K8000.
> 
> May I change the docs and driver in that way? (I would like to do
> so before I send an i2c-velleman patch for inclusion into Linux 2.4.24.)
> 
> Thanks.
> 
