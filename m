From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 21 Apr 2008 23:37:43 +0000
Subject: Re: [lm-sensors] How to get lm-sensors to see eight
Message-Id: <20080421233743.GH15705@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 21, 2008 at 05:37:44PM -0400, Michael Darling wrote:
> I have a HP XW8400 workstation.  It came with a single Intel Xeon E5335, and
> I correctly got lm_sensors installed so I could see the four processor
> temperatures.  (The E5335 is a quad xeon chip.)
> 
> I just installed a second Xeon E5335.  /proc/cpuinfo correctly sees 8
> logical CPUs, however lm_sensors is still reporting temperatures for only 4
> of those logical CPUs.  When I initially installed the machine on a single
> Xeon, I got lm_sensors working correctly, but can't figure out now how to
> expand it from reporting on 4 CPUs to 8.  My experience with lm_sensors is
> extremely limited, so any advice would be much appreciated!

Hmm... if you're running a recent kernel (2.6.23+, I think?) try the
coretemp driver to read the temperature sensors that are on the CPU
die.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
