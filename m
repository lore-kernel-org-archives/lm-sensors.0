From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Ticket #1903: More information
Message-Id: <4217C2BA.4080702@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050219181847.GI32598@gaast.net>
In-Reply-To: <20050219181847.GI32598@gaast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't remember seeing the patch before, I must have missed it.
It looks like the patch is big but mostly indenting so I'll have to figure out
exactly what it's doing.
I'll also have to study the old IPMI spec a little more.
thanks for the pointer
mds


Wilmer van der Gaast wrote:
> Hello,
> 
> I hope this is the right address to add info to tickets, because I can't
> really find out on the site how to add info.
> 
> I found the following patch in a posting in your mailing list archives:
> 
> http://bubble.nsys.by/projects/ipmi/
> 
> It adds support for IPMI 0.9 to the module. Coincidentally, I found out
> that my board only supports the IPMI 0.1 specification. Pretty old
> indeed. And it looks like the 0.9 patch also makes 0.1 implementations
> work.
> 
> Is this patch not yet well-tested, or is there another reason for it not
> being in the main tree yet?
> 
> Meanwhile, I'll try to find the time to make this patch work with Linux
> 2.6 and I'm done. :-)
> 
> Also found out that changing the fans won't work for me anyway, because
> most fans are controlled by the System Management Controller, which
> can't really be controlled from software, it seems. :-(
> 
> 
> Greetings,
> 
> Wilmer van der Gaast.
> 

