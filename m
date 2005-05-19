From: wilmer@gaast.net (Wilmer van der Gaast)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Ticket #1903: More information
Message-Id: <20050219181847.GI32598@gaast.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I hope this is the right address to add info to tickets, because I can't
really find out on the site how to add info.

I found the following patch in a posting in your mailing list archives:

http://bubble.nsys.by/projects/ipmi/

It adds support for IPMI 0.9 to the module. Coincidentally, I found out
that my board only supports the IPMI 0.1 specification. Pretty old
indeed. And it looks like the 0.9 patch also makes 0.1 implementations
work.

Is this patch not yet well-tested, or is there another reason for it not
being in the main tree yet?

Meanwhile, I'll try to find the time to make this patch work with Linux
2.6 and I'm done. :-)

Also found out that changing the fans won't work for me anyway, because
most fans are controlled by the System Management Controller, which
can't really be controlled from software, it seems. :-(


Greetings,

Wilmer van der Gaast.

-- 
+-------- .''`.     - -- ---+  +        - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  | OSS Programmer   www.bitlbee.org |
|   at   `. `~'  debian.org |  | www.algoritme.nl   www.lintux.cx |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -        +
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050219/9d3eeb61/attachment.bin
