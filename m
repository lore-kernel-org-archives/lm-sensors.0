From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 28 Feb 2007 13:35:10 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <45E5850E.9050105@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Rudolf Marek wrote:
> Hello Ivo,
> 
> Back in the 2004 (12.06.2004 15:04 ;) I collected some DMI strings from 
> different machines, please check the attachment for some summary and 
> bellow for the 2004 raw data.
> 
> Rudolf
> 

Interesting stuff. Ivo, Gijs and Jasper. It looks like we need only need 
to use the "Base Board" info from dmi, but also the "System info" as 
some boards seem to fill "System info" with sensible info while filling 
"Base Board" with less sensible info. I think this isn't hard todo, all 
these fields are defined in the BIOS, and thus motherboard specific, 
they should just all match, otherwise its a different motherboard.

(In case of changes because of BIOS updates we should be able to match 
multiple DMI-table-entries to one motherboard-table-entry. Where with 
table I mean database tables.

Regards,

Hans

