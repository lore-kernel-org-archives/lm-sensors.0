From: cat@zip.com.au (CaT)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Sensors whackyness under 2.6.x
Message-Id: <20030830012716.GB14943@zip.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815110924.GC501@zip.com.au>
In-Reply-To: <20030815110924.GC501@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 29, 2003 at 05:44:27PM -0700, Philip Edelbrock wrote:
> Once a second might be too fast.  I think the hardware can only go so 
> fast and our driver tries to prevent too many queries in a short amount 
> of time.  You might slow it down to 30 seconds or so.

That might be too slow. From memory it takes less then that for things
to get whacky under load. I'll see what works though. :)

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
