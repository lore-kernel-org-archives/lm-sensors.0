From: holger.oehm@holger-oehm.de (Holger Oehm)
Date: Fri, 27 May 2005 04:15:56 +0000
Subject: [lm-sensors] Motherboard data collection
Message-Id: <200505270337.38879.holger.oehm@holger-oehm.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505190141.07306.holger.oehm@holger-oehm.de>
In-Reply-To: <200505190141.07306.holger.oehm@holger-oehm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 20 May 2005 10:18, Jean Delvare wrote:
> 
> Hallo Holger,
> 
> > > Unfortunately not, although the need exists and some tries were made.
> >
> > Hmm, they failed? Why? Is it just that collecting the data would mean
> > a *lot* of work? Or would you say it simply cant be done?
> > What if someone would volunteer to give it a try? (Probably one of my
> > worst ideas lately ;-)
> 
> It can be done. The point was to build a system which would require next
> to zero maintenance time: a web interface, where users could easily add
> their own configuration files (wiki-like, in a way). But setting this up
> requires a time and energy investment, which just didn't happen.

Hi Jean,

Well, I invested some energy and time, and here is a URL:

http://sites.inka.de/penti/cgi-bin/lmsensor.pl

It is still a prototype and regrettably uploading sensor.confs does not work
on that webserver. (It did work at home, I suspect that the CGI.pm and/or
perl are too old on that machine).

The stuff is just one perl script using CGI.pm and a C executable I compiled with some
internals of the latest sensors lib (I wanted to make sure configs are valid when 
I store them). It stores uploaded files striped down (only valid tags, no comments) and
compressed.
I am thinking about how to add the possibility to sign configurations (like someone
who uses one of the configs and it works for him, he could sign it somehow (pgp?)).

Could you spare the time to have a look at it? I would appreciate your feedback very
much! 

Best regards,
Holger.

-- 
Holger Oehm <holger.oehm@holger-oehm.de>
Public key <A HREF="http://www.holger-oehm.de/public-key.asc">here</A>,
KeyID: B50E51A9, Key-Length: 1024 Bit,
Key fingerprint: E92A 5C2C 497A 44ED 23C0  DB66 1DD9 3EF7 B50E 51A9
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050527/9208a87d/attachment.bin
