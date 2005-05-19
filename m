From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Problems with Tyan Thunder LE-T
Message-Id: <20031208220942.GJ912@stop.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
In-Reply-To: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 08, 2003 at 10:53:21PM +0100, Jean Delvare wrote:
> > And if you would, can you apply the following patch and let me know
> > what the output (in dmesg) is?  Thanks:
> 
> Tom,
> 
> Your patch doesn't even compile (the temp variable is used in more
> places than you seem to think).

Whoops.

> What's more, my own changes do about the
> same as you want. It'll provide the register value you're after. If we
> have feedback, I'll let you know.

Ok, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
