From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Nov 2006 14:03:17 +0000
Subject: [lm-sensors] sensord and missing alarms
Message-Id: <20061121150317.6cb8b148.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061110190557.GA25801@dbz.icequake.net>
In-Reply-To: <20061110190557.GA25801@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 17 Nov 2006 12:58:50 -0600, Ryan Underwood wrote:
> On Fri, Nov 17, 2006 at 07:30:30PM +0100, Jean Delvare wrote:
> > In general, alarm flags work as intended and applications can use them.
> > Only the W83781D causes trouble, and it's just bad luck that this is
> > the chip you are using. So for the W83781D, yes, comparing the readings
> > with the limit values is better.
> 
> What luck.  Should it be considered a bug that W83781D has alarm
> behavior inconsistent with the rest of the sensors?

I'd say so, yes.

-- 
Jean Delvare

