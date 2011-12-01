From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Dec 2011 17:29:08 +0000
Subject: Re: [lm-sensors] How to get patches and build with them?
Message-Id: <20111201182908.1e84be44@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4ED7B66A.6030009@catcons.co.uk>
In-Reply-To: <4ED7B66A.6030009@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

On Thu, 01 Dec 2011 22:46:26 +0530, Charles wrote:
> Hello :-)
> 
> I want to build lm_sensors *3.3.1 *and see from
> http://www.lm-sensors.org/wiki/Download that four patches are
> recommended.  How do I download the patches and incorporate them during
> the build?

Click each link, then scroll to the bottom of the page and choose
"Unified Diff". I then recommend running dos2unix on all patches as for
some strange reason trac produces DOS format text files. Then just
apply the patches in order with patch -p2.

I'll let you appreciate which of these patches you actually want. I'm
the one making the selection but it's often arbitrary and every case is
different.

> I appreciate this is a common procedure and there must be some
> instructions somewhere; a link to instructions would be helpful.

It's no so common, I think. The list of patches is mainly there for
packagers. End-users are supposed to simply install packages from their
distribution. As a matter of fact, I think you're the first one asking
for help with this since I started maintaining this list 4 years ago.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
