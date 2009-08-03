From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 03 Aug 2009 12:27:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Create a DIV_ROUND_CLOSEST macro to do
Message-Id: <1249302441.7924.70.camel@twins>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
	 <1249300672.7924.53.camel@twins> <20090803142138.51738a18@hyperion.delvare>
In-Reply-To: <20090803142138.51738a18@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Julia Lawall <julia@diku.dk>

On Mon, 2009-08-03 at 14:21 +0200, Jean Delvare wrote:
> > The proposed thing is simply DIV_ROUND, but this DIV_ROUND_CLOSEST name
> > is just wonky.
> 
> I can't disagree. I even think I argued about it back then, but then
> finally gave up. You should have participated in the debate when it was
> hot rather than 8 months later :(

Yeah, sometimes its hard to keep up with all on lkml, I only noticed it
because I ran into some code that used it.

Agreed on the other points.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
