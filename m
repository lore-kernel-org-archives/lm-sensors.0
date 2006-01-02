From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Mon, 02 Jan 2006 16:41:57 +0000
Subject: [lm-sensors] project status and future
Message-Id: <1136220117.4459.50.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AF1E4A.90902@sh.cvut.cz>
In-Reply-To: <43AF1E4A.90902@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all.

On Thu, 2005-12-29 at 23:49 +0100, Rudolf Marek wrote:
> I guess Phul and Michael knows better the workflow and configuration of trac, so
> I can help with the content filling itself. (convert some pages we already have, create new
> docs ideas etc etc.)

I've started to port over content from the old, static website to the
wiki of the lm_sensors Trac. Almost all of the easier pages are already
ported, some are still missing (which are listed at
http://lm-sensors.org/trac/ticket/1 ).

Some of the remaining pages, most notably the "supported devices" and
"new drivers" ones, use tables with cells that span more than one row
and/or column. This type of table can be better rendered when support
for "restructured text" is enabled, see:
http://lm-sensors.org/trac/wiki/WikiRestructuredText - any chance we get
this on the lm_sensors Trac installation?

Something else that I've found while working: it seems there is a
problem regarding the graphics. Pages that have graphics embedded - such
as http://lm-sensors.org/trac/wiki/HardwareHacking - don't show all the
graphics at all. Reloading the page will enable the graphics that were
hidden in the first try, and hide those that were visible. Strange
thing.


By the way: Rudolf found a nice converter which is a great help when
converting HTML to Trac-wiki-markup:
http://diberri.dyndns.org/html2wiki.html .

Bye, Mike


