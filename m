From: esr@thyrsus.com (Eric S. Raymond)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: problems in one or more man pages you maintain
Message-Id: <20040712223812.GB22684@thyrsus.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407121514.i6CFEqXm017215@snark.thyrsus.com>
In-Reply-To: <200407121514.i6CFEqXm017215@snark.thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org>:
> This change, as is, is certainly not acceptable as it discards an
> information I consider important for the reader.

In that case, you'kll vbe stuck as one of the 4% or fewer man pages 
that does not convert.
 
> BTW, why doesn't DocBook accept parenthesized comments in synopsis?

The DTD for synopsis-syntax structure doesn't allow it.

> DocBook is mostly XML if I'm not mistaking, I don't see how parentheses
> cause any problem. What are you going to do for C manual pages, which
> all have parentheses in their synopsis?

Another subset of the DTD expresses function syntax.  Doclifter can
translate to that.

> Anyway, if there is a solid reason why DocBook cannot cope with that,
> and if it is not going to be improved, I cannot see why manual pages
> would need to be changed for that. The syntax used in this manual page
> doesn't break any standard as far as I know. If DocBook cannot accept
> it, then your "doclifter" converter simply has to learn how to handle
> that case. Either drop the parenthesized comment, or (better) find an
> alternate syntax to replace the parentheses. Doesn't sound that complex,
> does it?

There isn't any room in the DTD for an alternate syntax.  And one of 
doclifter's design rules is not to throw away information, which is why 
I prefer to negotiate changes with manual page maintainers.  

Is there some other way you can come up with to convey that
information without having it embedded in the option syntax?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
