From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Mail filtering
Message-Id: <20020930140014.Q20006@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


BTW- For those who want a little help wading through the spam, I'm
running the mail through a set of procmail filters from the
'spambouncer' package.  Look for lines in the header like this:

    X-SBClass: Blocked

It means that it is 90% likely that it is spam, although it could
still be legit.  You should be able to sort your mail using this line
to make life a little easier.

Other mail (like 99% match to spam, known virii, and bounces) should 
automaticly be screened now.


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
