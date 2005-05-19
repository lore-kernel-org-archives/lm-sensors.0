From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: CVS
Message-Id: <20040427204459.40683bb8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <408C214A.1040502@edgedesign.us>
In-Reply-To: <408C214A.1040502@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Phil,

> >In case you missed it, just wanted to let you know that two security
> >issues have been fixed in cvs 1.11.15. If not done yet, you might
> >consider upgrading.
>
> Thanks! It is updated. I did a quick test and all seems fine. But,
> let me know if something isn't working right.

I have warning messages whenever I commit changes:

"cvs commit: warning:  Set to use deprecated info format strings.  Establish
compatibility with the new info file format strings (add a temporary '1' in
all info files after each '%' which doesn't represent a literal percent)
and set UseNewInfoFmtStrings=yes in CVSROOT/config.  After that, convert
individual command lines and scripts to handle the new format at your
leisure."

I suspect that you updated to a 1.12.x release of CVS while we were
using 1.11.x before. 1.11 is the Stable branch, 1.12 is the Feature
branch. I'd suggest that you move back to 1.11.15, which should work
better for us (and is safe).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
