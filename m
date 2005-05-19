From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: vid scaling does not belong in kernel?
Message-Id: <poj451p29osdumi4t5cku1o8bs40m3rccf@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
In-Reply-To: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 05 Apr 2005 00:31:35 -0700, Philip Pokorny <ppokorny@penguincomputing.com> wrote:

>One thing that comes to mind is that the mapping of VID to voltage is 
>not a simple linear function. 

The vid voltage mapping is presented in table format on data sheets, 
and I see absolutely no reason to use anything other than a table 
lookup, for that technique provides an audit trail back to data sheet. 

The art of measurement is honesty, not an obfuscated code competition.
"
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
"
Cheers,
Grant.
