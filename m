From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 26 Sep 2006 15:43:46 +0000
Subject: [lm-sensors] SVN/trac requests
Message-Id: <45194AB2.6040401@otaku42.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926140502.00d29dd5.khali@linux-fr.org>
In-Reply-To: <20060926140502.00d29dd5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

Axel Thimm wrote:
  > Hm, I don't have a solution. First of all I wouldn't loop it through
> trac, but use the direct svn URL instead, e.g.
> 
> http://lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
> 
> But this has the same issue, so it doesn't solve the issue at hand.
> 
> I would guess that the keyword substitution happens at the client, and
> svn/trac offer the raw contents only. :(

Keyword substitution is disabled by default and must be enabled 
explicitly if wanted.

See: 
http://svnbook.red-bean.com/en/1.2/svn.advanced.props.html#svn.advanced.props.special.keywords

Bye, Mike

