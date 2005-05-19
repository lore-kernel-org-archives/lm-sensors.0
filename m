From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: sensors-detect problem in CVS 2.6.4 -- patch included
Message-Id: <20020612155302.K1893@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020612223708.GA8506@avalon.paulsen.org>
In-Reply-To: <20020612223708.GA8506@avalon.paulsen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Ah, good catch.  Thanks.  It's now fixed in CVS.


Phil

On Wed, Jun 12, 2002 at 05:37:08PM -0500, Robert C. Paulsen Jr. wrote:
> Minor problem in sensors-detect. Here is the output from cvs diff:
> 
> > cvs diff prog/detect/sensors-detect
> Index: prog/detect/sensors-detect
> =================================> RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
> retrieving revision 1.167
> diff -r1.167 sensors-detect
> 103c103
> <        procid => "Intel 82801DB ICH4,
> ---
> >        procid => "Intel 82801DB ICH4",
> 
> -- 
> Robert C. Paulsen, Jr.
> robert@paulsenonline.net

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
