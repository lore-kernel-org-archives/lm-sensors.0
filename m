From: jcromie@divsol.com (Jim Cromie)
Date: Wed, 20 Jul 2005 21:57:19 +0000
Subject: [lm-sensors] sensors.conf compute syntax, doc
Message-Id: <42DEAC87.1050607@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


wrt compute, the syntax is doc'd to require 2 conversion formulas,
separated by commas.

However, the formulas in debian's sensors.conf are reciprocal / inverse
 - one fully specifies the other, and Id expect to find that the case 
virtually everywhere.

I tested this theory of 1 compute statement by commenting out one formula.
sensors -s  reports a syntax error, unexpected EOL,
but sensors works as normal.
Was this just lucky ?

Is it reasonable that 1 formula becomes the norm,
and 2 the exceptional situation (when an inverse function isnt correct,
and which requires the comma)
